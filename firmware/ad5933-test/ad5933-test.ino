/*
ad5933-test
    Reads impedance values from the AD5933 over I2C and prints them serially.
*/

#include <Wire.h>
#include "AD5933.h"

#define START_FREQ  (1000)
#define FREQ_INCR   (1000)
#define NUM_INCR    (100)
#define REF_RESIST  (4700)

double gain[NUM_INCR+1];
int phase[NUM_INCR+1];

void printExcelHeader() {
  Serial.println("sweep;freq_hz;real;imag;magnitude_raw;impedance_ohm;phase_raw_deg");
}

void printExcelRow(const char *sweep, unsigned long frequency, int real, int imag, double magnitude, double impedance) {
  double rawPhase = atan2((double)imag, (double)real) * 180.0 / PI;

  Serial.print(sweep);
  Serial.print(';');
  Serial.print(frequency);
  Serial.print(';');
  Serial.print(real);
  Serial.print(';');
  Serial.print(imag);
  Serial.print(';');
  Serial.print(magnitude, 3);
  Serial.print(';');
  Serial.print(impedance, 3);
  Serial.print(';');
  Serial.println(rawPhase, 3);
}

void setup(void)
{
  // Begin I2C
  Wire.begin();

  // Begin serial at 9600 baud for output
  Serial.begin(9600);
  Serial.println("AD5933 Test Started!");

  // Perform initial configuration. Fail if any one of these fail.
  if (!(AD5933::reset() &&
        AD5933::setInternalClock(true) &&
        AD5933::setStartFrequency(START_FREQ) &&
        AD5933::setIncrementFrequency(FREQ_INCR) &&
        AD5933::setNumberIncrements(NUM_INCR) &&
        AD5933::setPGAGain(PGA_GAIN_X1)))
        {
            Serial.println("FAILED in initialization!");
            while (true) ;
        }

  // Perform calibration sweep
  if (AD5933::calibrate(gain, phase, REF_RESIST, NUM_INCR+1))
    Serial.println("Calibrated!");
  else
    Serial.println("Calibration failed...");
}

void loop(void)
{
  // Easy to use method for frequency sweep
  frequencySweepEasy();

  // Delay
  delay(5000);

  // Complex but more robust method for frequency sweep
  frequencySweepRaw();

  // Delay
  delay(5000);
}

// Easy way to do a frequency sweep. Does an entire frequency sweep at once and
// stores the data into arrays for processing afterwards. This is easy-to-use,
// but doesn't allow you to process data in real time.
void frequencySweepEasy() {
    // Create arrays to hold the data
    int real[NUM_INCR+1], imag[NUM_INCR+1];

    // Perform the frequency sweep
    if (AD5933::frequencySweep(real, imag, NUM_INCR+1)) {
      // Print the frequency data
      printExcelHeader();
      for (int i = 0; i < NUM_INCR+1; i++) {
        // Compute impedance
        double magnitude = sqrt(pow(real[i], 2) + pow(imag[i], 2));
        double impedance = 1/(magnitude*gain[i]);
        unsigned long frequency = START_FREQ + ((unsigned long)i * FREQ_INCR);
        printExcelRow("easy", frequency, real[i], imag[i], magnitude, impedance);
      }
      Serial.println("Frequency sweep complete!");
    } else {
      Serial.println("Frequency sweep failed...");
    }
}

// Removes the frequencySweep abstraction from above. This saves memory and
// allows for data to be processed in real time. However, it's more complex.
void frequencySweepRaw() {
    // Create variables to hold the impedance data and track frequency
    int real, imag, i = 0;

    // Initialize the frequency sweep
    if (!(AD5933::setPowerMode(POWER_STANDBY) &&          // place in standby
          AD5933::setControlMode(CTRL_INIT_START_FREQ) && // init start freq
          AD5933::setControlMode(CTRL_START_FREQ_SWEEP))) // begin frequency sweep
         {
             Serial.println("Could not initialize frequency sweep...");
         }

    // Perform the actual sweep
    printExcelHeader();
    while ((AD5933::readStatusRegister() & STATUS_SWEEP_DONE) != STATUS_SWEEP_DONE) {
        // Get the frequency data for this frequency point
        if (!AD5933::getComplexData(&real, &imag)) {
            Serial.println("Could not get raw frequency data...");
        }

        // Compute impedance
        double magnitude = sqrt(pow(real, 2) + pow(imag, 2));
        double impedance = 1/(magnitude*gain[i]);
        unsigned long frequency = START_FREQ + ((unsigned long)i * FREQ_INCR);
        printExcelRow("raw", frequency, real, imag, magnitude, impedance);

        // Increment the frequency
        i++;
        AD5933::setControlMode(CTRL_INCREMENT_FREQ);
    }

    Serial.println("Frequency sweep complete!");

    // Set AD5933 power mode to standby when finished
    if (!AD5933::setPowerMode(POWER_STANDBY))
        Serial.println("Could not set to standby...");
}

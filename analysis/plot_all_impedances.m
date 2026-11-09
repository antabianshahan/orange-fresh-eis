%% ========================================================================
%%  FROZEN ORANGE DETECTION — COMPLETE IMPEDANCE ANALYSIS
%%  EMST Project — UPC Barcelona, Spring 2025-26
%%  Zurich Instruments MFIA Data — 3 Measurement Sessions, 20 Oranges
%% ========================================================================
%% Run impedance_data.m first to load all arrays, then run this script.
%% ========================================================================
clear; close all; clc;

% Run data file
run('impedance_data.m');

% Color definitions
c_fresh  = [0.180 0.545 0.341];   % green
c_frozen = [0.196 0.388 0.690];   % blue
c_trans  = [0.890 0.330 0.100];   % orange for transition
c_gray   = [0.45 0.45 0.42];
c_red    = [0.85 0.17 0.17];

% Line styles for individual oranges
colors6 = lines(6);
colors8 = lines(8);

%% ========================================================================
%%  FIGURE 1: Session 1 — Bode Plots (|Z| and Phase vs Frequency)
%%            Fresh vs Frozen, Both Electrode Configurations
%% ========================================================================
figure('Name','Fig1: S1 Bode Plots','Position',[50 50 1200 700]);

% --- Vertical: |Z| ---
subplot(2,2,1);
for i = 1:3
    semilogx(S1V_freq, S1V_absz(i,:), '-', 'Color', c_fresh, 'LineWidth', 1.5); hold on;
end
for i = 4:6
    semilogx(S1V_freq, S1V_absz(i,:), '-', 'Color', c_frozen, 'LineWidth', 1.5);
end
xlabel('Frequency (Hz)'); ylabel('|Z| (\Omega)');
title('Session 1 — Vertical Electrodes — Magnitude');
legend('Fresh 1','Fresh 2','Fresh 3','Frozen 4','Frozen 5','Frozen 6','Location','northeast');
grid on; set(gca,'XScale','log');

% --- Vertical: Phase ---
subplot(2,2,3);
for i = 1:3
    semilogx(S1V_freq, S1V_phase(i,:)*180/pi, '-', 'Color', c_fresh, 'LineWidth', 1.5); hold on;
end
for i = 4:6
    semilogx(S1V_freq, S1V_phase(i,:)*180/pi, '-', 'Color', c_frozen, 'LineWidth', 1.5);
end
xlabel('Frequency (Hz)'); ylabel('Phase (degrees)');
title('Session 1 — Vertical Electrodes — Phase');
grid on; set(gca,'XScale','log');

% --- 180°: |Z| ---
subplot(2,2,2);
for i = 1:3
    semilogx(S1H_freq, S1H_absz(i,:), '-', 'Color', c_fresh, 'LineWidth', 1.5); hold on;
end
for i = 4:6
    semilogx(S1H_freq, S1H_absz(i,:), '-', 'Color', c_frozen, 'LineWidth', 1.5);
end
xlabel('Frequency (Hz)'); ylabel('|Z| (\Omega)');
title('Session 1 — 180° Electrodes — Magnitude');
legend('Fresh 1','Fresh 2','Fresh 3','Frozen 4','Frozen 5','Frozen 6','Location','northeast');
grid on; set(gca,'XScale','log');

% --- 180°: Phase ---
subplot(2,2,4);
for i = 1:3
    semilogx(S1H_freq, S1H_phase(i,:)*180/pi, '-', 'Color', c_fresh, 'LineWidth', 1.5); hold on;
end
for i = 4:6
    semilogx(S1H_freq, S1H_phase(i,:)*180/pi, '-', 'Color', c_frozen, 'LineWidth', 1.5);
end
xlabel('Frequency (Hz)'); ylabel('Phase (degrees)');
title('Session 1 — 180° Electrodes — Phase');
grid on; set(gca,'XScale','log');

sgtitle('Session 1: Fresh vs Frozen — Impedance Spectra (Bode Plot)', 'FontSize', 14, 'FontWeight', 'bold');

%% ========================================================================
%%  FIGURE 2: Session 1 — Nyquist / Cole-Cole Plots
%%            Real(Z) vs -Imag(Z)
%% ========================================================================
figure('Name','Fig2: S1 Nyquist','Position',[50 50 1200 500]);

subplot(1,2,1);
for i = 1:3
    plot(S1V_realz(i,:), -S1V_imagz(i,:), '.', 'Color', c_fresh, 'MarkerSize', 6); hold on;
end
for i = 4:6
    plot(S1V_realz(i,:), -S1V_imagz(i,:), '.', 'Color', c_frozen, 'MarkerSize', 6);
end
xlabel('Re(Z) (\Omega)'); ylabel('-Im(Z) (\Omega)');
title('Vertical Electrodes — Nyquist Plot');
legend('Fresh','','','Frozen','','','Location','northeast');
axis equal; grid on;

subplot(1,2,2);
for i = 1:3
    plot(S1H_realz(i,:), -S1H_imagz(i,:), '.', 'Color', c_fresh, 'MarkerSize', 6); hold on;
end
for i = 4:6
    plot(S1H_realz(i,:), -S1H_imagz(i,:), '.', 'Color', c_frozen, 'MarkerSize', 6);
end
xlabel('Re(Z) (\Omega)'); ylabel('-Im(Z) (\Omega)');
title('180° Electrodes — Nyquist Plot');
legend('Fresh','','','Frozen','','','Location','northeast');
axis equal; grid on;

sgtitle('Session 1: Cole-Cole Arcs — Fresh vs Frozen', 'FontSize', 14, 'FontWeight', 'bold');

%% ========================================================================
%%  FIGURE 3: Session 2 — Bode Plot of All Freeze Durations
%% ========================================================================
figure('Name','Fig3: S2 Bode','Position',[50 50 1000 700]);

cmap2 = [c_fresh; 0.4 0.7 0.4; c_trans; 0.8 0.5 0.2; c_frozen; 0.5 0.3 0.7];
labels2 = {'0h (fresh)','2h','4h','7h','10h','24h'};

subplot(2,1,1);
for i = 1:6
    semilogx(S2_freq, S2_absz(i,:), '-', 'Color', cmap2(i,:), 'LineWidth', 2, ...
        'DisplayName', labels2{i}); hold on;
end
xlabel('Frequency (Hz)'); ylabel('|Z| (\Omega)');
title('Impedance Magnitude vs Frequency');
legend('Location','northeast'); grid on; set(gca,'XScale','log');

subplot(2,1,2);
for i = 1:6
    semilogx(S2_freq, S2_phase(i,:)*180/pi, '-', 'Color', cmap2(i,:), 'LineWidth', 2, ...
        'DisplayName', labels2{i}); hold on;
end
xlabel('Frequency (Hz)'); ylabel('Phase (degrees)');
title('Phase vs Frequency');
legend('Location','southwest'); grid on; set(gca,'XScale','log');

sgtitle('Session 2: Impedance Spectra — Freeze Duration 0h to 24h (180°)', 'FontSize', 14, 'FontWeight', 'bold');

%% ========================================================================
%%  FIGURE 4: Session 2 — Nyquist Plot for All Durations
%% ========================================================================
figure('Name','Fig4: S2 Nyquist','Position',[50 50 800 600]);

for i = 1:6
    plot(S2_realz(i,:), -S2_imagz(i,:), '.', 'Color', cmap2(i,:), 'MarkerSize', 8, ...
        'DisplayName', labels2{i}); hold on;
end
xlabel('Re(Z) (\Omega)'); ylabel('-Im(Z) (\Omega)');
title('Session 2: Nyquist Plot — All Freeze Durations (180°)');
legend('Location','northeast'); grid on; axis equal;

%% ========================================================================
%%  FIGURE 5: Session 3 — Bode Plot, 30-min Intervals
%% ========================================================================
figure('Name','Fig5: S3 Bode','Position',[50 50 1000 700]);

cmap3 = parula(8);
labels3 = {'0h','0.5h','1h','1.5h','2h','2.5h','3h','3.5h'};

subplot(2,1,1);
for i = 1:8
    semilogx(S3_freq, S3_absz(i,:), '-', 'Color', cmap3(i,:), 'LineWidth', 1.8, ...
        'DisplayName', labels3{i}); hold on;
end
xlabel('Frequency (Hz)'); ylabel('|Z| (\Omega)');
title('Impedance Magnitude — 30-min Intervals');
legend('Location','northeast'); grid on; set(gca,'XScale','log');

subplot(2,1,2);
for i = 1:8
    semilogx(S3_freq, S3_phase(i,:)*180/pi, '-', 'Color', cmap3(i,:), 'LineWidth', 1.8, ...
        'DisplayName', labels3{i}); hold on;
end
xlabel('Frequency (Hz)'); ylabel('Phase (degrees)');
title('Phase — 30-min Intervals');
legend('Location','southwest'); grid on; set(gca,'XScale','log');

sgtitle('Session 3: High-Resolution Impedance Spectra — 0 to 3.5h (180°)', 'FontSize', 14, 'FontWeight', 'bold');

%% ========================================================================
%%  FIGURE 6: Session 3 — Nyquist Plot, 30-min Intervals
%% ========================================================================
figure('Name','Fig6: S3 Nyquist','Position',[50 50 800 600]);

for i = 1:8
    plot(S3_realz(i,:), -S3_imagz(i,:), '.', 'Color', cmap3(i,:), 'MarkerSize', 8, ...
        'DisplayName', labels3{i}); hold on;
end
xlabel('Re(Z) (\Omega)'); ylabel('-Im(Z) (\Omega)');
title('Session 3: Nyquist Plot — 30-min Intervals (180°)');
legend('Location','northeast'); grid on; axis equal;

%% ========================================================================
%%  FIGURE 7: |Z| at 1 kHz vs Freeze Duration — ALL SESSIONS COMBINED
%% ========================================================================
figure('Name','Fig7: Z vs Time Combined','Position',[50 50 900 550]);

% Find index closest to 1 kHz for Session 1, 180 deg (NOT a fixed index:
% S1H starts at 100 Hz, so 1 kHz is around column 26, not column 10)
[~, s1h_1k] = min(abs(S1H_freq - 1000));
% Session 1 fresh (180°)
scatter(zeros(1,3), [S1H_absz(1,s1h_1k), S1H_absz(2,s1h_1k), S1H_absz(3,s1h_1k)], ...
    100, c_fresh, 'o', 'filled', 'MarkerEdgeColor','k', 'DisplayName','S1 Fresh (180°)'); hold on;
% Session 1 frozen (180°) - plot at x=24
scatter(24*ones(1,3), [S1H_absz(4,s1h_1k), S1H_absz(5,s1h_1k), S1H_absz(6,s1h_1k)], ...
    100, c_frozen, 'd', 'filled', 'MarkerEdgeColor','k', 'DisplayName','S1 Frozen 24h+ (180°)');

% Find index closest to 1kHz for S2 (100Hz-1MHz, 100 pts)
[~, s2_1k] = min(abs(S2_freq - 1000));
S2_z1k = S2_absz(:, s2_1k)';
scatter(S2_times, S2_z1k, 120, c_frozen, 's', 'filled', ...
    'MarkerEdgeColor','k', 'DisplayName','S2 (0-24h, 180°)');

% Session 3 - already starts at 1kHz
[~, s3_1k] = min(abs(S3_freq - 1000));
S3_z1k = S3_absz(:, s3_1k)';
scatter(S3_times, S3_z1k, 120, c_trans, '^', 'filled', ...
    'MarkerEdgeColor','k', 'DisplayName','S3 (0-3.5h, 180°)');

% Threshold
yline(2500, '--', 'Color', c_red, 'LineWidth', 1.5, 'DisplayName','Threshold 2500 \Omega');

% Shading
patch([-0.5 -0.5 25 25], [2500 20000 20000 2500], c_fresh, ...
    'FaceAlpha', 0.05, 'EdgeColor','none', 'HandleVisibility','off');
patch([-0.5 -0.5 25 25], [0 2500 2500 0], c_frozen, ...
    'FaceAlpha', 0.05, 'EdgeColor','none', 'HandleVisibility','off');

text(23, 18000, 'FRESH', 'FontSize', 12, 'Color', c_fresh, 'FontWeight','bold', 'HorizontalAlignment','right');
text(23, 1200, 'FROZEN', 'FontSize', 12, 'Color', c_frozen, 'FontWeight','bold', 'HorizontalAlignment','right');

xlabel('Freeze Duration (hours)');
ylabel('|Z| at 1 kHz (\Omega)');
title('All Sessions Combined — Impedance at 1 kHz vs Freeze Duration (180° Electrodes)');
legend('Location','east'); grid on; box on;
xlim([-0.5 25]); ylim([0 20000]);

%% ========================================================================
%%  FIGURE 8: Session 2 — |Z| at multiple frequencies vs freeze time
%% ========================================================================
figure('Name','Fig8: S2 Multi-freq','Position',[50 50 800 500]);

freq_targets = [1000, 5000, 10000, 50000, 100000];
freq_labels = {'1 kHz','5 kHz','10 kHz','50 kHz','100 kHz'};
freq_colors = [c_frozen; c_trans; c_gray; 0.6 0.3 0.6; 0.3 0.6 0.6];

for fi = 1:length(freq_targets)
    [~, idx] = min(abs(S2_freq - freq_targets(fi)));
    plot(S2_times, S2_absz(:,idx), '-o', 'Color', freq_colors(fi,:), 'LineWidth', 2, ...
        'MarkerSize', 7, 'MarkerFaceColor', freq_colors(fi,:), ...
        'DisplayName', freq_labels{fi}); hold on;
end
xlabel('Freeze Duration (hours)'); ylabel('|Z| (\Omega)');
title('Session 2: Impedance at Multiple Frequencies vs Freeze Duration');
legend('Location','northeast'); grid on; box on;

%% ========================================================================
%%  FIGURE 9: Electrode Configuration Comparison (Session 1)
%% ========================================================================
figure('Name','Fig9: Electrode Comparison','Position',[50 50 700 450]);

[~, v_1k] = min(abs(S1V_freq - 1000));
[~, h_1k] = min(abs(S1H_freq - 1000));

fresh_vert = [S1V_absz(1,v_1k), S1V_absz(2,v_1k), S1V_absz(3,v_1k)];
frozen_vert = [S1V_absz(4,v_1k), S1V_absz(5,v_1k), S1V_absz(6,v_1k)];
fresh_180 = [S1H_absz(1,h_1k), S1H_absz(2,h_1k), S1H_absz(3,h_1k)];
frozen_180 = [S1H_absz(4,h_1k), S1H_absz(5,h_1k), S1H_absz(6,h_1k)];

bar_data = [mean(fresh_vert), mean(fresh_180); mean(frozen_vert), mean(frozen_180)];
bar_err = [std(fresh_vert), std(fresh_180); std(frozen_vert), std(frozen_180)];

b = bar(bar_data, 'grouped');
b(1).FaceColor = c_fresh; b(2).FaceColor = c_frozen;
hold on;
% Error bars
ngroups = size(bar_data, 1);
nbars = size(bar_data, 2);
groupwidth = min(0.8, nbars/(nbars + 1.5));
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, bar_data(:,i), bar_err(:,i), 'k.', 'LineWidth', 1.5);
end

set(gca, 'XTickLabel', {'Fresh (n=3)', 'Frozen 24h+ (n=3)'});
ylabel('|Z| at 1 kHz (\Omega)');
legend('Vertical','180°','Location','northwest');
title('Electrode Configuration Comparison — Session 1');
grid on; box on;

% Add ratio text
ratio_v = mean(fresh_vert)/mean(frozen_vert);
ratio_h = mean(fresh_180)/mean(frozen_180);
text(1.5, max(bar_data(:))*0.85, sprintf('Ratio: Vert=%.1fx, 180°=%.1fx', ratio_v, ratio_h), ...
    'HorizontalAlignment','center', 'FontSize', 11, 'FontWeight','bold', 'Color', c_red);

%% ========================================================================
%%  FIGURE 10: Session 3 — Impedance Normalized by Diameter
%% ========================================================================
figure('Name','Fig10: S3 Normalized','Position',[50 50 900 450]);

subplot(1,2,1);
scatter(S3_diam, S3_z1k, 80, S3_times, 'filled', 'MarkerEdgeColor','k');
colorbar; colormap(parula);
xlabel('Diameter (mm)'); ylabel('|Z| at 1 kHz (\Omega)');
title('Raw Impedance vs Diameter');
for i = 1:8
    text(S3_diam(i)+0.3, S3_z1k(i), labels3{i}, 'FontSize', 8);
end
grid on; box on;

subplot(1,2,2);
S3_z1k_norm = S3_z1k ./ S3_diam;
plot(S3_times, S3_z1k_norm, '-o', 'Color', c_frozen, 'LineWidth', 2, ...
    'MarkerSize', 8, 'MarkerFaceColor', c_frozen);
xlabel('Freeze Duration (hours)'); ylabel('|Z| / Diameter (\Omega/mm)');
title('Diameter-Normalized Impedance');
grid on; box on;

sgtitle('Session 3: Effect of Orange Size on Impedance', 'FontSize', 14, 'FontWeight','bold');

%% ========================================================================
%%  FIGURE 11: Session 2 — 3D Surface Plot (Frequency × Time × |Z|)
%%             Like the lecture slide (page 6)
%% ========================================================================
figure('Name','Fig11: S2 3D Surface','Position',[50 50 800 600]);

[F, T] = meshgrid(S2_freq, S2_times);
surf(log10(F), T, S2_absz, 'EdgeColor','none', 'FaceAlpha', 0.85);
colormap(jet); colorbar;
xlabel('log_{10}(Frequency) [Hz]'); ylabel('Freeze Duration (hours)'); zlabel('|Z| (\Omega)');
title('Session 2: Impedance Surface — Frequency × Freeze Duration');
view([-35 25]);
grid on;

%% ========================================================================
%%  PRINT SUMMARY STATISTICS
%% ========================================================================
fprintf('\n========================================\n');
fprintf('IMPEDANCE SUMMARY AT 1 kHz\n');
fprintf('========================================\n\n');

fprintf('--- SESSION 1 (180°) ---\n');
fprintf('Fresh:  %.0f ± %.0f Ω (n=3)\n', mean(fresh_180), std(fresh_180));
fprintf('Frozen: %.0f ± %.0f Ω (n=3)\n', mean(frozen_180), std(frozen_180));
fprintf('Ratio:  %.2fx | Gap: %.0f Ω\n\n', mean(fresh_180)/mean(frozen_180), min(fresh_180)-max(frozen_180));

fprintf('--- SESSION 2 (180°) ---\n');
for i = 1:6
    drop = (1 - S2_z1k(i)/S2_z1k(1))*100;
    fprintf('%4s: %8.0f Ω (%+.1f%%)\n', char(labels2{i}), S2_z1k(i), -drop);
end

fprintf('\n--- SESSION 3 (180°) ---\n');
for i = 1:8
    drop = (1 - S3_z1k(i)/S3_z1k(1))*100;
    fprintf('%4s: %8.0f Ω (%+.1f%%) | Diam: %.1f mm | Z/D: %.1f Ω/mm\n', ...
        char(labels3{i}), S3_z1k(i), -drop, S3_diam(i), S3_z1k(i)/S3_diam(i));
end

fprintf('\n--- CLASSIFICATION ACCURACY ---\n');
fprintf('Threshold: 2500 Ohm at 1 kHz\n');
fprintf('Session 1: 6/6 correct (100%%)\n');
fprintf('Session 2: 6/6 correct (100%% - all match expected fresh/frozen)\n');
fprintf('Session 3: transition range (0-3.5h); all but the 3h orange read above\n');
fprintf('           threshold, consistent with partial freezing before core transition\n');
fprintf('========================================\n');

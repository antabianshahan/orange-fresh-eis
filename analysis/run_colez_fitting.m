%% ========================================================================
%% COLE-COLE FITTING  with colez.m File given by Ramon.
clear; close all; clc;
run('impedance_data.m');

is_good = @(R0,Rinf,err) isreal(R0) && isfinite(R0) && isreal(Rinf) ...
                      && isfinite(Rinf) && (R0 > Rinf) && (R0 > 0) && (err < 50);

%% === SESSION 1 (180 degrees) ===
labels1 = {'Fresh 1','Fresh 2','Fresh 3','Frozen 4','Frozen 5','Frozen 6'};
figure('Name','Session 1 - colez fitting','Position',[50 50 1400 800]);
fprintf('\n=== SESSION 1 (180 deg) ===\n');
for i = 1:6
    subplot(2,3,i);
    freq = S1H_freq; r = S1H_realz(i,:); im = S1H_imagz(i,:);
    neg_im = -im;

    % Select arc points: skip electrode polarization and HF artifacts
    if i <= 3   % fresh: large arc
        idx = 8:(length(freq)-15);
    else        % frozen: small arc
        idx = 3:(length(freq)-5);
    end
    idx = idx(neg_im(idx) > 0);

    [ok,R0,Rinf,alpha,fc,err] = try_colez(r, im, freq, idx, is_good);
    annotate_fit(labels1{i}, ok, R0, alpha, err, r, im, idx);
    print_fit(labels1{i}, ok, R0, Rinf, alpha, fc, err);
end
sgtitle('Session 1 - Cole-Cole Fitting (180 deg)','FontSize',14,'FontWeight','bold');

%% === SESSION 2 (180 deg, freeze duration 0-24 h) ===
labels2 = {'0h (fresh)','2h','4h','7h','10h','24h'};
times   = S2_times;                       % [0 2 4 7 10 24]
figure('Name','Session 2 - colez fitting','Position',[50 50 1400 800]);
fprintf('\n=== SESSION 2 (180 deg) ===\n');
R0_all = nan(1,6); Rinf_all = nan(1,6); alpha_all = nan(1,6); fc_all = nan(1,6);

for i = 1:6
    subplot(2,3,i);
    freq = S2_freq; r = S2_realz(i,:); im = S2_imagz(i,:);
    neg_im = -im;

    if i <= 2       % fresh / 2h: large arc
        idx = 8:(length(freq)-15);
    elseif i == 3   % 4h: medium
        idx = 5:(length(freq)-10);
    else            % 7h+: small arc
        idx = 3:(length(freq)-5);
    end
    idx = idx(neg_im(idx) > 0);

    [ok,R0,Rinf,alpha,fc,err] = try_colez(r, im, freq, idx, is_good);
    annotate_fit(labels2{i}, ok, R0, alpha, err, r, im, idx);
    print_fit(labels2{i}, ok, R0, Rinf, alpha, fc, err);

    if ok
        R0_all(i) = R0; Rinf_all(i) = Rinf; alpha_all(i) = alpha; fc_all(i) = fc;
    end   % failed fits stay NaN and are simply skipped in the plots below
end
sgtitle('Session 2 - Cole-Cole Fitting (180 deg)','FontSize',14,'FontWeight','bold');

%% === PARAMETER TRACKING (Session 2) ===
% NaN entries (non-converged fits, e.g. the 10h orange) are skipped by plot().
figure('Name','Cole-Cole Parameters vs Freeze Duration','Position',[50 50 1000 700]);

subplot(2,2,1);
plot(times, R0_all, '-o', 'LineWidth', 2, 'MarkerSize', 8); hold on;
plot(times, Rinf_all, '--s', 'LineWidth', 1.5, 'MarkerSize', 7);
xlabel('Freeze Duration (h)'); ylabel('Resistance (\Omega)');
title('R_0 and R_\infty'); legend('R_0','R_\infty'); grid on;

subplot(2,2,2);
plot(times, R0_all - Rinf_all, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'Color', [0.13 0.55 0.13]);
xlabel('Freeze Duration (h)'); ylabel('R_0 - R_\infty (\Omega)');
title('Arc Diameter (membrane contribution)'); grid on;

subplot(2,2,3);
plot(times, fc_all, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'Color', [0.33 0.29 0.72]);
xlabel('Freeze Duration (h)'); ylabel('f_c (kHz)');
title('Characteristic Frequency'); grid on;

subplot(2,2,4);
plot(times, alpha_all, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'Color', [0.85 0.19 0.14]);
xlabel('Freeze Duration (h)'); ylabel('\alpha');
title('Dispersion Parameter'); grid on;

sgtitle('Cole-Cole Parameters vs Freeze Duration','FontSize',14,'FontWeight','bold');

%% === SESSION 3 (180 deg, 30-min intervals) ===
% NOTE: impedance_data.m already stores Session 3 in TIME ORDER
%       (row 1 = 0h fresh, ..., row 7 = 3h, row 8 = 3.5h), see the comment
%       "Orange 1:0h, 2:0.5h, ..." in that file. So we index rows directly;
%       no chunk reordering is needed.
labels3 = {'0h','0.5h','1h','1.5h','2h','2.5h','3h','3.5h'};
figure('Name','Session 3 - colez fitting','Position',[50 50 1600 700]);
fprintf('\n=== SESSION 3 (180 deg, 30-min intervals) ===\n');

for i = 1:8
    subplot(2,4,i);
    freq = S3_freq; r = S3_realz(i,:); im = S3_imagz(i,:);
    neg_im = -im;

    if i <= 6   % 0h to 2.5h: large arcs
        idx = 5:(length(freq)-8);
    else        % 3h, 3.5h: smaller arcs
        idx = 3:(length(freq)-5);
    end
    idx = idx(neg_im(idx) > 0);

    [ok,R0,Rinf,alpha,fc,err] = try_colez(r, im, freq, idx, is_good);
    annotate_fit(labels3{i}, ok, R0, alpha, err, r, im, idx);
    print_fit(labels3{i}, ok, R0, Rinf, alpha, fc, err);
end
sgtitle('Session 3 - Cole-Cole Fitting (30-min intervals)','FontSize',14,'FontWeight','bold');

fprintf('\nDone. All figures generated.\n');

%% ======================== LOCAL FUNCTIONS ===============================
function [ok,R0,Rinf,alpha,fc,err] = try_colez(r, im, freq, idx, is_good)
% Run colez on the selected window, guarding against non-converging fits.
    R0 = NaN; Rinf = NaN; alpha = NaN; fc = NaN; err = NaN; ok = false;
    if numel(idx) <= 5
        return;   % not enough points to attempt a fit
    end
    try
        [R0,Rinf,alpha,fc,err] = colez(r(idx), im(idx), freq(idx));
        ok = is_good(R0,Rinf,err);
    catch
        ok = false;   % colez errored (e.g. complex intercepts on a collapsed arc)
    end
end

function annotate_fit(label, ok, R0, alpha, err, r, im, idx)
% colez draws the circle when it succeeds; on failure we clear whatever was
% drawn and show the raw Nyquist points with a clear label.
    if ok
        title(sprintf('%s  (R_0=%.0f \\Omega, \\alpha=%.2f, err=%.1f%%)', ...
            label, R0, alpha, err), 'FontSize', 9);
    else
        cla;
        if numel(idx) > 0
            plot(r(idx), -im(idx), 'k.', 'MarkerSize', 8);
        else
            plot(r, -im, 'k.', 'MarkerSize', 8);
        end
        grid on; axis tight;
        xlabel('Real part (\Omega)'); ylabel('- Imag part (\Omega)');
        title(sprintf('%s  (circle fit did not converge)', label), ...
            'FontSize', 9, 'Color', [0.7 0 0]);
    end
end

function print_fit(label, ok, R0, Rinf, alpha, fc, err)
    if ok
        fprintf('  %-11s: R0=%7.0f  Rinf=%6.0f  alpha=%.3f  fc=%5.2f kHz  err=%5.1f%%\n', ...
            label, R0, Rinf, alpha, fc, err);
    else
        fprintf('  %-11s: circle fit did not converge (collapsed / polarisation-dominated arc)\n', label);
    end
end

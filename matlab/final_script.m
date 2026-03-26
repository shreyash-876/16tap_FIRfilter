clc; clear; close all;

%% ================= FIR DESIGN =================
N = 15;                 % 16 taps
fc = 0.4;
b = fir1(N, fc);

%% ================= INPUT (MATCH VIVADO) =================
n = 0:200;

% SAME as Verilog: temp = 1000*sin(...)
x = 1000*sin(2*pi*0.05*n);

%% ================= FLOATING OUTPUT =================
y = filter(b, 1, x);

%% ================= FREQUENCY RESPONSE =================
figure;
freqz(b);
title('Frequency Response');
set(gcf,'Color','w');

%% ================= TIME DOMAIN =================
figure;
plot(n, x, 'k', 'LineWidth', 1); hold on;
plot(n, y, 'r', 'LineWidth', 1.5);
legend('Input','Filtered Output');
title('Time Domain Response');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;
set(gcf,'Color','w');

%% ================= TAP COMPARISON =================
b4  = fir1(3, fc);
b16 = fir1(15, fc);
b32 = fir1(31, fc);

[H4, w]  = freqz(b4, 1, 1024);
[H16, ~] = freqz(b16, 1, 1024);
[H32, ~] = freqz(b32, 1, 1024);

figure;
plot(w/pi, 20*log10(abs(H4)), 'r', 'LineWidth', 1.5); hold on;
plot(w/pi, 20*log10(abs(H16)), 'g', 'LineWidth', 1.5);
plot(w/pi, 20*log10(abs(H32)), 'b', 'LineWidth', 1.5);

xlabel('Normalized Frequency');
ylabel('Magnitude (dB)');
legend('4 taps','16 taps','32 taps');
title('Tap Comparison');
grid on;
set(gcf,'Color','w');

%% ================= FIXED-POINT =================
b_fixed = round(b * 2^15) / 2^15;

y_fixed = filter(b_fixed, 1, x);

%% ================= OUTPUT COMPARISON =================
figure;
plot(n, y, 'b', 'LineWidth', 1.5); hold on;
plot(n, y_fixed, 'r--', 'LineWidth', 1.5);
legend('Floating','Fixed');
title('Floating vs Fixed Output');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;
set(gcf,'Color','w');

%% ================= COEFFICIENT COMPARISON =================
figure;
stem(b, 'b', 'LineWidth', 1.2); hold on;
stem(b_fixed, 'r--', 'LineWidth', 1.2);
legend('Floating','Fixed');
title('Coefficient Comparison');
grid on;
set(gcf,'Color','w');

%% ================= QUANTIZATION ERROR =================
error = y - y_fixed;

figure;
subplot(2,1,1)
plot(n, error, 'b', 'LineWidth', 2);
title('Quantization Error');
xlabel('Sample Index');
ylabel('Error');
grid on;

subplot(2,1,2)
plot(n, error*1000, 'r', 'LineWidth', 2);
title('Scaled Error (×1000)');
xlabel('Sample Index');
ylabel('Error');
grid on;

set(gcf,'Color','w');

%% ================= SAVE FIGURES =================
exportgraphics(figure(1), 'freq_response.png', 'Resolution', 300);
exportgraphics(figure(2), 'time_response.png', 'Resolution', 300);
exportgraphics(figure(3), 'tap_comparison.png', 'Resolution', 300);
exportgraphics(figure(4), 'output_comparison.png', 'Resolution', 300);
exportgraphics(figure(5), 'coeff_comparison.png', 'Resolution', 300);
exportgraphics(figure(6), 'error_plot.png', 'Resolution', 300);

disp('All plots generated with SAME input as Vivado!');
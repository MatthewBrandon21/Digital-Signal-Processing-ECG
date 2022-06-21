%% Import Data (We only use MLII data)
clc; clear all; close all;
file_pasien1 = csvread ('samples_234.csv',3 , 2);
file_pasien2 = csvread ('samples_116.csv',3 , 2);
file_pasien3 = csvread ('samples_231.csv',3 , 2);
file_pasien4 = csvread ('samples_203.csv',3 , 2);
file_pasien5 = csvread ('samples_207.csv',3 , 2);
data_pasien1 = file_pasien1(:, 1);
data_pasien2 = file_pasien2(:, 1)*-1;
data_pasien3 = file_pasien3(:, 1);
data_pasien4 = file_pasien4(:, 1)*-1;
data_pasien5 = file_pasien5(:, 1);

%% Prepare to show raw data
fs=250;    %sampling frequency (Hz)

z1 = fft(data_pasien1,512);
AFs_filt1 = abs(z1);
f1 = fs/512*(0:255);

z2 = fft(data_pasien2,512);
AFs_filt2 = abs(z2);
f2 = fs/512*(0:255);

z3 = fft(data_pasien3,512);
AFs_filt3 = abs(z3);
f3 = fs/512*(0:255);

z4 = fft(data_pasien4,512);
AFs_filt4 = abs(z4);
f4 = fs/512*(0:255);

z5 = fft(data_pasien5,512);
AFs_filt5 = abs(z5);
f5 = fs/512*(0:255);

%% Show raw data
figure(1)
subplot(2,1,1);
plot(data_pasien1);
xlim([0 1500]);
xlabel('time/s');
ylabel('amplitude');
xlabel('Time-domain diagram');
title('Raw data pasien 1');
subplot(2,1,2);
plot(f1,AFs_filt1(1:256));
ylim([0 40]);
xlabel('frequency/Hz');
ylabel('amplitude');
xlabel('Frequency-domain diagram');

figure(2)
subplot(2,1,1);
plot(data_pasien2);
xlim([0 1500]);
xlabel('time/s');
ylabel('amplitude');
xlabel('Time-domain diagram');
title('Raw data pasien 2');
subplot(2,1,2);
plot(f2,AFs_filt2(1:256));
ylim([0 40]);
xlabel('frequency/Hz');
ylabel('amplitude');
xlabel('Frequency-domain diagram');

figure(3)
subplot(2,1,1);
plot(data_pasien3);
xlim([0 1500]);
xlabel('time/s');
ylabel('amplitude');
xlabel('Time-domain diagram');
title('Raw data pasien 3');
subplot(2,1,2);
plot(f3,AFs_filt3(1:256));
ylim([0 40]);
xlabel('frequency/Hz');
ylabel('amplitude');
xlabel('Frequency-domain diagram');

figure(4)
subplot(2,1,1);
plot(data_pasien4);
xlim([0 1500]);
xlabel('time/s');
ylabel('amplitude');
xlabel('Time-domain diagram');
title('Raw data pasien 4');
subplot(2,1,2);
plot(f4,AFs_filt4(1:256));
ylim([0 40]);
xlabel('frequency/Hz');
ylabel('amplitude');
xlabel('Frequency-domain diagram');

figure(5)
subplot(2,1,1);
plot(data_pasien5);
xlim([0 1500]);
xlabel('time/s');
ylabel('amplitude');
xlabel('Time-domain diagram');
title('Raw data pasien 5');
subplot(2,1,2);
plot(f5,AFs_filt5(1:256));
ylim([0 40]);
xlabel('frequency/Hz');
ylabel('amplitude');
xlabel('Frequency-domain diagram');

%% Design Filter
b = fir1(48,[0.00536 0.32]); %Bandpass filter 0.00536*(250/2)=0.67Hz & 0.32*(250/2)=40Hz -> 250 = fs
[h,f] = freqz(b,1,512); %amplitude-frequency characteristic diagram
figure(6)
plot(f*fs/(2*pi),20*log10(abs(h)))
xlabel('frequency/Hz');
ylabel('gain/dB');
title('The gain response of bandpass filter');

%% Filtering
sf1 = filter(b,1,data_pasien1);%use function filter
z6 = fft(sf1,512);
AFs_filt6 = abs(z6);
f6 = fs/512*(0:255);

sf2 = filter(b,1,data_pasien2);%use function filter
z7 = fft(sf2,512);
AFs_filt7 = abs(z7);
f7 = fs/512*(0:255);

sf3 = filter(b,1,data_pasien3);%use function filter
z8 = fft(sf3,512);
AFs_filt8 = abs(z8);
f8 = fs/512*(0:255);

sf4 = filter(b,1,data_pasien4);%use function filter
z9 = fft(sf4,512);
AFs_filt9 = abs(z9);
f9 = fs/512*(0:255);

sf5 = filter(b,1,data_pasien5);%use function filter
z10 = fft(sf5,512);
AFs_filt10 = abs(z10);
f10 = fs/512*(0:255);

%% Show data after filtering (only show pasien 1)
figure(7);
subplot(2,1,1);
plot(sf1);
xlim([0 1500]);
xlabel('time/s');
ylabel('amplitude');
xlabel('Time-domain diagram');
title('Pasien 1 - After Bandpass Filter');
subplot(2,1,2);
plot(f6,AFs_filt6(1:256))
ylim([0 40]);
xlabel('frequency/Hz');
ylabel('amplitude');
xlabel('Frequency-domain diagram');

%% Wavelet symlet
wavelet1 = wden(sf1,'modwtsqtwolog','s','mln',4,'sym4');
z11 = fft(wavelet1,512);
AFs_filt11 = abs(z11);
f11 = fs/512*(0:255);

wavelet2 = wden(sf2,'modwtsqtwolog','s','mln',4,'sym4');
z12 = fft(wavelet2,512);
AFs_filt12 = abs(z12);
f12 = fs/512*(0:255);

wavelet3 = wden(sf3,'modwtsqtwolog','s','mln',4,'sym4');
z13 = fft(wavelet3,512);
AFs_filt13 = abs(z13);
f13 = fs/512*(0:255);

wavelet4 = wden(sf4,'modwtsqtwolog','s','mln',4,'sym4');
z14 = fft(wavelet4,512);
AFs_filt14 = abs(z14);
f14 = fs/512*(0:255);

wavelet5 = wden(sf5,'modwtsqtwolog','s','mln',4,'sym4');
z15 = fft(wavelet5,512);
AFs_filt15 = abs(z15);
f15 = fs/512*(0:255);

%% Show data after wavelet symlet (only show pasien 1)
figure(8);
subplot(2,1,1);
plot(wavelet1);
xlim([0 1500]);
xlabel('time/s');
ylabel('amplitude');
xlabel('Time-domain diagram');
title('Pasien 1 - After Wavelet Filter');
subplot(2,1,2);
plot(f11,AFs_filt11(1:256))
ylim([0 40]);
xlabel('frequency/Hz');
ylabel('amplitude');
xlabel('Frequency-domain diagram');

%% QRS Detection
EKG1 = wavelet1;
EKG2 = wavelet2;
EKG3 = wavelet3;
EKG4 = wavelet4;
EKG5 = wavelet5;
t = [0:size(EKG1,2)-1]/fs;

[R1,TR1]  = findpeaks( EKG1, t, 'MinPeakHeight',0.2, 'MinPeakDistance',0.75);
[R2,TR2]  = findpeaks( EKG2, t, 'MinPeakHeight',0.7, 'MinPeakDistance',0.75);
[R3,TR3]  = findpeaks( EKG3, t, 'MinPeakHeight',0.4, 'MinPeakDistance',0.75);
[R4,TR4]  = findpeaks( EKG4, t, 'MinPeakHeight',0.2, 'MinPeakDistance',0.5);
[R5,TR5]  = findpeaks( EKG5, t, 'MinPeakHeight',0.75, 'MinPeakDistance',0.9);

%% Show R-Peak
figure(9);
plot(t, EKG1);
hold on;
plot(TR1, R1, '^r');
hold off;
grid;
axis([0  60    ylim]);
legend('EKG', 'R');
title('Pasien 1 - R-peak Detection');

figure(10);
plot(t, EKG2);
hold on;
plot(TR2, R2, '^r');
hold off;
grid;
axis([0  60    ylim]);
legend('EKG', 'R');
title('Pasien 2 - R-peak Detection');

figure(11);
plot(t, EKG3);
hold on;
plot(TR3, R3, '^r');
hold off;
grid;
axis([0  60    ylim]);
legend('EKG', 'R');
title('Pasien 3 - R-peak Detection');

figure(12);
plot(t, EKG4);
hold on;
plot(TR4, R4, '^r');
hold off;
grid;
axis([0  60    ylim]);
legend('EKG', 'R');
title('Pasien 4 - R-peak Detection');

figure(13);
plot(t, EKG5);
hold on;
plot(TR5, R5, '^r');
hold off;
grid;
axis([0  60    ylim]);
legend('EKG', 'R');
title('Pasien 5 - R-peak Detection');

%% Find time difference between R-peak
diffTR1 = diff(TR1);
diffTR2 = diff(TR2);
diffTR3 = diff(TR3);
diffTR4 = diff(TR4);
diffTR5 = diff(TR5);
average1 = sum(diffTR1)/length(diffTR1);
average2 = sum(diffTR2)/length(diffTR2);
average3 = sum(diffTR3)/length(diffTR3);
average4 = sum(diffTR4)/length(diffTR4);
average5 = sum(diffTR5)/length(diffTR5);
min1 = min(diffTR1);
min2 = min(diffTR2);
min3 = min(diffTR3);
min4 = min(diffTR4);
min5 = min(diffTR5);
max1 = max(diffTR1);
max2 = max(diffTR2);
max3 = max(diffTR3);
max4 = max(diffTR4);
max5 = max(diffTR5);

names = {'pasien 1';'pasien 2';'pasien 3';'pasien 4';'pasien 5'};
averages = [average1;average2;average3;average4;average5];
lengths = [length(diffTR1);length(diffTR2);length(diffTR3);length(diffTR4);length(diffTR5)];
variances = [var(diffTR1);var(diffTR2);var(diffTR3);var(diffTR4);var(diffTR5)];
min = [min1;min2;min3;min4;min5];
max = [max1;max2;max3;max4;max5];

figure(14);
T = table(averages,lengths,variances,min,max,'RowNames',names);
uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,...
    'RowName',T.Properties.RowNames,'Units', 'Normalized', 'Position',[0, 0, 1, 1]);

%% Variance and analysis
figure(15);
subplot(2,1,1);
norm = histfit(diffTR1,10,'normal')
[muHat, sigmaHat] = normfit(diffTR1);
lowBound = muHat - 3 * sigmaHat;
highBound = muHat + 3 * sigmaHat;
yl = ylim;
grid on;
ylabel('Count');
xlabel('second');
title('Pasien 1 - Normal distribution');
subplot(2,1,2);
plot(diffTR1)
ylabel('second');
xlabel('time-domain');

figure(16);
subplot(2,1,1);
norm = histfit(diffTR2,10,'normal')
[muHat, sigmaHat] = normfit(diffTR2);
lowBound = muHat - 3 * sigmaHat;
highBound = muHat + 3 * sigmaHat;
yl = ylim;
grid on;
ylabel('Count');
xlabel('second');
title('Pasien 2 - Normal distribution');
subplot(2,1,2);
plot(diffTR2)
ylabel('second');
xlabel('time-domain');

figure(17);
subplot(2,1,1);
norm = histfit(diffTR3,10,'normal')
[muHat, sigmaHat] = normfit(diffTR3);
lowBound = muHat - 3 * sigmaHat;
highBound = muHat + 3 * sigmaHat;
yl = ylim;
grid on;
ylabel('Count');
xlabel('second');
title('Pasien 3 - Normal distribution');
subplot(2,1,2);
plot(diffTR3)
ylabel('second');
xlabel('time-domain');

figure(18);
subplot(2,1,1);
norm = histfit(diffTR4,10,'normal')
[muHat, sigmaHat] = normfit(diffTR4);
lowBound = muHat - 3 * sigmaHat;
highBound = muHat + 3 * sigmaHat;
yl = ylim;
grid on;
ylabel('Count');
xlabel('second');
title('Pasien 4 - Normal distribution');
subplot(2,1,2);
plot(diffTR4)
ylabel('second');
xlabel('time-domain');

figure(19);
subplot(2,1,1);
norm = histfit(diffTR5,10,'normal')
[muHat, sigmaHat] = normfit(diffTR5);
lowBound = muHat - 3 * sigmaHat;
highBound = muHat + 3 * sigmaHat;
yl = ylim;
grid on;
ylabel('Count');
xlabel('second');
title('Pasien 5 - Normal distribution');
subplot(2,1,2);
plot(diffTR5)
ylabel('second');
xlabel('time-domain');
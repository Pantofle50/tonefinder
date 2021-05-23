clc;
clear all;

% Load wav
[raw_audio, fs] = audioread("A-G_1s_period.wav");
player = audioplayer(raw_audio, fs);  % Play if needed

% Combine L and R channels together
raw_audio = (raw_audio(:,1)./2 + raw_audio(:,2)./2);

% Debug
%fs = 44e3;
%i = 0:1/fs:1/3;
%freq1 = sin(2*pi*1400.*i);
%freq2 = sin(2*pi*400.*i);
%freq3 = sin(2*pi*1000.*i);
%raw_audio = [freq1 freq2 freq3];
%player = audioplayer(raw_audio, fs);

Ts = 1/fs;

N_FFT = 100e3;

TONES = generateToneTable(82.41);

f_lim = 2000; % Limit of the frequency axis in Hz
n_lim = f_lim/(fs/N_FFT);

% Define time window to be used for FFT
t_window = 0.2; %seconds
w_length = round (t_window/Ts);

% Number of windows to be checked
w_count = ceil(length(raw_audio) / w_length);
disp(strcat("Number of windows:  ", num2str(w_count)));



for i_w = 0:(w_count - 1)
  
  n_start = 1 + (i_w * w_length);
  
  if (i_w != (w_count - 1))
    n_end = (i_w + 1) * w_length;
  else
    n_end = length(raw_audio);
  endif
  
  windowed_audio = raw_audio(n_start:n_end);
  
  [f_max amp f fft_w] = findFreq(windowed_audio, n_lim, fs, N_FFT);

  disp(strcat("W:", num2str(i_w), "\tf:", num2str(f_max), "\tA:", num2str(amp), "\tTone: ", char(getToneName(TONES,f_max))));

endfor

% Debug - get specific window
debug_w_num = 13;

windowed_audio = raw_audio(1 + (debug_w_num * w_length):(debug_w_num + 1) * w_length);
player = audioplayer(windowed_audio, fs);

[f_max amp f fft_w] = findFreq(windowed_audio, n_lim, fs, N_FFT);


figure(1)
subplot(2,1,1)
plot(windowed_audio)
title (strcat("W:", num2str(i_w), "  f:", num2str(f_max), "  A:", num2str(amp), "  Tone: ", char(getToneName(TONES,f_max))));

subplot(2,1,2)
plot(f,fft_w,"-.")
title (strcat("Peak:  ",num2str(f_max), "Hz   ", "  Window:  ", num2str(t_window), " s /  ", num2str(w_length), " samples"));
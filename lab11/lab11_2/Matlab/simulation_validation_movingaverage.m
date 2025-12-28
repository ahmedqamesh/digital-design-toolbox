clear all
clc
close all
%% Initialzation
fs    = 8000;       % Sampling frequency
dt    = 1/fs;       % Sampling interval
fmain = 10;         % Useful sine frequency
ferr  = 1000;       % Interfering sine frequency
Amain = 10;         % Amplitude of useful sine
Aerr  = 1;          % Amplitude of interfering sine
n     = (0:8000)';  % Time scale (sample numbers)
t     = n*dt;       % Time scale (in seconds)
ns    = length(n);  % Number of samples
%% Signal generation
sig_main = Amain*sin(2*pi*fmain*n/fs);  % Useful sine
sig_err  = Aerr *sin(2*pi*ferr *n/fs);  % Interferring sine
sig_full = sig_main + sig_err;          % Group signal (mix of sines)
%% Running average
Nwindow = 4;    % Window size
sig_res1 = zeros(ns,1);
for k=Nwindow:ns
    sig_res1(k) = sum(sig_full(k-Nwindow+1:k))/Nwindow;
end
Nwindow = 8;    % Window size
sig_res2 = zeros(ns,1);
for k=Nwindow:ns
    sig_res2(k) = sum(sig_full(k-Nwindow+1:k))/Nwindow;
end
%% Display signals
hold all
grid on
plot(t,sig_full,'r')
plot(t,sig_res1,'g')
plot(t,sig_res2,'b')
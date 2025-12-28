fid = fopen('wifi_80211b_fd22.pcm');
% Read 16-bit integers from binary file.
Num_of_samples = 40000;
data = fread(fid,Num_of_samples,'int16');
fclose(fid);
data_i = downsample(data,2);    % Real part of input signal 
data_q = downsample(data,2,1);  % Imaginary part of input signal
data_samples = complex(data_i,data_q);  % Resulting complex baseband signal

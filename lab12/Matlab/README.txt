Signal format description for wifi_80211b_fd22.pcm.
This file contains the real-world waveform of Wi-Fi 802.11b signal.
Sampling frequency: 22 MHz.
File type: binary.
Signal type: complex (represented by two quadratures data_i (real part) and data_q (imaginary part)).
Sample format: 16-bit signed integers, each sample is represented by pair {data_i,data_q}. Each number in pair is 16-bit width.
Samples order in file: data_i0, data_q0, data_i1, data_q1, data_i2, data_q2, data_i3, data_q3,…
The symbol rate in Wi-Fi 802.11b is 11 MSamples/s. Given 22 MHz sampling frequency there are two samples per symbol in the record
 start superscript, 1, end superscript. This means that developed matched filter is to filter even and odd samples separately squared.

The developed matched filter processes complex signal, but its coefficients are real (+1 or –1). Thus to separate filters for real and imaginary part are required. The filter output is also complex. The reference signal for matching (filter pulse response) use complex 11-element Barker sequence (both real and imaginary parts have 11-element Barker sequence, moreover its elements is not {0,1}, but {+1,–1}).



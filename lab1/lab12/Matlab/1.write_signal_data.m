%% Write samples to file
wr_sig_full = round(sig_full*2048);    % Original signal scaling to write to text file
dlmwrite('data2fpga.dat',wr_sig_full);
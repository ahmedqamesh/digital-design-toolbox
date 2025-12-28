%% Read the FPGA simulation results from text file
fpga_result = dlmread('data_from_fpga.dat');
fpga_result = fpga_result/2048;        % FPGA results reverse scaling for correct comparison with Matlab results
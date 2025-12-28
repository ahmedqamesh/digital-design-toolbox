%% Compare results from Matlab and FPGA
err = fpga_result(Nwindow:ns) - sig_res2(Nwindow:ns);   % Error signal
max(abs(err))   % Maximum error
mean(abs(err))  % Mean absolute error
figure(2)       % Reference floating-point result and result from FPGA fixed-point
hold all
grid on
plot(fpga_result(Nwindow:ns),'-d')
plot(sig_res2(Nwindow:ns),'--c')
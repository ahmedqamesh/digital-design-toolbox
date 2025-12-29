set time_raw [clock seconds];
set date_string [clock format $time_raw -format "%y%m%d_%H%M%S"]
set proj_dir "check_$date_string"
puts "Creating build directory $proj_dir"
file mkdir $proj_dir

set src_dir    [pwd]/sources

puts "Changing directory to $proj_dir"
cd $proj_dir

set device xc7a35tcpg236-1
puts "Creating new project: testing_gen"
create_project testing_project -part $device
set_property target_language VHDL [current_project]
puts "Adding RTL files to the project"
add_files [glob $src_dir/*.vhd]
update_compile_order -fileset sources_1
set_property top test_bench [get_filesets sim_1]
set_property top_file {$src_dir/test_bench.vhd} [get_filesets sim_1]
launch_sim
run 10000ns
close_sim
exit

#source $script_dir/check.tcl
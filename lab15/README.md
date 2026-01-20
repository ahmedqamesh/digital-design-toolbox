## Lab 15 - Version control for Vivado projects

1. Determine the folder/file structure that you want to use for the version controlled files.

![Screenshot from 2023-07-27 16-33-04](https://github.com/ahmedqamesh/local_workspace/assets/8536649/96cfb77f-b72b-4d6e-8e1e-225cf26cc9a2)

2. Assuming you’ve created a project using the GUI - from the File menu, select **Project >>Write Tcl**.
3. Choose a name and location for the output Tcl script file (e.g ‘build.tcl’) and locate it in the project folder (vivado).<br/>
**Note**: deselect all the options. <br/>
<p align="center"><img src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/66c42792-4ceb-44d1-b510-f4b24d8720bc"></p>
4. Modify the build script by replacing these lines:
<pre><code># Set the reference directory for source file relative paths
set origin_dir "."
# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/orig-project"]"
# Create project
create_project myproject ./myproject</code></pre>
With these:
<pre><code># Set the reference directory to where the script is
set origin_dir [file dirname [info script]]
# Create project
create_project ${_xil_proj_name_} $origin_dir/${_xil_proj_name_}</code></pre>

5. Edit the path of all the files after copying it to the directory<code>"$origin_dir/src/hdl/</code>.
6. Remove all the lines that import the HDL wrapper file and the block design (.bd) file into the project. This can be done by commenting out all the (.bd) files in the design (e.g checkRequiredFiles)
7. To generate the block design script in Vivado, with the block design open, select File->Export->Export block design. and save this file in the “src/bd” folder and commit it to version control.
8. At the end of the file build.tcl, add the following lines:
<pre><code># Create block design
 source $origin_dir/src/bd/design_1.tcl
 after 2000
 #Generate the wrapper
 set design_name [get_bd_designs]
 after 2000
open_bd_design $origin_dir/src/bd/$design_name.bd 
regenerate_bd_layout
validate_bd_design -force
after 2000
make_wrapper -files [get_files $design_name.bd] -top</code></pre>
9. Set IP repository paths
### Sources:
[Version control for Vivado projects](https://www.fpgadeveloper.com/2014/08/version-control-for-vivado-projects.html/)
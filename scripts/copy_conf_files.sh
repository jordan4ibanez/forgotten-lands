#!/bin/bash
# I'm sure there's an easier way to do this.
# Simply copy over the conf files into the adjacent compiled directories.
# echo Copying mod conf files...
for filename in source/*; do
  mod_file_name=${filename//"source/"/};
  old_dir="source/${mod_file_name}/mod.conf";
  new_dir="mods/${mod_file_name}/mod.conf";
  cp $old_dir $new_dir
done
# echo Successfully copied mod conf files.
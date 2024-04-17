#!/bin/bash
# I'm sure there's an easier way to do this.
# Simply copy over the conf files into the adjacent compiled directories.
echo Copying over model files...
for filename in source/*; do
  # echo $mod_folder_name
  folder_name=${filename//"source/"/};
  old_path="source/${folder_name}/models/"
  if [ -d $old_path ]; then
    new_path="mods/${folder_name}/models/"
    mkdir -p $new_path
    cp -r "${old_path}" "${new_path}"
    echo "Copying over mod $folder_name..."
  fi
done

echo Successfully copied model files.
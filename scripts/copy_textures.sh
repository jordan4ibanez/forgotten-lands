#!/bin/bash
# This hackjob copies over all the textures into the compiled build.
# EVERY. TIME.
echo "Trying to make the directory."
mkdir mods/sharpik_texture_pack/textures/
echo "That probably worked."

echo "Copying over all the files"
cp --verbose -r source/sharpik_texture_pack/textures/* mods/sharpik_texture_pack/textures/
echo "That did the trick, hopefully."
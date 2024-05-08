#!/bin/bash
# This hackjob copies over all the textures into the compiled build.
# EVERY. TIME.
echo "Trying to make the textures directory..."
mkdir mods/sharpik_texture_pack/textures/
echo "Done."

echo "Copying over texture files..."
cp -r source/sharpik_texture_pack/textures/* mods/sharpik_texture_pack/textures/
echo "Done."
#!/bin/bash
# This hackjob copies over all the textures into the compiled build.
# EVERY. TIME.
# echo "Trying to make the textures directory..."
mkdir mods/textures/textures/
# echo "Done."

# echo "Copying over texture files..."
cp -r source/textures/textures/* mods/textures/textures/
# echo "Done."
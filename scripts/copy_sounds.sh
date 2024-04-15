#!/bin/bash
# This is horrible and I love it.
echo "Trying to make the sounds directory..."
mkdir mods/sounds/sounds/
echo "Done."

echo "Copying over the sound files..."
cp --verbose -r source/sounds/sounds/* mods/sounds/sounds/
echo "Done."

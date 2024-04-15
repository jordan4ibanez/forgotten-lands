#!/bin/bash

# Wow it's almost like someone who had no idea what they're doing made this.

echo "Creating release folder..."
rm -rf forgotten_lands_release/
mkdir forgotten_lands_release/
echo "Done."

# Now run the rest of my garbage.
make build_linux

# Now just shove everything important to run the game into that folder blindly.
echo "Blindly shoveling all built game components into the output directory!"
mkdir forgotten_lands_release/mods/
mkdir forgotten_lands_release/menu/
cp --verbose -r mods/* forgotten_lands_release/mods/
cp --verbose -r menu/* forgotten_lands_release/menu/
cp readme.MD forgotten_lands_release/readme.MD
cp LICENSE forgotten_lands_release/LICENSE
cp game.conf forgotten_lands_release/game.conf
echo "Finished blindly shoveling all build game components into the output directory!"

echo "Creating a zip of the build game!"
zip -r forgotten_lands_release.zip forgotten_lands_release/
echo "Build created."

echo "Cleaning release folder."
rm -rf forgotten_lands_release/
echo "Done."
#!/bin/bash

# Game textures.
echo "Optimizing game textures..."
for i in `find source/ -name "*.png" -type f`; do
  optipng $i
done

# Menu textures.
echo "Optimizing menu textures..."
for i in `find menu/ -name "*.png" -type f`; do
    optipng $i
done

echo "Done."
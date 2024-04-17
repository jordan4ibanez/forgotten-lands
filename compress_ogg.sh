#!/bin/bash

# `ffmpeg -i $i -c:a libvorbis -ac 1 -ar 48000 -b:a 32k -vbr on "$" -y`

# Game sounds.
echo "Optimizing game sounds..."
for i in `find source/ -name "*.ogg" -type f`; do
  # optipng $i
  # echo $i
  ogg_stripped=${i//".ogg"/}
  echo $ogg_stripped

  echo `ffmpeg -i ${ogg_stripped}.ogg -c:a libvorbis -ac 1 -ar 48000 -b:a 32k -vbr on ${ogg_stripped}_oof.ogg -y`
done

# Menu sounds.
# echo "Optimizing menu sounds..."
# for i in `find menu/ -name "*.ogg" -type f`; do
#     # optipng $i
#     echo $i
# done

echo "Done."
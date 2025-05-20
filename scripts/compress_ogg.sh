#!/bin/bash

# `ffmpeg -i $i -c:a libvorbis -ac 1 -ar 48000 -b:a 32k -vbr on "$" -y`

# Game sounds.
# echo "Optimizing game sounds..."
# for i in `find source/ -name "*.ogg" -type f`; do
#   ogg_stripped=${i//".ogg"/}
#   echo `ffmpeg -i ${ogg_stripped}.ogg -c:a libvorbis -ac 1 -ar 48000 -b:a 32k ${ogg_stripped}_oof.ogg -y`
#   echo `mv ${ogg_stripped}_oof.ogg ${ogg_stripped}.ogg`
# done

# Menu sounds.
# echo "Optimizing menu sounds..."
# for i in `find menu/ -name "*.ogg" -type f`; do
#   ogg_stripped=${i//".ogg"/}
#   echo `ffmpeg -i ${ogg_stripped}.ogg -c:a libvorbis -ac 1 -ar 48000 -b:a 32k ${ogg_stripped}_oof.ogg -y`
#   echo `mv ${ogg_stripped}_oof.ogg ${ogg_stripped}.ogg`
# done

# echo "Done."
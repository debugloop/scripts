#!/bin/bash
for file in $(ls IMAG*.JPG); do
    echo "Cropping $file ...";
    convert $file -fuzz 70% -trim +repage $(echo ${file} | rev | cut -d'.' -f'2-' | rev)-cropped.jpg
done;

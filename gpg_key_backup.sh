# Generates key-aa, key-ab, ...
gpg --export-secret-key 022A370E | paperkey --output-type raw | split -b 1500 - key-

# Convert each of them to a PNG image
for K in key-*; do
    dmtxwrite -e 8 $K > ${K}.png
    convert -resize 550x550 -page A4 ${K}.png -gravity center -format pdf ${K}.pdf
    convert ${K}.pdf -fill black -gravity South -pointsize 20 -annotate +0+50 ${K} ${K}.pdf
    rm ${K} ${K}.png
done

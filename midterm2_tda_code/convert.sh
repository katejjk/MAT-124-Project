#!/bin/sh

PDF=$1

xargs -I{} python -m table_ocr.extract_tables {}  | grep table > /tmp/extracted-tables.txt
cat /tmp/extracted-tables.txt | xargs -I{} python -m table_ocr.extract_cells {} | grep cells > /tmp/extracted-cells.txt
cat /tmp/extracted-cells.txt | xargs -I{} python -m table_ocr.ocr_image {} --psm 7 -l table-ocr

for image in $(cat /tmp/extracted-tables.txt); do
    dir=$(dirname $image)
    python -m table_ocr.ocr_to_csv $(find $dir/cells -name "*.txt")
done

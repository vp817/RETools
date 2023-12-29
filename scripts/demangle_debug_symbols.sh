#!/bin/bash

INPUT_FILE="bds_symbols.txt"
OUTPUT_FILE="demangled_bds_symbols.txt"

if [ ! -f "$INPUT_FILE" ]; then
  echo "No input file found."
  exit 1
fi

if [ -f "$OUTPUT_FILE" ]; then
  rm "$OUTPUT_FILE"
fi

while IFS= read -r symbol; do
  demangled_symbol=$(echo "$symbol" | c++filt)
  echo "$demangled_symbol" >> "$OUTPUT_FILE"
done < "$INPUT_FILE"

echo "Demangled symbols are saved in $OUTPUT_FILE."

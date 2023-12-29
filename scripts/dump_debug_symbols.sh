#!/bin/bash

DEBUG_SYMBOLS=./bedrock_server_symbols.debug
SYMBOLS_FILE=bds_symbols.txt
OUTPUT_FILE=demangled_symbols.txt

read -p "Enter the path to the debug symbols file [$DEBUG_SYMBOLS]: " debug_symbols_path
DEBUG_SYMBOLS="${debug_symbols_path:-$DEBUG_SYMBOLS}"

if [ ! -f "$DEBUG_SYMBOLS" ]; then
  echo "Debug symbols file not found."
  exit 1
fi

if [ -f "$SYMBOLS_FILE" ]; then
  rm "$SYMBOLS_FILE"
fi

objdump -t "$DEBUG_SYMBOLS" | awk '($7 ~ /^_/) {print $7}' > "$SYMBOLS_FILE"

if [ ! -s "$SYMBOLS_FILE" ]; then
  echo "No symbols found in the debug symbols file."
  exit 1
fi

echo "Mangled symbols are saved in $SYMBOLS_FILE."

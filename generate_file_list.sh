#!/bin/bash

# Script to generate a file listing for ffmpeg concat
# Output format: file 'filename.ogg'

# Check if voice_clone directory exists
if [ ! -d "voice_clone" ]; then
    echo "Error: voice_clone directory not found!"
    exit 1
fi

# Output file
OUTPUT_FILE="voice_clone/files.txt"

# Clear the output file if it exists
> "$OUTPUT_FILE"

# Generate the file listing
echo "Generating file listing in $OUTPUT_FILE..."

# Find all .ogg files and format them for ffmpeg concat
cd voice_clone
for file in *.ogg; do
    if [ -f "$file" ]; then
        echo "file '$file'" >> files.txt
    fi
done
cd ..

# Count the files
FILE_COUNT=$(grep -c "^file" "$OUTPUT_FILE" 2>/dev/null || echo 0)

if [ "$FILE_COUNT" -eq 0 ]; then
    echo "No .ogg files found in voice_clone directory"
    exit 1
else
    echo "Successfully generated listing for $FILE_COUNT files"
    echo "File list saved to: $OUTPUT_FILE"
fi

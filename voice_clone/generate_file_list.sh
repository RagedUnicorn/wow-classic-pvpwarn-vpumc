#!/bin/bash

# Script to generate a file listing for ffmpeg concat
# Output format: file 'filename.ogg'

# Script is now run from within voice_clone directory
# Output file
OUTPUT_FILE="files.txt"

# Clear the output file if it exists
> "$OUTPUT_FILE"

# Generate the file listing
echo "Generating file listing in $OUTPUT_FILE..."

# Find all .ogg files and format them for ffmpeg concat
for file in *.ogg; do
    if [ -f "$file" ]; then
        echo "file '$file'" >> "$OUTPUT_FILE"
    fi
done

# Count the files
FILE_COUNT=$(grep -c "^file" "$OUTPUT_FILE" 2>/dev/null || echo 0)

if [ "$FILE_COUNT" -eq 0 ]; then
    echo "No .ogg files found in current directory"
    exit 1
else
    echo "Successfully generated listing for $FILE_COUNT files"
    echo "File list saved to: $OUTPUT_FILE"
fi
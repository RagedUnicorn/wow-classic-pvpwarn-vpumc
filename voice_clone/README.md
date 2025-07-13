# Voice Cloning for Undead Male

This directory contains voice samples used to create a voice clone with [ElevenLabs](https://elevenlabs.io/).

## Overview

The voice samples in this directory are Undead Male voice lines extracted from World of Warcraft, sourced from [wowhead.com](https://www.wowhead.com/). These individual `.ogg` files are concatenated together to create a single audio file suitable for voice cloning.

## Process

1. **Collect Voice Samples**: Individual `.ogg` files containing various Undead Male voice lines are placed in this directory

2. **Generate File List**: Run the shell script to create a list of all files to be concatenated:
   ```bash
   ../generate_file_list.sh
   ```
   This creates `files.txt` containing the list of all `.ogg` files in the proper format for ffmpeg

3. **Concatenate Files**: Use Docker Compose to run ffmpeg and merge all audio files:
   ```bash
   docker-compose up
   ```
   This uses the `ragedunicorn/ffmpeg:7.1.1` Docker image to concatenate all files listed in `files.txt` into a single `merged.ogg` file

4. **Voice Cloning**: Upload `merged.ogg` to ElevenLabs to create a custom voice clone of the Undead Male character

## Files

- `*.ogg` - Individual voice samples from the Undead Male character
- `files.txt` - Generated list of files for ffmpeg concatenation (created by script)
- `merged.ogg` - Final concatenated audio file ready for voice cloning (created by ffmpeg)

## Requirements

- Docker and Docker Compose (for running ffmpeg)
- Bash shell (for running the file list generation script)
- ElevenLabs account (for creating the voice clone)

## Note

The generated files (`files.txt` and `merged.ogg`) are excluded from version control via `.gitignore`.

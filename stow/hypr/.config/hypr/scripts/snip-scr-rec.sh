#!/bin/bash

# Check if gpu-screen-recorder is already running
if pidof -q gpu-screen-recorder; then
    notify-send -t 1500 -u high "Recording Screen" "Already recording!"
    sleep 0.5
    exit 0
fi

# Define the video save path
video="$HOME/Videos/$(date +"Video_%Y-%m-%d_%H-%M-%S.mp4")"

# Ensure the Videos directory exists
mkdir -p "$HOME/Videos"

# Select a region using slurp
geometry=$(slurp)

# Check if the user selected a region (didn't press Escape)
if [ -z "$geometry" ]; then
    echo "Selection cancelled."
    exit 1
fi

# Format geometry for gpu-screen-recorder
# Slurp outputs: "x,y w x h"
# GSR expects:    "x,y,w,h"
geometry_formatted=$(echo "$geometry" | sed 's/x/,/g; s/ /,/')

# Start recording
# -w: window/region to record
# -f: fps
# -a: audio device
# -o: output file
gpu-screen-recorder -w "$geometry_formatted" -f 60 -a default_output -o "$video"

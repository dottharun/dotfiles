#!/bin/bash

# Define the i3-resurrect save directory
SAVE_DIR="$HOME/.i3/i3-resurrect"

# Ensure the directory exists before removing files
if [ -d "$SAVE_DIR" ]; then
    rm -f "$SAVE_DIR"/*
fi

# Get the workspace names and save them using i3-resurrect
i3-msg -t get_workspaces | \
    sed 's/},{/\n/g' | \
    awk -F, '{print $3}' | \
    awk -F: '{print $2}' | \
    xargs -n1 i3-resurrect save -w

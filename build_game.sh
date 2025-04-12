#!/bin/bash

# GameMaker Project Build Script
# ------------------------------

# Parse command line arguments
PROJECT_NAME="RPG Starter Pack_2"
COMMAND="Run"  # Default command

while [[ $# -gt 0 ]]; do
  case $1 in
    --project=*)
      PROJECT_NAME="${1#*=}"
      shift
      ;;
    --command=*)
      COMMAND="${1#*=}"
      shift
      ;;
    *)
      echo "Unknown parameter: $1"
      shift
      ;;
  esac
done

# Variables (change these as needed)
IGOR_PATH="/Users/Shared/GameMakerStudio2/Cache/runtimes/runtime-2024.13.0.238/bin/igor/osx/arm64/Igor"
PROJECT_DIR=$(dirname "$0")
PROJECT_PATH="$PROJECT_DIR/$PROJECT_NAME.yyp"
RUNTIME_PATH="/Users/Shared/GameMakerStudio2/Cache/runtimes/runtime-2024.13.0.238"
OUTPUT_DIR="$PROJECT_DIR/output"
OUTPUT_NAME="$PROJECT_NAME"

# Find your username_number folder automatically
USERNAME_NUMBER=$(ls ~/Library/Application\ Support/GameMakerStudio2/ | grep -v '_cache' | head -1)
LICENSE_PATH=~/Library/Application\ Support/GameMakerStudio2/$USERNAME_NUMBER/licence.plist

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Echo build information
echo "-------------- Build Info --------------"
echo "Project: $PROJECT_PATH"
echo "Command: $COMMAND"
echo "Output: $OUTPUT_DIR/$OUTPUT_NAME"
echo "License: $LICENSE_PATH"
echo "--------------------------------------"

# Build for macOS (VM runtime)
echo "Building macOS version..."
"$IGOR_PATH" \
  -project="$PROJECT_PATH" \
  -rp="$RUNTIME_PATH" \
  -lf="$LICENSE_PATH" \
  --temp="$OUTPUT_DIR/temp" \
  -config="Default" \
  -runtime=VM \
  -j=7 \
  $([ "$COMMAND" == "Run" ] && echo "--launch") \
  mac $COMMAND

# https://manual.gamemaker.io/monthly/en/Settings/Building_via_Command_Line.htm

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "Build completed successfully!"
else
    echo "Build failed with error code $?"
    exit 1
fi
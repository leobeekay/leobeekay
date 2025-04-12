#!/bin/bash

# GameMaker Project Run Script
# ---------------------------

# Parse command line arguments
PROJECT_NAME="RPG Starter Pack_2"

while [[ $# -gt 0 ]]; do
  case $1 in
    --project=*)
      PROJECT_NAME="${1#*=}"
      shift
      ;;
    *)
      echo "Unknown parameter: $1"
      shift
      ;;
  esac
done

# Execute the build script with Run command
./build_game.sh --project="$PROJECT_NAME" --command=Run
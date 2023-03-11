#!/bin/bash

WATCH_DIR="/mnt/wd/moodle-dl"
DEST_DIR="/mnt/wd/consume"
PROCESSED_FILE="/mnt/wd/services/mdl-watcher/processed_files.txt"

# Watch for new files in $WATCH_DIR
inotifywait -m -r -q --format '%w%f' -e create,moved_to "$WATCH_DIR" |
while read FILENAME
do
  if [[ "${FILENAME,,}" =~ \.(doc|docx|xls|xlsx|ppt|pptx|pdf)$ ]]; then
    echo "Found new file: \"$FILENAME\""
    # Check if the file has been processed before
    if grep -qFx "$(basename "$FILENAME")" "$PROCESSED_FILE"; then
      echo "Skipping \"$FILENAME\" (already processed)"
    else
      # Check if the file is an office file
      if [[ "${FILENAME,,}" =~ \.(doc|docx|xls|xlsx|ppt|pptx)$ ]]; then
        echo "Converting \"$FILENAME\" to PDF"
        # Convert the office file to PDF using LibreOffice
        libreoffice --headless --convert-to pdf --outdir "$DEST_DIR" "$FILENAME"
      else
        echo "Moving \"$FILENAME\" to \"$DEST_DIR\""
        # Move the PDF file to $DEST_DIR
        mv "$FILENAME" "$DEST_DIR"
      fi
      # Record the processed file in the processed_files.txt file
      echo "$(basename "$FILENAME")" >> "$PROCESSED_FILE"
    fi
  fi
done &

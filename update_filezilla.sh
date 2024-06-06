#!/bin/bash

URL="https://filezilla-project.org/prodownload.php?beta=0"
USER_AGENT="Mozilla/5.0 (X11; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0"
ACCEPT="text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8"
LANGUAGE="it-IT,it;q=0.8,en-US;q=0.5,en;q=0.3"
ENCODING="gzip, deflate, br, zstd"
CONTENT_TYPE="application/x-www-form-urlencoded"
ORIGIN="https://filezilla-project.org"
REFERER="https://filezilla-project.org/prodownload.php"
OUTPUT_FILE="filezilla_pro.tar.xz"
DEST_DIR="$HOME/bin/FileZilla3"
KEY_FILE="$HOME/.fzprokey"

# Check if key file exists
if [ ! -f "$KEY_FILE" ]; then
    echo "Error: The .fzprokey file does not exist in the home directory."
    exit 1
fi

# Read .fzprokey file
KEY=$(cat "$KEY_FILE")

# Curl command to download file
curl "$URL" -X POST \
    -H "User-Agent: $USER_AGENT" \
    -H "Accept: $ACCEPT" \
    -H "Accept-Language: $LANGUAGE" \
    -H "Accept-Encoding: $ENCODING" \
    -H "Content-Type: $CONTENT_TYPE" \
    -H "Origin: $ORIGIN" \
    -H "Connection: keep-alive" \
    -H "Referer: $REFERER" \
    --data-raw "key=$KEY&mail=&number=&platform=linux&download_program=Start+download+of+FileZilla+Pro&platform_cli=win&platform_fzpes=win" \
    --output "$OUTPUT_FILE"

# Check if file has been downloaded
if [ -f "$OUTPUT_FILE" ]; then
    echo "File downloaded successfully."
    # Extract the downloaded file
    tar -xvf "$OUTPUT_FILE"

    # Find the extracted directory (assuming the name starts with "FileZilla")
    EXTRACTED_DIR=$(tar -tf "$OUTPUT_FILE" | head -1 | cut -f1 -d"/")

    # Check if the extracted directory was found
    if [ -d "$EXTRACTED_DIR" ]; then
        echo "Extracted directory found: $EXTRACTED_DIR"
        # Move the extracted directory to the desired destination
        rm -rf "$DEST_DIR"  # Remove the existing directory if present
        mv "$EXTRACTED_DIR" "$DEST_DIR"  # Move the new directory

        echo "Update completed. The new version of FileZilla has been moved to $DEST_DIR"
    else
        echo "Error: The extracted directory was not found."
    fi

    # Remove the downloaded file
    rm "$OUTPUT_FILE"
else
    echo "Error: The file was not downloaded correctly."
fi
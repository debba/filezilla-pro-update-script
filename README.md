# FileZilla Pro Update Script

This README provides instructions on how to use the `update_filezilla.sh` script to automate the process of downloading, extracting, and updating FileZilla Pro on your system.

## Prerequisites

Before running the script, ensure the following:
- `curl` and `tar` are installed on your system.
- The `.fzprokey` file exists in your home directory (`~/.fzprokey`) and contains a valid FileZilla Pro key.

## Usage

1. **Make the Script Executable**

   Run the following command to make the script executable:

   ```bash
   chmod +x update_filezilla.sh
   ```

2. **Verify the .fzprokey File**

Ensure that the .fzprokey file is present in your home directory and contains your FileZilla Pro key. You can check its contents with:

   ```bash
   cat ~/.fzprokey
   ```

3. **Run the Script**

Execute the script by running:

   ```bash
   ./update_filezilla.sh
   ```

## Script Description

The update_filezilla.sh script performs the following steps:

- Checks if the .fzprokey file exists in the home directory. If the file is not found, the script stops and displays an error message.
- Reads the FileZilla Pro key from the .fzprokey file.
- Uses curl to download the FileZilla Pro tarball from the official FileZilla website.
- Checks if the download was successful.
- Extracts the contents of the downloaded tarball.
- Moves the extracted FileZilla directory to $HOME/bin, replacing any existing FileZilla directory.

## Notes

- The script will stop and display an error message if the .fzprokey file is not found in the home directory.
- The script assumes that the downloaded archive contains a directory starting with "FileZilla". Adjust the script if the directory structure changes.
- Ensure you have the necessary permissions to write to the target directory ($HOME/bin).

## License

This script is provided "as is", without warranty of any kind. Use it at your own risk.
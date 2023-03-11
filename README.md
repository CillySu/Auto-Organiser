# Auto-Organiser
Bridging the gap between Moodle-dl and Paperless-ngx, as a linux service.

Customise the shell scripts $WATCH_DIR and $DEST_DIR to automatically convert new files (DOC/DOCX/PPT/PPTX/XLS/XLSX) to PDFs and move them to a certain folder, designed with the `consume` folder for `Paperless` in mind. Any new PDFs are simply moved.

The script keeps track of files it has already processed to avoid duplicates.

Can be run either as a systemd service or in tmux/screen. 

##Dependencies
- *nix machine
- libreoffice (for office file conversion)

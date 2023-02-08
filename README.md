# Banana Utils
My collection of CLI utilities written in multiple languages

This repository is newborn and as of now there are not many published utilities

All programs are cross-platform, with the exception of bash scripts (shell folder) which do not run on Windows without WSL and might not work on other systems if dependencies are not satisfied

# How to use
All utilities were written in interpreted languages, and so they require the same interpreters to run. Install Lua, Ruby, Python and Bash to run the respective utilities.

# Folders
This project is divided by folders, each representing a category of tasks the programs do

### File utils
General file/directory manipulation, including copying, moving, compression, etc
- **bananarchive.py:** Quick copying of project/code files for organized backup
- **crystalflate.rb:** Deflate file compressor and decompressor

### Misc
All utilities that are not included in any category
- **subcat.rb:** Prints out the lines of a text file that contain a specific string

### Security
Utilities related to security, passwords, encryption, etc
- **passgen.lua:** Old password generator, use passgen.rb instead
- **passgen.rb:** ASCII and dictionary-based password generator

### Shell
All utilities written in Bash go in here
- **imagearchive2.sh:** Shell script that transcodes images to archive and compress them efficiently

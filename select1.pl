# Open a FileHandle in Write Mode.
open(File, ">", "Hello.txt");

# This sets File as the default FileHandle
select File;

# Writes to File
print("This goes to the File.");

# Writes to File
print File "\nThis goes to the File too.";

# This sets STDOUT as default FileHandle
select STDOUT;
print("This goes to the console.");

# Close the FileHandle.
close(File);

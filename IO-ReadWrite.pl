#!/usr/bin/perl

# Opening File Hello.txt in Read mode
open(r, "<", "Hello.txt");

# Printing the existing content of the file
print("Existing Content of Hello.txt: " . <r>);

# Opening File in Write mode
open(w, ">", "Hello.txt");

# Set r to the beginning of Hello.txt
seek r, 0, 0;

print "\nWriting to File...";

# Writing to Hello.txt using print
print w "Content of this file is changed";

# Closing the FileHandle
close(w);

# Set r to the beginning of Hello.txt
seek r, 0, 0;

# Print the current contents of Hello.txt
print("\nUpdated Content of Hello.txt: ".<r>);

# Close the FileHandle
close(r);

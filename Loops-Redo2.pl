#!/usr/bin/perl -w 
  
$a = 1; 
  
# Assigning label to loop 
GFG: { 
   $a = $a + 5; 
   redo GFG if ($a < 10); 
} 
  
# Printing the value 
print "$a\n"; 

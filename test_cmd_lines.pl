my $cmd = "$base_path/bin/do_send $prod_id $dist_type \"$final_address\" $file_to_send '$final_post_proc'";
my $cmd_print = "$base_path/bin/do_send $prod_id $dist_type <address> $file_to_send '$final_post_proc'";

print "\$cmd = $cmd\n";
print "\$cmd_print = $cmd_print\n";

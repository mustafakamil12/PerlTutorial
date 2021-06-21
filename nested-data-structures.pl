%sue = (
'name' => 'Sue',
'age' => '45'
);

%john = (
'name' => 'John',
'age' => '20'
);

%peggy = (
'name' => 'Peggy',
'age' => '16'
);

@children = (\%john, \%peggy);
$sue{'children'} = \@children;
print $sue{children}->[1]->{'age'} . "\n";
print "--------------------------\n";
print $sue{children}[1]{'age'} ;

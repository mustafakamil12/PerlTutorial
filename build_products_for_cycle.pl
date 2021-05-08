$sth = [('BOFADLYFCSTN', 'frmt_bofa_daily_fcst', 'bofa_stn', '', ''), ('SARACENOBS', 'obs_saracen', 'saracen_stn', None, ''), ('NGRID_LI', 'frmt_ngrid_li', 'single_FRG', None, ''), ('USEFCST', 'frmt_usenergy', 'usenergy_stn', None, ''), ('DTEHOURLYFCST', 'frmt_dtehourly', 'dte_new_stn', None, '')];

my $row_ref;
$prod_count = 0;
while ($row_ref = $sth)
  {
      $prod_name[$prod_count] = $$row_ref[0];
      $prod_count++;
  #        build_product_from_info @$row_ref;
  }

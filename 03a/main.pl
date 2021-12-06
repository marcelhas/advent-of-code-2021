#!/usr/bin/perl
use strict;
use warnings;

# return array, iterate frequency_arr and insert $true or $false for result array
sub frequency_arr_to_bin {
  my ($true, $false, $len, @frequency_arr) = @_;

  my @arr;
  foreach my $item (@frequency_arr) {
    my $count = $len/2;
    if ($item ge $count) {
      push @arr, $true;
    } else {
      push @arr, $false;
    }
  }
  return @arr;
}

# return number, convert array of bits to decimal number
sub bin_to_dec {
  my @bit_arr = reverse(@_);
  my $agg = 0;
  my $k = 1;
  foreach my $item (@bit_arr)
  {
    $agg+=$item*$k;
    $k*=2;
  }
  return $agg
}

# return array, array[x] returns number of 1 bits in column x
sub get_frequency_array {
  my @counts = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

  # count 1 bits, aggregate in @counts
  while (<>) {
    my $index = 0;
    foreach my $char (split //, $_) {
      chomp $char;
      if ("$char" eq "1") {
        $counts[$index]+=1;
      }
      $index+=1;
    }
  }
  return @counts
}

sub main {
  my @frequency_arr = get_frequency_array();

  # aggregate bits in array
  my @gamma_arr = frequency_arr_to_bin(1, 0, $., @frequency_arr);
  my @epsilon_arr = frequency_arr_to_bin(0, 1, $., @frequency_arr);

  # convert binary array to decimal number
  my $gamma = bin_to_dec(@gamma_arr);
  my $epsilon = bin_to_dec(@epsilon_arr);

  my $result = $gamma * $epsilon;
  print "$result\n";
}

main()

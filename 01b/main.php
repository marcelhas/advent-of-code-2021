<?php

const WINDOW_SIZE = 3;

$windows = [];
$window_count = 0;
$increases = 0;

$handle = $argc >= 2 ? fopen($argv[1], "r") : STDIN;
while (($line = fgets($handle)) !== false) {
  // add a window on every line
  array_push($windows, []);
  $window_count++;

  $overfull = $window_count > WINDOW_SIZE;
  // add current number to each window
  // skip first if too many windows exist
  for ($i=$overfull ? 1 : 0; $i < $window_count; $i++) {
    array_push($windows[$i], (int)$line);
  }

  if ($overfull) {
    if (array_sum($windows[0]) < array_sum($windows[1])) $increases++;
    array_shift($windows);
    $window_count--;
  }
}
fclose($handle);

echo($increases)

?>

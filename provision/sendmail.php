<?php

$dir = '/vagrant/mailbox';

$data = '';

$f = fopen('php://stdin', 'r'); 	
while(!feof($f)) { 
	$data .= fgets($f, 255);
} 
fclose($f);

$data = str_replace('\r', '', $data);
$data = str_replace('\n', '\r\n', $data);

$i = 0;
$addon = '';
while (file_exists($fname = ($dir . '/' . date('Y-m-d-H-i-s') . $addon . '.txt'))) {
	$i++;
	$addon = '-' . $i;
}	

file_put_contents($fname, $data);

#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$username = exec('whoami');
if ($username !== 'nginx') {
	echo "This command should be run as nginx.\n";
	echo "Currently running as {$username}\n";
	echo 'sudo su -s /bin/bash -c "' . __FILE__ . '" nginx;' . "\n";
	exit;
}

BeaconCloudStorage::RunQueue();

?>

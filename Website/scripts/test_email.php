#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

if ($argc != 3) {
	echo "Usage: test_email.php subject email,email,email\n";
	exit;
}

$subject = $argv[1];
$emails = explode(',', $argv[2]);

foreach ($emails as $email) {
	BeaconLogin::SendVerification(trim($email), null, $subject);
}

?>
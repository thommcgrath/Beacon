<?php

require($_SERVER['DOCUMENT_ROOT'] . '/php/engine.php');
require_once($_SERVER['DOCUMENT_ROOT'] . '/php/mailchimp.php');

$email_address = array_key_exists('email', $_POST) ? $_POST['email'] : '';
$first_name = array_key_exists('first_name', $_POST) ? $_POST['first_name'] : '';
$last_name = array_key_exists('last_name', $_POST) ? $_POST['last_name'] : '';

if ($email_address == '') {
	exit;
}

try {
	MailChimp::SubscribeUser('b0da56885c', $email_address, $first_name, $last_name);
} catch (MailChimpException $e) {
}

?>
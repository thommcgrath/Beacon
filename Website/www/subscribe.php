<?php

require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
header('Content-Type: application/json');

$email_address = array_key_exists('email', $_POST) ? $_POST['email'] : '';
$first_name = array_key_exists('first_name', $_POST) ? $_POST['first_name'] : '';
$last_name = array_key_exists('last_name', $_POST) ? $_POST['last_name'] : '';

if ($email_address == '') {
	echo json_encode(array('success' => false, 'reason' => 'No email address'));
	exit;
}

try {
	MailChimp::SubscribeUser('b0da56885c', $email_address, $first_name, $last_name);
	echo json_encode(array('success' => true));
} catch (MailChimpException $e) {
	echo json_encode(array('success' => false, 'reason' => $e->getMessage(), 'detail' => $e->getDetails()));
}

abstract class MailChimp {
	private static function URL() {
		return 'https://us15.api.mailchimp.com/3.0';
	}
	
	private static function MakeRequest(string $path, array $payload) {
		$api_key = BeaconCommon::GetGlobal('MailChimp_API_Key');
		if ($api_key === null) {
			trigger_error('Config file did not specify MailChimp_API_Key', E_USER_ERROR);
		}
		
		$body = json_encode($payload);
		
		$handle = curl_init(self::URL() . $path);
		curl_setopt($handle, CURLOPT_HTTPHEADER, array(                                                                          
		    'Content-Type: application/json',                                                                                
		    'Content-Length: ' . strlen($body))                                                                       
		);
		curl_setopt($handle, CURLOPT_USERPWD, 'user:' . $api_key);
		curl_setopt($handle, CURLOPT_TIMEOUT, 15);
		curl_setopt($handle, CURLOPT_CUSTOMREQUEST, 'POST');                                                                     
		curl_setopt($handle, CURLOPT_POSTFIELDS, $body);
		curl_setopt($handle, CURLOPT_RETURNTRANSFER, true);
		$return = curl_exec($handle);
		$http_status = curl_getinfo($handle, CURLINFO_HTTP_CODE);
		curl_close($handle);
		
		if ($http_status == 200) {
			return true;
		} else {
			$error = json_decode($return, true);
			throw new MailChimpException($error['title'], $error['detail']);
		}
	}
	
	public static function SubscribeUser(string $list_id, string $email_address, string $first_name, string $last_name) {
		$payload = array(
			'email_address' => $email_address,
			'email_type' => 'text',
			'status' => 'pending',
			'ip_signup' => $_SERVER['REMOTE_ADDR'],
			'merge_fields' => array(
				'FNAME' => $first_name,
				'LNAME' => $last_name
			)
		);
		
		self::MakeRequest('/lists/' . $list_id . '/members/', $payload);
	}
}

class MailChimpException extends \Exception {
	private $detail = '';
	
	public function __construct($title, $detail) {
		parent::__construct($title);
		$this->detail = $detail;
	}
	
	public function getDetails() {
		return $this->detail;
	}
}

?>
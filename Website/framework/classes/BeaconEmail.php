<?php

abstract class BeaconEmail {
	public static function SendMail(string $recipient, string $subject, string $body_plain, string $body_html = null) {
		if (is_null($body_html)) {
			$body_html = nl2br(htmlentities($body_plain));
			while (preg_match('/&lt;(http[^>]+)&gt;/', $body_html, $matches) === 1) {
				$body_html = str_replace($matches[0], '<a href="' . $matches[1] . '">' . $matches[1] . '</a>', $body_html);
			}
		}
		
		$boundary = BeaconCommon::GenerateUUID();
		
		ob_start();
		include(BeaconCommon::FrameworkPath() . '/templates/email.php');
		$body_html = ob_get_contents();
		ob_end_clean();
		
		$headers = [
			'X-Postmark-Server-Token: ' . BeaconCommon::GetGlobal('Postmark_Key'),
			'Content-Type: application/json'
		];
		
		$body = [
			'From' => '"Beacon" <help@' . BeaconCommon::Domain() . '>',
			'To' => $recipient,
			'Subject' => $subject,
			'HtmlBody' => $body_html,
			'TextBody' => $body_plain,
			'TrackOpens' => false,
			'TrackLinks' => 'None'
		];
		
		$curl = curl_init('https://api.postmarkapp.com/email');
		curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($body));
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'POST');
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		$response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		if ($status < 200 || $status >= 300) {
			return false;
		}
		
		return true;
	}
	
	// Checks if the address is syntactically valid.
	public static function IsEmailValid(string $email) {
		return filter_var($email, FILTER_VALIDATE_EMAIL);
	}
}

?>

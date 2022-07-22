<?php

abstract class BeaconEmail {
	public static function SendMail(string $recipient, string $subject, string $body_plain, string $body_html = null): bool {
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
			'From' => '"Beacon" <help@usebeacon.app>',
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
	public static function IsEmailValid(string $email): bool {
		return filter_var($email, FILTER_VALIDATE_EMAIL);
	}
	
	// Checks with CleanTalk if the address is valid
	public static function QuickVerify(string $email): bool {
		$user = \BeaconUser::GetByEmail($email);
		if (is_null($user) === false) {
			return true;
		}
		
		$cache_key = sha1('CleanTalk Result ' . strtolower($email));
		$url = 'https://api.cleantalk.org/?method_name=email_check&auth_key=' . urlencode(BeaconCommon::GetGlobal('CleanTalk Email Check Key')) . '&email=' . urlencode($email);
		$body = BeaconCache::Get($cache_key);
		if (is_null($body)) {
			$curl = curl_init($url);
			curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
			$body = curl_exec($curl);
			$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
			if ($status !== 200) {
				// This isn't really true, but err on the side of caution
				return true;
			}
			BeaconCache::Set($cache_key, $body);
		}
		
		$parsed = json_decode($body, TRUE);
		$data = $parsed['data'];
		$result = $data[$email]['result'];
		switch ($result) {
		case 'NOT_EXISTS':
		case 'MX_FAIL':
		case 'MX_FAIL':
			// Confirmed failure
			return false;
		}
		
		return true;
	}
}

?>

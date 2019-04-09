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
		
		$headers = array(
			'MIME-Version' => '1.0',
			'Content-Type' => 'multipart/alternative; boundary="' . $boundary . '"',
			'From' => '"Beacon for Ark" <forgotmyparachute@beaconapp.cc>'
		);
		
		$parts = array(
			"Content-Type: text/plain; charset=UTF-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n" . quoted_printable_encode($body_plain),
			"Content-Type: text/html; charset=UTF-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n" . quoted_printable_encode($body_html)
		);
		$body = "--$boundary\r\n" . implode("\r\n--$boundary\r\n", $parts) . "\r\n--$boundary--";
		
		return mail($recipient, $subject, $body, $headers, '-f forgotmyparachute@beaconapp.cc');
	}
}

?>
<?php

namespace BeaconAPI\v4;
use BeaconAPI\v4\Core;
use BeaconCommon, BeaconEmail, BeaconEncryption, Exception;

class EmailVerificationCode implements \JsonSerializable {
	protected $email = null;
	protected $email_id = null;
	protected $code = null;
	protected $code_hash = null;
	protected $code_encrypted = null;
	protected $verified = false;
	
	protected function __construct() {	
	}
	
	public static function Fetch(string $email): ?EmailVerificationCode {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT uuid_for_email($1) AS email_id;', $email);
		if (is_null($rows->Field('email_id'))) {
			return null;
		}
		$email_id = $rows->Field('email_id');
		
		$rows = $database->Query('SELECT code_hash, code_encrypted, verified FROM public.email_verification_codes WHERE email_id = $1 AND expiration > CURRENT_TIMESTAMP;', $email_id);
		if ($rows->RecordCount() !== 1) {
			return null;
		}
		
		$code = new static();
		$code->email = $email;
		$code->email_id = $email_id;
		$code->code_hash = $rows->Field('code_hash');
		$code->code_encrypted = $rows->Field('code_encrypted');
		$code->verified = $rows->Field('verified');
		return $code;
	}
	
	public static function Create(string $email, ?string $key = null): EmailVerificationCode {
		$database = BeaconCommon::Database();
		if (is_null($key) === false) {
			$current_code = static::Fetch($email);
			if (is_null($current_code) === false && $current_code->verified === false && $current_code->DecryptCode($key)) {
				return $current_code;
			}
		}
			
		$database->BeginTransaction();
		$rows = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $email);
		$email_id = $rows->Field('email_id');
		
		$code = BeaconCommon::GenerateRandomKey(6, '0123456789');
		$code_hash = base64_encode(hash('sha512', $email_id . $code, true));
		$code_encrypted = null;
		if (is_null($key) === false) {
			$code_encrypted = base64_encode((BeaconEncryption::SymmetricEncrypt($email_id . $key, $code)));	
		}
		
		$database->Query('DELETE FROM public.email_verification_codes WHERE email_id = $1 OR expiration < CURRENT_TIMESTAMP;', $email_id);
		$database->Query('INSERT INTO public.email_verification_codes (email_id, code_hash, code_encrypted) VALUES ($1, $2, $3);', $email_id, $code_hash, $code_encrypted);
		$database->Commit();
		
		$subject = 'Enter code ' . $code . ' in Beacon to verify your email address';
		$code_spaced = implode(' ', str_split($code));
		$url = BeaconCommon::AbsoluteURL('/account/login/?email=' . urlencode($email) . '&code=' . urlencode($code));
		$plain = "You recently started the process of creating a new Beacon account or recovery of an existing Beacon account. In order to complete the process, please enter the code below.\n\n$code\n\nAlternatively, you may use the following link to continue the process automatically:\n\n$url\n\nIf you need help, simply reply to this email." . (empty(BeaconCommon::RemoteAddr() === false) ? ' This process was started from a device with an ip address similar to ' . BeaconCommon::RemoteAddr() : '');
		$html = '<center>You recently started the process of creating a new Beacon account or recovery of an existing Beacon account. In order to complete the process, please enter the code below.<br /><br /><span style="font-weight:bold;font-size: x-large">' . $code_spaced . '</span><br /><br />Alternatively, you may use the following link to continue the process automatically:<br /><br /><a href="' . $url . '">' . $url . '</a><br /><br />If you need help, simply reply to this email.' . (empty(BeaconCommon::RemoteAddr() === false) ? ' This process was started from a device with an ip address similar to <span style="font-weight:bold">' . htmlentities(BeaconCommon::RemoteAddr()) . '</span>' : '') . '</center>';
		BeaconEmail::SendMail($email, $subject, $plain, $html);
		
		$obj = new static();
		$obj->email = $email;
		$obj->email_id = $email_id;
		$obj->code = $code;
		$obj->code_hash = $code_hash;
		$obj->code_encrypted = $code_encrypted;
		$obj->verified = false;
		return $obj;
	}
	
	public static function IsEmailVerified(string $email, string $code): bool {
		$database = BeaconCommon::Database();
		$rows = $database->Query("SELECT uuid_for_email($1) AS email_id;", $email);
		$email_id = $rows->Field('email_id');
		if (is_null($email_id)) {
			return false;
		}
		
		$code_hash = base64_encode(hash('sha512', $email_id . $code, true));
		$rows = $database->Query('SELECT email_id FROM public.email_verification_codes WHERE email_id = $1 AND code_hash = $2 AND expiration > CURRENT_TIMESTAMP;', $email_id, $code_hash);
		return $rows->RecordCount() === 1;
	}
	
	public function CheckCode(string $code): bool {
		if (is_null($this->code) === false) {
			return $code === $this->code;
		}
		
		if ($this->code_hash ===  base64_encode(hash('sha512', $this->email_id . $code, true))) {
			$this->code = $code;
			if ($this->verified === false) {
				$database = BeaconCommon::Database();
				$database->BeginTransaction();
				$database->Query('UPDATE public.email_verification_codes SET verified = TRUE WHERE email_id = $1;', $this->email_id);
				$database->Commit();
				$this->verified = true;
			}
			return true;
		}
		
		return false;
	}
	
	public function DecryptCode(string $key): bool {
		if (is_null($this->code) === false) {
			return true;
		} else if (is_null($this->code_encrypted)) {
			return false;
		}
		
		try {
			$decrypted = BeaconEncryption::SymmetricDecrypt($this->email_id . $key, base64_decode($this->code_encrypted));
			$this->code = $decrypted;
			return true;
		} catch (Exception $err) {
			return false;
		}
	}
	
	public function jsonSerialize(): mixed {
		$code = null;
		if ($this->verified) {
			if (is_null($this->code) === false) {
				$code = $this->code;
			} else {
				$code = $this->code_encrypted;
			}	
		}
		return [
			'email' => $this->email,
			'code' => $code,
			'verified' => $this->verified
		];	
	}
}

?>

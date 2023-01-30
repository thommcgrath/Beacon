<?php

namespace BeaconAPI\v4;
use BeaconAPI\v4\Core;
use BeaconCommon, BeaconEmail, BeaconEncryption, Exception;

class EmailVerificationCode implements \JsonSerializable {
	protected $email = null;
	protected $emailId = null;
	protected $code = null;
	protected $codeHashed = null;
	protected $codeEncrypted = null;
	protected $verified = false;
	
	protected function __construct() {	
	}
	
	public static function Fetch(string $email): ?EmailVerificationCode {
		if (BeaconEmail::IsEmailValid($email) === false) {
			return null;
		}
		
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT uuid_for_email($1) AS email_id;', $email);
		if (is_null($rows->Field('email_id'))) {
			return null;
		}
		$emailId = $rows->Field('email_id');
		
		$rows = $database->Query('SELECT code_hash, code_encrypted, verified FROM public.email_verification_codes WHERE email_id = $1 AND expiration > CURRENT_TIMESTAMP;', $emailId);
		if ($rows->RecordCount() !== 1) {
			return null;
		}
		
		$code = new static();
		$code->email = $email;
		$code->emailId = $emailId;
		$code->codeHashed = $rows->Field('code_hash');
		$code->codeEncrypted = $rows->Field('code_encrypted');
		$code->verified = $rows->Field('verified');
		return $code;
	}
	
	public static function Create(string $email, array $params = []): ?EmailVerificationCode {
		$database = BeaconCommon::Database();
		$key = $params['key'] ?? null;
		if (is_null($key) === false) {
			$current_code = static::Fetch($email);
			if (is_null($current_code) === false && $current_code->verified === false && $current_code->DecryptCode($key)) {
				return $current_code;
			}
		}
			
		$database->BeginTransaction();
		$rows = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $email);
		$emailId = $rows->Field('email_id');
		
		$code = BeaconCommon::GenerateRandomKey(6, '0123456789');
		$codeHashed = static::PrepareHash($emailId, $code);
		$codeEncrypted = null;
		if (is_null($key) === false) {
			$codeEncrypted = base64_encode((BeaconEncryption::SymmetricEncrypt($emailId . $key, $code)));	
		} else {
			$params['code'] = $code;
		}
		ksort($params);
		
		$database->Query('DELETE FROM public.email_verification_codes WHERE email_id = $1 OR expiration < CURRENT_TIMESTAMP;', $emailId);
		$database->Query('INSERT INTO public.email_verification_codes (email_id, code_hash, code_encrypted) VALUES ($1, $2, $3);', $emailId, $codeHashed, $codeEncrypted);
		
		$subject = 'Enter code ' . $code . ' in Beacon to verify your email address';
		$code_spaced = implode(' ', str_split($code));
		$relativeUrl = '/account/login?email=' . urlencode($email);
		if (count($params) > 0) {
			$relativeUrl .= '&' . http_build_query($params);	
		}
		$url = BeaconCommon::AbsoluteURL($relativeUrl);
		$plain = "You recently started the process of creating a new Beacon account or recovery of an existing Beacon account. In order to complete the process, please enter the code below.\n\n$code\n\nAlternatively, you may use the following link to continue the process automatically:\n\n$url\n\nIf you need help, simply reply to this email." . (empty(BeaconCommon::RemoteAddr() === false) ? ' This process was started from a device with an ip address similar to ' . BeaconCommon::RemoteAddr() : '');
		$html = '<center>You recently started the process of creating a new Beacon account or recovery of an existing Beacon account. In order to complete the process, please enter the code below.<br /><br /><span style="font-weight:bold;font-size: x-large">' . $code_spaced . '</span><br /><br />Alternatively, you may use the following link to continue the process automatically:<br /><br /><a href="' . $url . '">' . $url . '</a><br /><br />If you need help, simply reply to this email.' . (empty(BeaconCommon::RemoteAddr() === false) ? ' This process was started from a device with an ip address similar to <span style="font-weight:bold">' . htmlentities(BeaconCommon::RemoteAddr()) . '</span>' : '') . '</center>';
		if (BeaconEmail::SendMail($email, $subject, $plain, $html) === false) {
			$database->Rollback();
			return null;
		}
		$database->Commit();
		
		$obj = new static();
		$obj->email = $email;
		$obj->emailId = $emailId;
		$obj->code = $code;
		$obj->codeHashed = $codeHashed;
		$obj->codeEncrypted = $codeEncrypted;
		$obj->verified = false;
		return $obj;
	}
	
	public static function IsEmailVerified(string $email, string $code): bool {
		$database = BeaconCommon::Database();
		$rows = $database->Query("SELECT uuid_for_email($1) AS email_id;", $email);
		$emailId = $rows->Field('email_id');
		if (is_null($emailId)) {
			return false;
		}
		
		$codeHashed = static::PrepareHash($emailId, $code);
		$rows = $database->Query('SELECT email_id FROM public.email_verification_codes WHERE email_id = $1 AND code_hash = $2 AND expiration > CURRENT_TIMESTAMP;', $emailId, $codeHashed);
		if ($rows->RecordCount() === 0) {
			return false;
		}
		
		$database->BeginTransaction();
		$database->Query('UPDATE public.email_verification_codes SET verified = TRUE WHERE email_id = $1;', $emailId);
		$database->Commit();
		return true;
	}
	
	public function CheckCode(string $code): bool {
		if (is_null($this->code) === false) {
			return $code === $this->code;
		}
		
		if ($this->codeHashed === static::PrepareHash($this->emailId, $code)) {
			$this->code = $code;
			if ($this->verified === false) {
				$database = BeaconCommon::Database();
				$database->BeginTransaction();
				$database->Query('UPDATE public.email_verification_codes SET verified = TRUE WHERE email_id = $1;', $this->emailId);
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
		} else if (is_null($this->codeEncrypted)) {
			return false;
		}
		
		try {
			$decrypted = BeaconEncryption::SymmetricDecrypt($this->emailId . $key, base64_decode($this->codeEncrypted));
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
				$code = $this->codeEncrypted;
			}	
		}
		return [
			'email' => $this->email,
			'code' => $code,
			'verified' => $this->verified
		];	
	}
	
	public static function Clear(string $email): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM public.email_verification_codes WHERE email_id = uuid_for_email($1);', $email);
		$database->Commit();
	}
	
	public function Delete(): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM public.email_verification_codes WHERE email_id = $1;', $this->emailId);
		$database->Commit();
	}
	
	public function Code(): ?string {
		return $this->code;
	}
	
	public static function PrepareHash(string $emailId, string $code): string {
		return base64_encode(hash('sha3-512', $emailId . $code, true));
	}
}

?>

<?php

namespace BeaconAPI\v4;
use BeaconAPI\v4\Core;
use BeaconCommon, BeaconEmail, BeaconEncryption, Exception, JsonSerializable;

class EmailVerificationCode implements JsonSerializable {
	const kTemplateNewAccount = 'new-account';
	const kTemplateConfirmChange = 'confirm-change';
	
	protected $email = null;
	protected $emailId = null;
	protected $code = null;
	protected $codeHashed = null;
	protected $codeEncrypted = null;
	protected $verified = false;
	
	protected function __construct() {	
	}
	
	public static function Fetch(string $email, string $code): ?EmailVerificationCode {
		if (BeaconEmail::IsEmailValid($email) === false) {
			return null;
		}
		
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT uuid_for_email($1) AS email_id;', $email);
		if (is_null($rows->Field('email_id'))) {
			return null;
		}
		$emailId = $rows->Field('email_id');
		$codeHashed = static::PrepareHash($emailId, $code);
		
		$rows = $database->Query('SELECT code_encrypted, verified FROM public.email_verification_codes WHERE code_hash = $1 AND expiration > CURRENT_TIMESTAMP;', $codeHashed);
		if ($rows->RecordCount() !== 1) {
			return null;
		}
		
		$verifier = new static();
		$verifier->email = $email;
		$verifier->emailId = $emailId;
		$verifier->code = $code;
		$verifier->codeHashed = $codeHashed;
		$verifier->codeEncrypted = $rows->Field('code_encrypted');
		$verifier->verified = $rows->Field('verified');
		return $verifier;
	}
	
	public static function Search(string $email): array {
		if (BeaconEmail::IsEmailValid($email) === false) {
			return null;
		}
		
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT email_id, code_hash, code_encrypted, verified FROM public.email_verification_codes WHERE email_id = uuid_for_email($1) AND expiration > CURRENT_TIMESTAMP;', $email);
		$codes = [];
		while (!$rows->EOF()) {
			$code = new static();
			$code->email = $email;
			$code->emailId = $rows->Field('email_id');
			$code->codeHashed = $rows->Field('code_hash');
			$code->codeEncrypted = $rows->Field('code_encrypted');
			$code->verified = $rows->Field('verified');
			$codes[] = $code;
			$rows->MoveNext();
		}
		return $codes;
	}
	
	public static function Create(string $email, array $params = [], string $template = self::kTemplateNewAccount): ?EmailVerificationCode {
		$database = BeaconCommon::Database();
		$key = $params['key'] ?? null;
		if (is_null($key) === false) {
			$currentCodes = static::Search($email);
			foreach ($currentCodes as $currentCode) {
				if ($currentCode->verified === false && $currentCode->DecryptCode($key)) {
					return $currentCode;
				}
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
		
		$database->Query('DELETE FROM public.email_verification_codes WHERE expiration < CURRENT_TIMESTAMP;');
		$database->Query('INSERT INTO public.email_verification_codes (email_id, code_hash, code_encrypted) VALUES ($1, $2, $3);', $emailId, $codeHashed, $codeEncrypted);
		
		switch ($template) {
		case static::kTemplateNewAccount:
			$subject = 'Enter code ' . $code . ' in Beacon to verify your email address';
			$code_spaced = implode(' ', str_split($code));
			$relativeUrl = '/account/login?email=' . urlencode($email);
			if (count($params) > 0) {
				$relativeUrl .= '&' . http_build_query($params);	
			}
			$url = BeaconCommon::AbsoluteURL($relativeUrl);
			$plain = "You recently started the process of creating a new Beacon account or recovery of an existing Beacon account. In order to complete the process, please enter the code below.\n\n$code\n\nAlternatively, you may use the following link to continue the process automatically:\n\n$url\n\nIf you need help, reply to this email." . (empty(BeaconCommon::RemoteAddr() === false) ? ' This process was started from a device with an ip address similar to ' . BeaconCommon::RemoteAddr() : '');
			$html = '<center>You recently started the process of creating a new Beacon account or recovery of an existing Beacon account. In order to complete the process, please enter the code below.<br /><br /><span style="font-weight:bold;font-size: x-large">' . $code_spaced . '</span><br /><br />Alternatively, you may use the following link to continue the process automatically:<br /><br /><a href="' . $url . '">' . $url . '</a><br /><br />If you need help, reply to this email.' . (empty(BeaconCommon::RemoteAddr() === false) ? ' This process was started from a device with an ip address similar to <span style="font-weight:bold">' . htmlentities(BeaconCommon::RemoteAddr()) . '</span>' : '') . '</center>';
			break;
		case static::kTemplateConfirmChange:
			$params['email'] = $email;
			ksort($params);
			$params['hash'] = BeaconCommon::Base64UrlEncode(hash('sha3-256', http_build_query($params), true));
			$params['email'] = BeaconCommon::Base64UrlEncode($email);
			
			$subject = 'Please confirm your Beacon email address change';
			$relativeUrl = '/account/actions/email?' . http_build_query($params);
			$url = BeaconCommon::AbsoluteUrl($relativeUrl);
			$plain = "Please follow the link below to finish changing your Beacon account email address.\n\n$url" . (empty(BeaconCommon::RemoteAddr() === false) ? "\n\nThis process was started from a device with an ip address similar to " . BeaconCommon::RemoteAddr() : '');
			$html = '<center>Please follow the link below to finish changing your Beacon account email address.<br /><br /><a href="' . $url . '">' . $url . '</a>' . (empty(BeaconCommon::RemoteAddr() === false) ? '<br /><br />This process was started from a device with an ip address similar to <span style="font-weight:bold">' . htmlentities(BeaconCommon::RemoteAddr()) . '</span>' : '') . '</center>';
			break;
		default:
			$database->Rollback();
			return null;
		}
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
	
	public function IsVerified(): bool {
		return $this->verified;
	}
	
	public function Code(): ?string {
		return $this->code;
	}
	
	public function Email(): string {
		return $this->email;
	}
	
	public function EmailId(): string {
		return $this->emailId;
	}
	
	public function Verify(): void {
		if ($this->verified) {
			return;
		}
		
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('UPDATE public.email_verification_codes SET verified = TRUE WHERE code_hash = $1 AND verified = FALSE;', $this->codeHashed);
		$database->Commit();
		$this->verified = true;	
	}
	
	public function Matches(string $code): bool {
		$hashed = static::PrepareHash($this->emailId, $code);
		return $this->codeHashed = $hashed;
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
	
	public static function PrepareHash(string $emailId, string $code): string {
		$code = preg_replace('/[^0-9]/', '', $code);
		return base64_encode(hash('sha3-512', $emailId . $code, true));
	}
}

?>

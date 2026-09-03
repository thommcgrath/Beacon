<?php

abstract class BeaconEncryption {
	const SymmetricMagicByte = 0x8A;
	const SymmetricVersion = 2;

	public static function GenerateSalt(): string {
		return random_bytes(16);
	}

	public static function GenerateKey(int $bits = 256): string {
		return random_bytes($bits / 8);
	}

	public static function GeneratePasswordHash(string $password): string {
		$algo = BeaconCommon::GetGlobal('Password Hash Algorithm');
		$options = BeaconCommon::GetGlobal('Password Hash Options');
		$pepper = BeaconCommon::GetGlobal('Password Hash Pepper');

		$peppered = hash_hmac('sha256', $password, $pepper);
		return password_hash($peppered, $algo, $options);
	}

	public static function VerifyPasswordHash(string $password, string $hash): bool {
		$pepper = BeaconCommon::GetGlobal('Password Hash Pepper');

		$peppered = hash_hmac('sha256', $password, $pepper);
		return password_verify($peppered, $hash);
	}

	public static function HashFromPassword(string $password, string $salt, int $iterations): string {
		// This is ok for the key size to be greater than necessary. AES-256 maxes out at a 256 bit / 32 byte key.
		// Any length greater will simply be truncated. So use the 56 byte key size for the legacy blowfish
		// encryption and it'll be fine. AES will chop it down later anyway.
		return hash_pbkdf2('sha512', $password, $salt, $iterations, 56, true);
	}

	public static function RSAEncrypt(string $publicKey, string $data, bool $useOAEPPadding = true): string {
		$flags = ($useOAEPPadding ? OPENSSL_PKCS1_OAEP_PADDING : OPENSSL_PKCS1_PADDING);
		if (@openssl_public_encrypt($data, $result, $publicKey, $flags)) {
			return $result;
		} else {
			throw new Exception('Unable to encrypt: ' . openssl_error_string());
		}
	}

	public static function RSADecrypt(string $privateKey, string $data, bool $useOAEPPadding = true): string {
		$flags = ($useOAEPPadding ? OPENSSL_PKCS1_OAEP_PADDING : OPENSSL_PKCS1_PADDING);
		if (@openssl_private_decrypt($data, $result, $privateKey, $flags)) {
			return $result;
		} else {
			throw new Exception('Unable to decrypt: ' . openssl_error_string());
		}
	}

	public static function RSASign(string $privateKey, string $data): string {
		$signature = null;
		if (@openssl_sign($data, $signature, $privateKey, OPENSSL_ALGO_SHA1)) {
			return $signature;
		} else {
			throw new Exception('Unable to create signature: ' . openssl_error_string());
		}
	}

	public static function RSAVerify(string $publicKey, string $data, string $signature): bool {
		$status = @openssl_verify($data, $signature, $publicKey, OPENSSL_ALGO_SHA1);
		if ($status == -1) {
			throw new Exception('Unable to verify signature');
		}
		return $status == 1;
	}

	// Encrypts using a symmetric key intermediate
	public static function RSAEncryptLargeMessage(string $publicKey, string $data, bool $raw = false): string|array {
		$key = static::GenerateKey(256);
		$dataEncrypted = static::SymmetricEncrypt($key, $data, false);
		$keyEncrypted = static::RSAEncrypt($publicKey, $key, true);
		$dict = [
			'version' => 1,
			'key' => base64_encode($keyEncrypted),
			'message' => base64_encode($dataEncrypted)
		];
		if ($raw) {
			return $dict;
		} else {
			return json_encode($dict);
		}
	}

	public static function RSADecryptLargeMessage(string $privateKey, string|array $dict): string {
		if (is_string($dict)) {
			$dict = json_decode($dict, true);
		}

		$version = $dict['version'];
		if ($version != 1) {
			throw new Exception('Incompatible message version');
		}

		$keyEncrypted = base64_decode($dict['key']);
		$dataEncrypted = base64_decode($dict['message']);

		$key = static::RSADecrypt($privateKey, $keyEncrypted);
		$data = static::SymmetricDecrypt($key, $dataEncrypted);

		return $data;
	}

	public static function SymmetricEncrypt(string $key, string $data, bool $legacy = true): string {
		$cipher = $legacy ? 'bf-cbc' : 'aes-256-cbc';
		$version = $legacy ? 1 : 2;
		$ivSize = openssl_cipher_iv_length($cipher);
		$iv = random_bytes($ivSize);
		$encrypted = openssl_encrypt($data, $cipher, $key, OPENSSL_RAW_DATA, $iv);
		if ($encrypted === false) {
			throw new Exception('Unable to encrypt: ' . openssl_error_string());
		}
		return pack('C', self::SymmetricMagicByte) . pack('C', $version) . $iv . pack('N', strlen($data)) . pack('N', crc32($data)) . $encrypted;
	}

	public static function SymmetricDecrypt(string $key, string $data): string {
		$magicByte = unpack('C', $data[0])[1];
		$version = unpack('C', $data[1])[1];
		$ivSize = ($version == 2) ? 16 : 8;
		$iv = substr($data, 2, $ivSize);
		$len = self::UnpackUInt32(substr($data, 2 + $ivSize, 4));
		$expectedChecksum = self::UnpackUInt32(substr($data, 6 + $ivSize, 4));
		$data = substr($data, 10 + $ivSize);

		if ($magicByte != self::SymmetricMagicByte) {
			throw new Exception('Data not encrypted properly: ' . bin2hex($magicByte) . '(' . strlen($magicByte) . ')');
		}
		if ($version > self::SymmetricVersion) {
			throw new Exception('Encryption is too new');
		}

		$decrypted = openssl_decrypt($data, ($version == 2) ? 'aes-256-cbc' : 'bf-cbc', $key, OPENSSL_RAW_DATA, $iv);
		if ($decrypted === false) {
			throw new Exception('Unable to decrypt: ' . openssl_error_string());
		}
		$decrypted = substr($decrypted, 0, $len);
		if (PHP_INT_SIZE <= 4) {
			$computedChecksum = sprintf('%u', crc32($decrypted));
		} else {
			$computedChecksum = crc32($decrypted);
		}
		if ($computedChecksum != $expectedChecksum) {
			throw new Exception('CRC32 checksum failed on decrypted data: ' . $expectedChecksum . ' expected, ' . $computedChecksum . ' computed');
		}
		return $decrypted;
	}

	public static function BlowfishDecrypt(string $key, string $data): string {
		return static::SymmetricDecrypt($key, $data, true);
	}

	public static function BlowfishEncrypt(string $key, string $data): string {
		return static::SymmetricEncrypt($key, $data);
	}

	public static function PublicKeyToPEM(string $publicKey): string {
		if (str_starts_with($publicKey, '-----BEGIN PUBLIC KEY-----') === false) {
			$publicKey = @hex2bin($publicKey);
			if ($publicKey === false) {
				throw new Exception('Invalid hex input for public key');
			}
			$publicKey = trim(chunk_split(base64_encode($publicKey), 64, "\n"));
			$publicKey = "-----BEGIN PUBLIC KEY-----\n$publicKey\n-----END PUBLIC KEY-----";
		}
		return $publicKey;
	}

	public static function PrivateKeyToPEM(string $privateKey): string {
		if (str_starts_with($privateKey, '-----BEGIN RSA PRIVATE KEY-----') === false) {
			$privateKey = @hex2bin($privateKey);
			if ($privateKey === false) {
				throw new Exception('Invalid hex input for private key');
			}
			$privateKey = trim(chunk_split(base64_encode($privateKey), 64, "\n"));
			$privateKey = "-----BEGIN RSA PRIVATE KEY-----\n$privateKey\n-----END RSA PRIVATE KEY-----";
		}
		return $privateKey;
	}

	private static function UnpackUInt32(string $bin): int {
		if (PHP_INT_SIZE <= 4) {
			$a = unpack('n*', $bin);
			return ($a[2] + ($a[1] * 0x010000));
		} else {
			return unpack('N', $bin)[1];
		}
	}

	public static function GenerateKeyPair(&$publicKey, &$privateKey, int $keySize = 4096): void {
		$handle = openssl_pkey_new([
			'digest_alg' => 'sha512',
			'private_key_bits' => $keySize,
			'private_key_type' => OPENSSL_KEYTYPE_RSA
		]);
		openssl_pkey_export($handle, $privateKey);
		$publicKey = openssl_pkey_get_details($handle);
		$publicKey = $publicKey['key'];
	}

	public static function ExtractPublicKey(string $privateKey): ?string {
		$handle = @openssl_pkey_get_private($privateKey);
		$details = @openssl_pkey_get_details($handle);
		if (is_array($details) && array_key_exists('key', $details)) {
			return $details['key'];
		} else {
			return null;
		}
	}

	public static function IsEncrypted(string $data): bool {
		if (empty($data)) {
			return false;
		}
		if (BeaconCommon::IsHex($data)) {
			$data = hex2bin($data);
		}
		return (unpack('C', $data[0])[1] === self::SymmetricMagicByte);
	}

	public static function HeaderBytes(string $data, bool $pathMode = false): ?string {
		if ($pathMode) {
			$path = $data;
			$handle = fopen($path, 'rb');
			$data = fread($handle, 32);
			fclose($handle);
		}

		$magicByte = unpack('C', $data[0])[1];
		if ($magicByte !== self::SymmetricMagicByte) {
			return null;
		}
		$version = unpack('C', $data[1])[1];
		$ivSize = ($version == 2) ? 16 : 8;
		return substr($data, 0, 10 + $ivSize);
	}

	public static function GeneratePKCE(int $length = 128): string {
		$bytes = str_split(random_bytes(128));
		for ($idx = 0; $idx < count($bytes); $idx++) {
			$byte = ord($bytes[$idx]) % 66;
			if ($byte === 0) {
				$byte = 45; // -
			} elseif ($byte === 1) {
				$byte = 46; // .
			} elseif ($byte === 2) {
				$byte = 95; // _
			} elseif ($byte === 3) {
				$byte = 126; // ~
			} elseif ($byte < 14) {
				$byte = ($byte - 4) + 48; // Digits
			} elseif ($byte < 40) {
				$byte = ($byte - 14) + 65; // Uppercase characters
			} else {
				$byte = ($byte - 40) + 97; // Lowercase characters
			}
			$bytes[$idx] = chr($byte);
		}
		return implode('', $bytes);
	}

	public static function GenerateTOTP(string $secret, bool $rawSecret, int|null $timestamp = null): string {
		if (is_null($timestamp)) {
			$timestamp = time();
		}

		if ($rawSecret === false) {
			$secret = BeaconCommon::Base32Decode($secret);
		}

		$timestamp = floor($timestamp / 30);
		$binary = pack('N*', 0) . pack('N*', $timestamp);
		$hash = hash_hmac('sha1', $binary, $secret, true);
		$offset = ord($hash[19]) & 0xf;
		$code = (((ord($hash[$offset]) & 0x7f) << 24) | ((ord($hash[$offset + 1]) & 0xff) << 16) | ((ord($hash[$offset + 2]) & 0xff) << 8) | (ord($hash[$offset + 3]) & 0xff)) % pow(10, 6);
		return str_pad($code, 6, '0', STR_PAD_LEFT);
	}

	public static function TestTOTP(string $secret, bool $rawSecret, string $code): bool {
		if (strlen($code) !== 6) {
			return false;
		}

		if ($rawSecret === false) {
			$secret = BeaconCommon::Base32Decode($secret);
		}

		$now = time();
		$future = $now + 30;
		$past = $now - 30;
		return ($code === static::GenerateTOTP($secret, true, $now) || $code === static::GenerateTOTP($secret, true, $past) || $code === static::GenerateTOTP($secret, true, $future));
	}
}

?>

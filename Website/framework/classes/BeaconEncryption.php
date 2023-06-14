<?php

abstract class BeaconEncryption {
	const SymmetricMagicByte = 0x8A;
	const SymmetricVersion = 2;
	
	public static function GenerateSalt(): string {
		return random_bytes(128);
	}
	
	public static function GenerateKey(int $bits = 256): string {
		return random_bytes($bits / 8);
	}
	
	public static function HashFromPassword(string $password, string $salt, int $iterations): string {
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
				throw new Exception('Invalid hex input');
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
				throw new Exception('Invalid hex input');
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
}

?>
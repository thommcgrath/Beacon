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
	
	public static function RSAEncrypt(string $public_key, string $data, bool $oaep_padding = true): string {
		$flags = ($oaep_padding ? OPENSSL_PKCS1_OAEP_PADDING : OPENSSL_PKCS1_PADDING);
		if (@openssl_public_encrypt($data, $result, $public_key, $flags)) {
			return $result;
		} else {
			throw new Exception('Unable to encrypt: ' . openssl_error_string());
		}
	}
	
	public static function RSADecrypt(string $private_key, string $data, bool $oaep_padding = true): string {
		$flags = ($oaep_padding ? OPENSSL_PKCS1_OAEP_PADDING : OPENSSL_PKCS1_PADDING);
		if (@openssl_private_decrypt($data, $result, $private_key, $flags)) {
			return $result;
		} else {
			throw new Exception('Unable to decrypt: ' . openssl_error_string());
		}
	}
	
	public static function RSASign(string $private_key, string $data): string {
		$signature = null;
		if (@openssl_sign($data, $signature, $private_key, OPENSSL_ALGO_SHA1)) {
			return $signature;
		} else {
			throw new Exception('Unable to create signature: ' . openssl_error_string());
		}
	}
	
	public static function RSAVerify(string $public_key, string $data, string $signature): bool {
		$status = @openssl_verify($data, $signature, $public_key, OPENSSL_ALGO_SHA1);
		if ($status == -1) {
			throw new Exception('Unable to verify signature');
		}
		return $status == 1;
	}
	
	public static function SymmetricEncrypt(string $key, string $data, bool $legacy = true): string {
		$cipher = $legacy ? 'bf-cbc' : 'aes-256-cbc';
		$version = $legacy ? 1 : 2;
		$iv_size = openssl_cipher_iv_length($cipher);
		$iv = random_bytes($iv_size);
		$encrypted = openssl_encrypt($data, $cipher, $key, OPENSSL_RAW_DATA, $iv);
		if ($encrypted === false) {
			throw new Exception('Unable to encrypt: ' . openssl_error_string());
		}
		return pack('C', self::SymmetricMagicByte) . pack('C', $version) . $iv . pack('N', strlen($data)) . pack('N', crc32($data)) . $encrypted;
	}
	
	public static function SymmetricDecrypt(string $key, string $data): string {
		$magic_byte = unpack('C', $data[0])[1];
		$version = unpack('C', $data[1])[1];
		$iv_size = ($version == 2) ? 16 : 8;
		$iv = substr($data, 2, $iv_size);
		$len = self::UnpackUInt32(substr($data, 2 + $iv_size, 4));
		$expected_checksum = self::UnpackUInt32(substr($data, 6 + $iv_size, 4));
		$data = substr($data, 10 + $iv_size);
		
		if ($magic_byte != self::SymmetricMagicByte) {
			throw new Exception('Data not encrypted properly: ' . bin2hex($magic_byte) . '(' . strlen($magic_byte) . ')');
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
			$computed_checksum = sprintf('%u', crc32($decrypted));
		} else {
			$computed_checksum = crc32($decrypted);
		}
		if ($computed_checksum != $expected_checksum) {
			throw new Exception('CRC32 checksum failed on decrypted data: ' . $expected_checksum . ' expected, ' . $computed_checksum . ' computed');
		}
		return $decrypted;
	}
	
	public static function BlowfishDecrypt(string $key, string $data): string {
		return static::SymmetricDecrypt($key, $data, true);
	}
	
	public static function BlowfishEncrypt(string $key, string $data): string {
		return static::SymmetricEncrypt($key, $data);
	}
	
	public static function PublicKeyToPEM(string $public_key): string {
		if (str_starts_with($public_key, '-----BEGIN PUBLIC KEY-----') === false) {
			$public_key = @hex2bin($public_key);
			if ($public_key === false) {
				throw new Exception('Invalid hex input');
			}
			$public_key = trim(chunk_split(base64_encode($public_key), 64, "\n"));
			$public_key = "-----BEGIN PUBLIC KEY-----\n$public_key\n-----END PUBLIC KEY-----";
		}
		return $public_key;
	}
	
	public static function PrivateKeyToPEM(string $private_key): string {
		if (str_starts_with($private_key, '-----BEGIN RSA PRIVATE KEY-----') === false) {
			$private_key = @hex2bin($private_key);
			if ($private_key === false) {
				throw new Exception('Invalid hex input');
			}
			$private_key = trim(chunk_split(base64_encode($private_key), 64, "\n"));
			$private_key = "-----BEGIN RSA PRIVATE KEY-----\n$private_key\n-----END RSA PRIVATE KEY-----";
		}
		return $private_key;
	}
	
	private static function UnpackUInt32(string $bin): int {
		if (PHP_INT_SIZE <= 4) {
			$a = unpack('n*', $bin);
			return ($a[2] + ($a[1] * 0x010000));
		} else {
			return unpack('N', $bin)[1];
		}
	}
	
	public static function GenerateKeyPair(&$public_key, &$private_key): void {
		$handle = openssl_pkey_new([
			'digest_alg' => 'sha512',
			'private_key_bits' => 4096,
			'private_key_type' => OPENSSL_KEYTYPE_RSA
		]);
		openssl_pkey_export($handle, $private_key);
		$public_key = openssl_pkey_get_details($handle);
		$public_key = $public_key['key'];
	}
	
	public static function ExtractPublicKey(string $private_key): ?string {
		$handle = @openssl_pkey_get_private($private_key);
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
	
	public static function HeaderBytes(string $data, bool $path_mode = false): ?string {
		if ($path_mode) {
			$path = $data;
			$handle = fopen($path, 'rb');
			$data = fread($handle, 32);
			fclose($handle);
		}
		
		$magic_byte = unpack('C', $data[0])[1];
		if ($magic_byte !== self::SymmetricMagicByte) {
			return null;
		}
		$version = unpack('C', $data[1])[1];
		$iv_size = ($version == 2) ? 16 : 8;
		return substr($data, 0, 10 + $iv_size);
	}
}

?>
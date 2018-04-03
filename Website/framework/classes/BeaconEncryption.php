<?php

abstract class BeaconEncryption {
	const BlowfishMagicByte = 0x8A;
	const BlowfishVersion = 1;
	
	public static function GenerateSalt() {
		return random_bytes(128);
	}
	
	public static function HashFromPassword(string $password, string $salt, int $iterations) {
		return hash_pbkdf2('sha512', $password, $salt, $iterations, 56, true);
	}
	
	public static function RSAEncrypt(string $public_key, string $data) {
		if (@openssl_public_encrypt($data, $result, $public_key, OPENSSL_PKCS1_OAEP_PADDING)) {
			return $result;
		} else {
			throw new \Exception('Unable to encrypt');
		}
	}
	
	public static function RSADecrypt(string $private_key, string $data) {
		if (@openssl_private_decrypt($data, $result, $private_key, OPENSSL_PKCS1_OAEP_PADDING)) {
			return $result;
		} else {
			throw new \Exception('Unable to decrypt');
		}
	}
	
	public static function RSAVerify(string $public_key, string $data, string $signature) {
		$status = @openssl_verify($data, $signature, $public_key, OPENSSL_ALGO_SHA1);
		if ($status == -1) {
			throw new \Exception('Unable to verify signature');
		}
		return $status == 1;
	}
	
	public static function BlowfishEncrypt(string $key, string $data) {
		$iv_size = openssl_cipher_iv_length('bf-cbc');
		$iv = random_bytes($iv_size);
		$encrypted = openssl_encrypt(str_pad($data, ceil(strlen($data) / 8) * 8, chr(0)), 'bf-cbc', $key, OPENSSL_RAW_DATA | OPENSSL_ZERO_PADDING, $iv);
		if ($encrypted === false) {
			throw new Exception('Unable to encrypt: ' . openssl_error_string());
		}
		return pack('C', self::BlowfishMagicByte) . pack('C', self::BlowfishVersion) . $iv . pack('N', strlen($data)) . pack('N', crc32($data)) . $encrypted;
	}
	
	public static function BlowfishDecrypt(string $key, string $data) {
		$magic_byte = unpack('C', $data[0])[1];
		$version = unpack('C', $data[1])[1];
		$iv = substr($data, 2, 8);
		$len = unpack('N', substr($data, 10, 4))[1];
		$expected_checksum = unpack('N', substr($data, 14, 4))[1];
		$data = substr($data, 18);
		
		if ($magic_byte != self::BlowfishMagicByte) {
			throw new Exception('Data not encrypted properly: ' . bin2hex($magic_byte) . '(' . strlen($magic_byte) . ')');
		}
		if ($version > self::BlowfishVersion) {
			throw new Exception('Encryption is too new');
		}
		
		$decrypted = openssl_decrypt($data, 'bf-cbc', $key, OPENSSL_RAW_DATA | OPENSSL_ZERO_PADDING, $iv);
		if ($decrypted === false) {
			throw new Exception('Unable to decrypt: ' . openssl_error_string());
		}
		$decrypted = substr($decrypted, 0, $len);
		$computed_checksum = crc32($decrypted);
		if ($computed_checksum !== $expected_checksum) {
			throw new Exception('CRC32 checksum failed on decrypted data: ' . $expected_checksum . ' expected, ' . $computed_checksum . ' computed');
		}
		return $decrypted;
	}
}

?>
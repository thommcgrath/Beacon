<?php

class BeaconFTPSSLConnection extends BeaconFTPConnection {
	public function Connect(string $host, int $port, string $user, string $pass) {
		$connection = @ftp_ssl_connect($host, $port);
		if (!@ftp_login($connection, $user, $pass)) {
			return false;
		}
		$this->connection = $connection;
		ftp_pasv($connection, true);
		return true;
	}
}

?>
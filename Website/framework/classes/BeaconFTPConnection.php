<?php

class BeaconFTPConnection implements BeaconFTPProvider {
	protected $connection;
	
	public function ConnectionType() {
		return 'ftp';
	}
	
	public function Connect(string $host, int $port, string $user, string $pass) {
		$connection = @ftp_connect($host, $port);
		if (!@ftp_login($connection, $user, $pass)) {
			return false;
		}
		$this->connection = $connection;
		ftp_pasv($connection, true);
		return true;
	}
	
	public function Close() {
		ftp_close($this->connection);
		$this->connection = null;
	}
	
	public function ListFiles(string $remote_directory_path) {
		$results = array();
		$files = ftp_mlsd($this->connection, $remote_directory_path);
		if (is_array($files)) {
			foreach ($files as $file) {
				if ($file['name'] == '.' || $file['name'] == '..') {
					continue;
				}
				
				$dir = strtolower(substr($file['type'], -3)) == 'dir';
				$results[] = $file['name'] . ($dir ? '/' : '');
			}
		}
		return $results;
	}
	
	public function Download(string $remote_file_path) {
		ob_start();
		$result = @ftp_get($this->connection, "php://output", $remote_file_path, FTP_ASCII);
		$data = ob_get_contents();
		ob_end_clean();
		return $result ? $data : false;
	}
	
	public function Upload(string $remote_file_path, string $local_file_path) {
		return @ftp_put($this->connection, $remote_file_path, $local_file_path, FTP_ASCII);
	}
}

?>
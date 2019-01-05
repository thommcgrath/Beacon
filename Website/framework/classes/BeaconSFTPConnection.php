<?php
	
include('Net/SFTP.php');

class BeaconSFTPConnection implements BeaconFTPProvider {
	protected $connection;
	
	public function Connect(string $host, int $port, string $user, string $pass) {
		$sftp = new Net_SFTP($host, $port);
		if (!$sftp->login($user, $pass)) {
			return false;
		}
		
		$this->connection = $sftp;
		return true;
	}
	
	public function Close() {
		if (is_null($this->connection)) {
			return;
		}
		
		$this->connection->disconnect();
		$this->connection = null;
	}
	
	public function ListFiles(string $remote_directory_path) {
		$results = array();
		if (is_null($this->connection)) {
			return $results;
		}
		
		$files = $this->connection->rawlist($remote_directory_path);
		if (!is_array($files)) {
			return $results;
		}
		
		foreach ($files as $file) {
			$filename = $file['filename'];
			
			if ($filename == '.' || $filename == '..') {
				continue;
			}
			
			if ($file['type'] == 2) {
				$filename .= '/';
			}
			
			$results[] = $filename;
		}
		
		return $results;
	}
	
	public function Download(string $remote_file_path) {
		if (is_null($this->connection)) {
			return false;
		}
		
		return $this->connection->get($remote_file_path);
	}
	
	public function Upload(string $remote_file_path, string $local_file_path) {
		if (is_null($this->connection)) {
			return false;
		}
		
		return $this->connection->put($remote_file_path, file_get_contents($local_file_path), Net_SFTP::SOURCE_STRING);
	}
}

?>
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
		} elseif ($files === false) {
			if (substr($remote_directory_path, -1, 1) == '/') {
				$remote_directory_path = substr($remote_directory_path, 0, -1);
			}
			$files = ftp_rawlist($this->connection, $remote_directory_path);
			if (is_array($files)) {
				$systype = ftp_systype($this->connection);
				$files = $this->ParseRawList($systype, $files);
				if (!is_null($files)) {
					$results = $files;
				}
			}
		}
		return $results;
	}
	
	protected function ParseRawList(string $systype, array $lines) {
		$files = array();
		switch ($systype) {
		case 'Windows_NT':
			foreach ($lines as $line) {
				$datetime = substr($line, 0, 17);
				$type = trim(substr($line, 24, 15));
				$filename = substr($line, 39);
				$dir = ($type == '<DIR>');
				
				$files[] = $filename . ($dir ? '/' : '');
			}
			break;
		case 'UNIX':
			foreach ($lines as $line) {
				if (preg_match('/^(?<dir>[\-ld])(?<permission>([\-r][\-w][\-xs]){3})\s+(?<filecode>\d+)\s+(?<owner>\w+)\s+(?<group>\w+)\s+(?<size>\d+)\s+(?<timestamp>((?<month>\w{3})\s+(?<day>\d{1,2})\s+(?<hour>\d{1,2}):(?<minute>\d{2}))|((?<monthb>\w{3})\s+(?<dayb>\d{1,2})\s+(?<year>\d{4})))\s+(?<name>.+)$/', $line, $matches) == 0) {
					continue;
				}
				
				$filename = $matches['name'];
				$dir = $matches['dir'] == 'd';
				
				$files[] = $filename . ($dir ? '/' : '');
			}
			break;
		default:
			$message = array(
				'text' => 'A user has found an unsupported FTP server: ' . $systype,
				'attachments' => array(
					array(
						'title' => 'ftp_rawlist',
						'text' => implode("\n", $lines)
					)
				)
			);
			BeaconCommon::PostSlackRaw(json_encode($message));
			return null;
		}
		return $files;
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
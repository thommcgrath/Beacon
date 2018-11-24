<?php

interface FTPProvider {
	public function Connect(string $host, int $port, string $user, string $pass);
	public function Close();
	
	public function ListFiles(string $remote_directory_path);
	public function Download(string $remote_file_path);
	public function Upload(string $remote_file_path, string $local_file_path);
}

class FTPConnection implements FTPProvider {
	protected $connection;
	
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
		$filenames = array();
		if (function_exists('ftp_mlsd')) {
			$files = ftp_mlsd($this->connection, $remote_directory_path);
			if (is_array($files)) {
				foreach ($files as $file) {
					$filenames[] = $file['name'];
				}
			}
		} else {
			// chrdir first, because nlist returns incorrect results if you ask for the directory directly
			ftp_chdir($this->connection, $remote_directory_path);
			$files = ftp_nlist($this->connection, '');
			if (is_array($files)) {
				foreach ($files as $file) {
					$filenames[] = basename($file);
				}
			}
		}
		return $filenames;
	}
	
	public function Download(string $remote_file_path) {
		ob_start();
		$result = @ftp_get($this->connection, "php://output", $remote_file_path, FTP_ASCII);
		$data = ob_get_contents();
		ob_end_clean();
		return $result ? $data : false;
	}
	
	public function Upload(string $remote_file_path, string $content) {
		return @ftp_put($this->connection, $ftp_path, $temp_path, FTP_ASCII);
	}
}

class FTPSSLConnection extends FTPConnection {
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

class SFTPConnection implements FTPProvider {
	protected $ssh_connection;
	protected $ftp_connection;
	
	public function Connect(string $host, int $port, string $user, string $pass) {
		$ssh_connection = @ssh2_connect($host, $port);
		if ($ssh_connection === false) {
			return false;
		}
		
		$authenticated = @ssh2_auth_password($ssh_connection, $user, $pass);
		if ($authenticated === false) {
			return false;
		}
		
		$this->ftp_connection = ssh2_sftp($ssh_connection);
		$this->ssh_connection = $ssh_connection;
		return true;
	}
	
	public function Close() {
		ssh2_disconnect($this->ssh_connection);
		$this->connection = null;
	}
	
	public function ListFiles(string $remote_directory_path) {
		$fd = intval($this->ftp_connection);
		$handle = @opendir("ssh2.sftp://$fd/$remote_directory_path");
		$files = array();
		if (!$handle) {
			return $files;
		}
		while (false != ($entry = readdir($handle))){
			$files[] = $entry;
		}
		closedir($handle);
		return $files;
	}
	
	public function Download(string $remote_file_path) {
		return @file_get_contents('ssh2.sftp://' . intval($this->ftp_connection) . '/' . $remote_file_path);
	}
	
	public function Upload(string $remote_file_path, string $local_file_path) {
		return @file_put_contents('ssh2.sftp://' . intval($this->ftp_connection) . '/' . $remote_file_path, file_get_contents($local_file_path));
	}
}

function sftp_debug_callback($message, $language, $always_display) {
	printf("Debug: %s\n", $message);
}

require(dirname(__FILE__) . '/loader.php');

$method = BeaconAPI::Method();
//BeaconAPI::Authorize();

$ftp_user = isset($_REQUEST['user']) ? $_REQUEST['user'] : BeaconAPI::ReplyError('Missing user variable.', null, 400);
$ftp_pass = isset($_REQUEST['pass']) ? $_REQUEST['pass'] : BeaconAPI::ReplyError('Missing pass variable.', null, 400);
$ftp_host = isset($_REQUEST['host']) ? $_REQUEST['host'] : BeaconAPI::ReplyError('Missing host variable.', null, 400);
$ftp_port = isset($_REQUEST['port']) ? intval($_REQUEST['port']) : 0;
$ftp_mode = isset($_REQUEST['mode']) ? strtolower($_REQUEST['mode']) : 'ftp';
if ($ftp_port == 0) {
	$ftp_port = 21;
}
$ref = isset($_REQUEST['ref']) ? $_REQUEST['ref'] : BeaconCommon::GenerateUUID();

if ($ftp_port == 22 || $ftp_mode == 'sftp') {
	$class_names = array('SFTPConnection');
} elseif ($ftp_port == 21 || $ftp_mode == 'ftp') {
	$class_names = array('FTPSSLConnection', 'FTPConnection');
} else {
	$class_names = array('FTPSSLConnection', 'FTPConnection', 'SFTPConnection');
}
$ftp_provider = null;
foreach ($class_names as $class_name) {
	$instance = new $class_name();
	if ($instance->Connect($ftp_host, $ftp_port, $ftp_user, $ftp_pass)) {
		$ftp_provider = $instance;
		break;
	}
}
if (is_null($ftp_provider)) {
	BeaconAPI::ReplyError('Unable to connect to host.', array('ref' => $ref, 'host' => $ftp_host . ':' . $ftp_port), 500);
}

switch ($method) {
case 'GET':
	$object = BeaconAPI::ObjectID();
	if ($object == 'discover') {
		if (isset($_REQUEST['path'])) {
			$ftp_path = $_REQUEST['path'];
		} else {
			$hier = array(
				array('arkse','arkserver'),
				array('ShooterGame'),
				array('Saved')
			);
			$ftp_path = Discover($ftp_provider, '', $hier);
			if ($ftp_path === false) {
				BeaconAPI::ReplyError('Unable to determine path to ShooterGame/Saved folder.', array('ref' => $ref), 404);
			}
		}
		$config_path = Discover($ftp_provider, $ftp_path . '/Config', array(array('WindowsServer', 'LinuxServer', 'WindowsNoEditor')));
		if ($config_path === false) {
			BeaconAPI::ReplyError('Unable to find Config folder in "' . $ftp_path . '"', array('ref' => $ref), 404);
		}
		$game_ini_path = $config_path . '/Game.ini';
		$settings_ini_path = $config_path . '/GameUserSettings.ini';

		$results = array(
			'Game.ini' => $game_ini_path,
			'GameUserSettings.ini' => $settings_ini_path,
			'ref' => $ref
		);

		$log_found = false;
		$logs_path = $ftp_path . '/Logs';
		$logs_list = $ftp_provider->ListFiles($logs_path);
		rsort($logs_list);
		foreach ($logs_list as $log_file) {
			$filename = basename($log_file);
			if (substr($filename, 0, 11) != 'ShooterGame') {
				continue;
			}
			
			$data = $ftp_provider->Download($log_file);
			if ($data === false) {
				continue;
			}

			$log_found = true;
			foreach (preg_split("/((\r?\n)|(\r\n?))/", $data) as $line) {
				$pos = stripos($line, 'CommandLine: "');
				if ($pos === false) {
					continue;
				}
				$pos += 14;
				$end = strpos($line, '"', $pos);
				$length = $end - $pos;
				$content = substr($line, $pos, $length);

				$params = explode('?', $content);

				$map = array_shift($params);;
				$listen = array_shift($params);;

				$results['Maps'] = array($map);
				$arguments = array();
				foreach ($params as $param) {
					list($key, $value) = explode('=', $param, 2);
					$arguments[$key] = $value;
				}
				$results['Options'] = $arguments;
			}

			break;
		}

		if (!$log_found) {
			// That's unfortunate. Let's try something else.
			$folders = $ftp_provider->ListFiles($ftp_path);
			$possibles = array();
			foreach ($folders as $folder_path) {
				$foldername = basename($folder_path);
				if ((substr($foldername, -9) == 'SavedArks') || (substr($foldername, -14) == 'SavedArksLocal')) {
					$possibles[] = $foldername;
				}
			}

			$maps = array();
			foreach ($possibles as $possible) {
				$files = $ftp_provider->ListFiles($ftp_path . '/' . $possible);
				foreach ($files as $file_path) {
					$filename = basename($file_path);
					if (substr($filename, -4) == '.ark') {
						$map = substr($filename, 0, -4);
						if (!in_array($map, $maps)) {
							$maps[] = $map;
						}
					}
				}
			}
			$results['Maps'] = $maps;
		}

		BeaconAPI::ReplySuccess($results);
	} else {
		$ftp_path = isset($_REQUEST['path']) ? $_REQUEST['path'] : BeaconAPI::ReplyError('Missing path variable.', null, 400);

		if (strtolower(substr($ftp_path, -4)) != '.ini') {
			BeaconAPI::ReplyError('Requested file does not appear to be an ini file.', array('ref' => $ref, 'path' => $ftp_path), 500);
		}
		
		$content = $ftp_provider->Download($ftp_path);
		if ($content === false) {
			BeaconAPI::ReplyError('Unable to download file.', array('ref' => $ref, 'path' => $ftp_path), 500);
		}

		header('Content-Type: text/plain');
		BeaconAPI::ReplySuccess(array('ref' => $ref, 'content' => $content));
		break;
	}
case 'POST':
	if (BeaconAPI::ContentType() !== 'text/plain') {
		BeaconAPI::ReplyError('Send plain text data.', array('ref' => $ref), 400);
	}

	$ftp_path = isset($_REQUEST['path']) ? $_REQUEST['path'] : BeaconAPI::ReplyError('Missing path variable.', null, 400);

	$temp_path = sys_get_temp_dir() . '/' . BeaconCommon::GenerateUUID();
	file_put_contents($temp_path, BeaconAPI::Body());

	$success = $ftp_provider->Upload($ftp_path, $temp_path);
	if (file_exists($temp_path)) {
		unlink($temp_path);
	}

	if ($success) {
		BeaconAPI::ReplySuccess(array('ref' => $ref));
	} else {
		BeaconAPI::ReplyError('Unable to upload file.', array('ref' => $ref, 'path' => $ftp_path), 500);
	}

	break;
default:
	BeaconAPI::ReplyError('Method not allowed.', array('ref' => $ref), 405);
	break;
}

function Discover(FTPProvider $connection, string $starting_path, array $hierarchy) {
	$path = $starting_path;
	foreach ($hierarchy as $possibles) {
		$discovered_path = SearchDirectory($connection, $path, $possibles);
		if ($discovered_path != '') {
			$path = $discovered_path;
		} else {
			return false;
		}
	}
	return $path;
}

function SearchDirectory(FTPProvider $connection, string $starting_path, array $possibles) {
	if ($starting_path == '') {
		foreach ($possibles as $possible) {
			$files = $connection->ListFiles('/' . $possible);
			if (count($files) > 0) {
				return '/' . $possible;
			}
		}
	} else {
		$files = $connection->ListFiles($starting_path);
		foreach ($files as $file) {
			if (in_array($file, $possibles)) {
				return $starting_path . '/' . $file;
			}
		}
	}
}

?>

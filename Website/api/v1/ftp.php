<?php

require(dirname(__FILE__) . '/loader.php');

$method = BeaconAPI::Method();
BeaconAPI::Authorize();

$ftp_user = isset($_REQUEST['user']) ? $_REQUEST['user'] : BeaconAPI::ReplyError('Missing user variable.', null, 400);
$ftp_pass = isset($_REQUEST['pass']) ? $_REQUEST['pass'] : BeaconAPI::ReplyError('Missing pass variable.', null, 400);
$ftp_host = isset($_REQUEST['host']) ? $_REQUEST['host'] : BeaconAPI::ReplyError('Missing host variable.', null, 400);
$ftp_port = isset($_REQUEST['port']) ? intval($_REQUEST['port']) : 0;
$ftp_mode = isset($_REQUEST['mode']) ? strtolower($_REQUEST['mode']) : 'auto';
if ($ftp_port == 0) {
	$ftp_port = 21;
}
$ref = isset($_REQUEST['ref']) ? $_REQUEST['ref'] : BeaconCommon::GenerateUUID();

switch ($ftp_mode) {
case 'ftp':
	$class_names = array('BeaconFTPConnection');
	break;
case 'ftp+tls':
	$class_names = array('BeaconFTPSSLConnection');
	break;
case 'sftp':
	$class_names = array('BeaconSFTPConnection');
	break;
default:
	switch ($ftp_port) {
	case 21:
		$class_names = array('BeaconFTPSSLConnection', 'BeaconFTPConnection');
		break;
	case 22:
		$class_names = array('BeaconSFTPConnection');
		break;
	default:
		$class_names = array('BeaconFTPSSLConnection', 'BeaconFTPConnection', 'BeaconSFTPConnection');
		break;
	}
	break;
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
$ftp_mode = $ftp_provider->ConnectionType();
$reply_details = array(
	'ref' => $ref,
	'ftp_mode' => $ftp_mode
);

switch ($method) {
case 'GET':
	$object = BeaconAPI::ObjectID();
	if ($object == 'discover' || $object == 'path') {
		if (isset($_REQUEST['path'])) {
			$ftp_path = $_REQUEST['path'];
		} else {
			$hier = array(
				array('arkse/','arkserver/'),
				array('ShooterGame/'),
				array('Saved/')
			);
			$ftp_path = Discover($ftp_provider, '', $hier);
			if ($ftp_path === false) {
				BeaconAPI::ReplyError('Unable to determine path to ShooterGame/Saved folder.', $reply_details, 404);
			}
		}
		$reply_details['path'] = $ftp_path;
		if ($object == 'path') {
			BeaconAPI::ReplySuccess($reply_details);
		}
		$config_path = Discover($ftp_provider, $ftp_path . 'Config/', array(array('WindowsServer/', 'LinuxServer/', 'WindowsNoEditor/')));
		if ($config_path === false) {
			BeaconAPI::ReplyError('Unable to find Config folder in "' . $ftp_path . '"', $reply_details, 404);
		}
		$game_ini_path = $config_path . 'Game.ini';
		$settings_ini_path = $config_path . 'GameUserSettings.ini';
		
		$reply_details['Game.ini'] = $game_ini_path;
		$reply_details['GameUserSettings.ini'] = $settings_ini_path;

		$log_found = false;
		$logs_path = $ftp_path . 'Logs';
		$logs_list = $ftp_provider->ListFiles($logs_path);
		rsort($logs_list);
		foreach ($logs_list as $log_file) {
			$filename = basename($log_file);
			if (substr($filename, 0, 11) != 'ShooterGame') {
				continue;
			}
			
			$data = $ftp_provider->Download($logs_path . '/' . $log_file);
			if ($data === false || $data === '') {
				continue;
			}

			$log_found = true;
			foreach (preg_split("/((\r?\n)|(\r\n?))/", $data) as $line) {
				$pos = stripos($line, 'CommandLine: ');
				if ($pos === false) {
					continue;
				}
				$pos += 13;
				if (substr($line, $pos, 1) == '=') {
					$pos += 1;
					$end = strpos($line, '"', $pos);
				} else {
					$end = strlen($line);
				}
				$length = $end - $pos;
				$content = substr($line, $pos, $length);
				
				$in_quotes = false;
				$chars = str_split($content);
				$buffer = '';
				$params = array();
				foreach ($chars as $char) {
					if ($char == '"') {
						if ($in_quotes) {
							$params[] = $buffer;
							$buffer = '';
							$in_quotes = false;
						} else {
							$in_quotes = true;
						}
						continue;
					} elseif ($char == ' ') {
						if (!$in_quotes) {
							$params[] = $buffer;
							$buffer = '';
						}
					} elseif ($char == '-' && $buffer == '') {
						continue;
					} else {
						$buffer .= $char;
					}
				}
				if ($buffer != '') {
					$params[] = $buffer;
					$buffer = '';
				}
				
				$startup_params = explode('?', array_shift($params));
				$map = array_shift($startup_params);
				$listen = array_shift($startup_params);
				$params = array_merge($startup_params, $params);

				$arguments = array();
				foreach ($params as $param) {
					if ($param == '') {
						continue;
					}
					if (strstr($param, '=')) {
						list($key, $value) = explode('=', $param, 2);
						$arguments[$key] = $value;
					} else {
						$arguments[$param] = 'true';
					}
				}
				$reply_details['Maps'] = array($map);
				$reply_details['Options'] = $arguments;
			}

			break;
		}

		if (!$log_found) {
			// That's unfortunate. Let's try something else.
			$folders = $ftp_provider->ListFiles($ftp_path);
			$possibles = array();
			foreach ($folders as $folder_path) {
				$foldername = basename($folder_path);
				if ((substr($foldername, -9) == 'SavedArks/') || (substr($foldername, -14) == 'SavedArksLocal/')) {
					$possibles[] = $foldername;
				}
			}

			$maps = array();
			foreach ($possibles as $possible) {
				$files = $ftp_provider->ListFiles($ftp_path . $possible);
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
			$reply_details['Maps'] = $maps;
		}

		BeaconAPI::ReplySuccess($reply_details);
	} else {
		$ftp_path = isset($_REQUEST['path']) ? $_REQUEST['path'] : BeaconAPI::ReplyError('Missing path variable.', $reply_details, 400);
		
		if (substr($ftp_path, -1) == '/') {
			$list = $ftp_provider->ListFiles($ftp_path);
			if (is_array($list)) {
				$reply_details['files'] = $list;
				BeaconAPI::ReplySuccess($reply_details);
			} else {
				BeaconAPI::ReplyError('Unable to list path.', $reply_details, 500);
			}
		} elseif (strtolower(substr($ftp_path, -4)) == '.ini') {
			$content = $ftp_provider->Download($ftp_path);
			if ($content === false) {
				BeaconAPI::ReplyError('Unable to download file.', $reply_details, 500);
			}
			
			$reply_details['content'] = $content;
			BeaconAPI::ReplySuccess($reply_details);
		} else {
			BeaconAPI::ReplyError('Requested file does not appear to be an ini file.', $reply_details, 500);
		}
		break;
	}
case 'POST':
	if (BeaconAPI::ContentType() !== 'text/plain') {
		BeaconAPI::ReplyError('Send plain text data.', $reply_details, 400);
	}

	$ftp_path = isset($_REQUEST['path']) ? $_REQUEST['path'] : BeaconAPI::ReplyError('Missing path variable.', $reply_details, 400);

	$temp_path = sys_get_temp_dir() . '/' . BeaconCommon::GenerateUUID();
	file_put_contents($temp_path, BeaconAPI::Body());

	$success = $ftp_provider->Upload($ftp_path, $temp_path);
	if (file_exists($temp_path)) {
		unlink($temp_path);
	}

	if ($success) {
		BeaconAPI::ReplySuccess(array('ref' => $ref));
	} else {
		BeaconAPI::ReplyError('Unable to upload file.', $reply_details, 500);
	}

	break;
default:
	BeaconAPI::ReplyError('Method not allowed.', $reply_details, 405);
	break;
}

function Discover(BeaconFTPProvider $connection, string $starting_path, array $hierarchy) {
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

function SearchDirectory(BeaconFTPProvider $connection, string $starting_path, array $possibles) {
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
				return $starting_path . $file;
			}
		}
	}
}

?>

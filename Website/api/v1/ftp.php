<?php
	
require(dirname(__FILE__) . '/loader.php');

$method = BeaconAPI::Method();
BeaconAPI::Authorize();

$ftp_user = isset($_REQUEST['user']) ? $_REQUEST['user'] : BeaconAPI::ReplyError('Missing user variable.', null, 400);
$ftp_pass = isset($_REQUEST['pass']) ? $_REQUEST['pass'] : BeaconAPI::ReplyError('Missing pass variable.', null, 400);
$ftp_host = isset($_REQUEST['host']) ? $_REQUEST['host'] : BeaconAPI::ReplyError('Missing host variable.', null, 400);
$ftp_port = isset($_REQUEST['port']) ? intval($_REQUEST['port']) : 0;
if ($ftp_port == 0) {
	$ftp_port = 21;
}
$ref = isset($_REQUEST['ref']) ? $_REQUEST['ref'] : BeaconCommon::GenerateUUID();

$connection = ftp_ssl_connect($ftp_host, $ftp_port);
if ($connection === false) {
	BeaconAPI::ReplyError('Unable to connect to host.', array('ref' => $ref, 'host' => $ftp_host . ':' . $ftp_port), 500);
}
if (!@ftp_login($connection, $ftp_user, $ftp_pass)) {
	$connection = ftp_connect($ftp_host, $ftp_port);
	if ($connection === false) {
		BeaconAPI::ReplyError('Unable to connect to host.', array('ref' => $ref, 'host' => $ftp_host . ':' . $ftp_port), 500);
	}
	if (!@ftp_login($connection, $ftp_user, $ftp_pass)) {
		BeaconAPI::ReplyError('Unable to authenticate with host.', array('ref' => $ref), 500);
	}
}
ftp_pasv($connection, true);

switch ($method) {
case 'GET':
	$object = BeaconAPI::ObjectID();
	if ($object == 'discover') {
		$hier = array(
			array('arkse','arkserver'),
			array('ShooterGame'),
			array('Saved')
		);
		$ftp_path = Discover($connection, '', $hier);
		$config_path = Discover($connection, $ftp_path . 'Config/', array(array('WindowsServer', 'LinuxServer', 'WindowsNoEditor')));
		$game_ini_path = $config_path . 'Game.ini';
		$settings_ini_path = $config_path . 'GameUserSettings.ini';
		
		$results = array(
			'Game.ini' => $game_ini_path,
			'GameUserSettings.ini' => $settings_ini_path,
			'ref' => $ref
		);
		
		$log_found = false;
		$logs_path = $ftp_path . 'Logs';
		$logs_list = ftp_nlist($connection, $logs_path);
		rsort($logs_list);
		foreach ($logs_list as $log_file) {
			$filename = basename($log_file);
			if (substr($filename, 0, 11) != 'ShooterGame') {
				continue;
			}
			
			ob_start();
			$result = ftp_get($connection, "php://output", $log_file, FTP_ASCII);
			$data = ob_get_contents();
			ob_end_clean();
			
			if ((!$result) || ($data == '')) {
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
			$folders = ftp_nlist($connection, $ftp_path);
			$possibles = array();
			foreach ($folders as $folder_path) {
				$foldername = basename($folder_path);
				if ((substr($foldername, -9) == 'SavedArks') || (substr($foldername, -14) == 'SavedArksLocal')) {
					$possibles[] = $foldername;
				}
			}
			
			$maps = array();
			foreach ($possibles as $possible) {
				$files = ftp_nlist($connection, $ftp_path . $possible);
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
		
		$temp_path = sys_get_temp_dir() . '/' . BeaconCommon::GenerateUUID();
		$success = @ftp_get($connection, $temp_path, $ftp_path, FTP_ASCII);
		ftp_close($connection);
		
		if ($success) {
			header('Content-Type: text/plain');
			$content = file_get_contents($temp_path);
			unlink($temp_path);
			BeaconAPI::ReplySuccess(array('ref' => $ref, 'content' => $content));
		} else {
			if (file_exists($temp_path)) {
				unlink($temp_path);
			}
			BeaconAPI::ReplyError('Unable to download file.', array('ref' => $ref, 'path' => $ftp_path), 500);
		}
		break;
	}
case 'POST':
	if (BeaconAPI::ContentType() !== 'text/plain') {
		BeaconAPI::ReplyError('Send plain text data.', array('ref' => $ref), 400);
	}
	
	$temp_path = sys_get_temp_dir() . '/' . BeaconCommon::GenerateUUID();
	file_put_contents($temp_path, BeaconAPI::Body());
	
	$success = ftp_put($connection, $ftp_path, $temp_path, FTP_ASCII);
	ftp_close($connection);
	
	if ($success) {
		BeaconAPI::ReplySuccess(array('ref' => $ref));
		unlink($temp_path);
	} else {
		if (file_exists($temp_path)) {
			unlink($temp_path);
		}
		BeaconAPI::ReplyError('Unable to upload file.', array('ref' => $ref, 'path' => $ftp_path), 500);
	}
	
	break;
default:
	BeaconAPI::ReplyError('Method not allowed.', array('ref' => $ref), 405);
	break;
}

function Discover($connection, $starting_path, $hierarchy) {
	$path = $starting_path;
	while (count($hierarchy) > 0) {
		$contents = ftp_nlist($connection, $path);
		foreach ($hierarchy as $possibles) {
			foreach ($possibles as $possible) {
				if (in_array($path . $possible, $contents)) {
					$path .= $possible . '/';
					array_shift($hierarchy);
					break 2;
				}
			}
			
			// can't locate any further
			array_shift($hierarchy);
		}
	}
	return $path;
}
		

?>
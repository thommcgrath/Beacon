<?php
	
require(dirname(__FILE__) . '/loader.php');

$method = BeaconAPI::Method();
BeaconAPI::Authorize();

$ftp_user = isset($_REQUEST['user']) ? $_REQUEST['user'] : BeaconAPI::ReplyError('Missing user variable.', null, 400);
$ftp_pass = isset($_REQUEST['pass']) ? $_REQUEST['pass'] : BeaconAPI::ReplyError('Missing pass variable.', null, 400);
$ftp_host = isset($_REQUEST['host']) ? $_REQUEST['host'] : BeaconAPI::ReplyError('Missing host variable.', null, 400);
$ftp_port = isset($_REQUEST['port']) ? intval($_REQUEST['port']) : 0;
$ftp_path = isset($_REQUEST['path']) ? $_REQUEST['path'] : BeaconAPI::ReplyError('Missing path variable.', null, 400);
if ($ftp_port == 0) {
	$ftp_port = 21;
}

if (strtolower(substr($ftp_path, -4)) != '.ini') {
	BeaconAPI::ReplyError('Requested file does not appear to be an ini file.', $ftp_path, 500);
}

$connection = ftp_connect($ftp_host, $ftp_port);
if ($connection === false) {
	BeaconAPI::ReplyError('Unable to connect to host.', $ftp_host . ':' . $ftp_port, 500);
}
if (!@ftp_login($connection, $ftp_user, $ftp_pass)) {
	BeaconAPI::ReplyError('Unable to authenticate with host.', null, 500);
}
ftp_pasv($connection, true);

switch ($method) {
case 'GET':
	$temp_path = sys_get_temp_dir() . '/' . BeaconCommon::GenerateUUID();
	$success = @ftp_get($connection, $temp_path, $ftp_path, FTP_ASCII);
	ftp_close($connection);
	
	if ($success) {
		header('Content-Type: text/plain');
		readfile($temp_path);
		unlink($temp_path);
	} else {
		if (file_exists($temp_path)) {
			unlink($temp_path);
		}
		BeaconAPI::ReplyError('Unable to download file.', $ftp_path, 500);
	}
	break;
case 'POST':
	if (BeaconAPI::ContentType() !== 'text/plain') {
		BeaconAPI::ReplyError('Send plain text data.');
	}
	
	$temp_path = sys_get_temp_dir() . '/' . BeaconCommon::GenerateUUID();
	file_put_contents($temp_path, BeaconAPI::Body());
	
	$success = ftp_put($connection, $ftp_path, $temp_path, FTP_ASCII);
	ftp_close($connection);
	
	if ($success) {
		BeaconAPI::ReplySuccess();
		unlink($temp_path);
	} else {
		if (file_exists($temp_path)) {
			unlink($temp_path);
		}
		BeaconAPI::ReplyError('Unable to upload file.', $ftp_path, 500);
	}
	
	break;
default:
	BeaconAPI::ReplyError('Method not allowed.', null, 405);
	break;
}

?>
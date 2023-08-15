<?php

use BeaconAPI\v4\{Response, Core, Project, User};
	
function handleRequest(array $context): Response {
	if (Core::ContentType() !== 'application/x-beacon-project') {
		return Response::NewJsonError('Unsupported media type.', 'Send application/x-beacon-project', 415);
	}
	
	$stream = fopen('php://input', 'rb');
	$bom = bin2hex(fread($stream, 8));
	
	if (Project::IsBinaryProjectFormat($bom)) {
		fclose($stream);
		return Response::NewJsonError('Byte order mark is not correct.', 'Send application/x-beacon-project', 415);
	}
	
	$tempdir = sys_get_temp_dir() . '/' . BeaconUUID::v4();
	mkdir($tempdir, 0700);
	$archive = $tempdir . '/archive.tar.gz';
	$out = fopen($archive, 'w+b');
	stream_copy_to_stream($stream, $out);
	fclose($out);
	fclose($stream);
	
	$phar = new PharData($archive);
	$manifest = json_decode($phar['Manifest.json']->getContent(), true);
	$phar = null;
	
	unlink($archive);
	rmdir($tempdir);
	
	$project = null;
	$database = BeaconCommon::Database();
	try {
		$database->BeginTransaction();
		$project = Project::Save(Core::User(), $manifest);
		$path = $project->CloudStoragePath();
		BeaconCloudStorage::PutFile($path, file_get_contents('php://input'));
		$database->Commit();
	} catch (Exception $err) {
		$database->Rollback();
		return Response::NewJsonError($err->getMessage(), null, $err->getCode());
	}
	
	return Response::NewJson($project, 200);
}

?>

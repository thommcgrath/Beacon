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
	
	$projectId = $context['pathParameters']['projectId'];
	$project = Project::Fetch($projectId);
	$errorDetails = ['projectId' => $projectId];
	$newProject = is_null($project);
	$userId = Core::UserId();
	
	if ($newProject === false && $project->UserId() !== $userId) {
		return Response::NewJsonError('Forbidden.', $errorDetails, 403);
	}
	
	$name = $_POST['name'] ?? '';
	$errorDetails['name'] = $name;
	if (empty($name)) {
		return Response::NewJsonError('Project name should not be empty.', $errorDetails, 400);
	}
	
	$existingProjects = Project::Search(['name' => $name, 'userId' => $userId], true);
	if (count($existingProjects) > 0) {
		$nameError = true;
		if ($newProject === false) {
			foreach ($existingProjects as $existingProject) {
				if ($existingProject->ProjectId() === $projectId) {
					$nameError = false;
					break;
				}
			}
		}
		if ($nameError) {
			return Response::NewJsonError('There is already a project with this name. Please choose another.', $errorDetails, 400);
		}
	}

	return Response::NewJsonError('Not implemented yet', $errorDetails, 500);
}

?>

<?php

use BeaconAPI\v4\{ContentPack, ContentPackDiscoveryResult, Core, Response};

function handleRequest(array $context): Response {
	$contentPackId = strtolower($context['pathParameters']['contentPackId']);

	$archivePath = tempnam(sys_get_temp_dir(), 'contentPack') . '.tgz';
	$inStream = fopen('php://input', 'rb');
	$outStream = fopen($archivePath, 'wb');
	stream_copy_to_stream($inStream, $outStream);
	fclose($outStream);
	fclose($inStream);

	$database = BeaconCommon::Database();

	try {
		$archive = new PharData($archivePath);
		$manifest = json_decode($archive['Manifest.json']->getContent(), true);
		if ($manifest['minVersion'] > 7) {
			$archive = null;
			unlink($archivePath);
			return Response::NewJsonError('Mod data is in a format that is too new for this API.', null, 400);
		}
		$files = $manifest['files'];
		if (count($files) !== 1) {
			return Response::NewJsonError('Incorrect number of files included.', null, 400);
		}
		$filename = $files[0];

		$mainData = json_decode($archive[$filename]->getContent(), true);
		$archive = null;
		$payloads = $mainData['payloads'];
		foreach ($payloads as $payload) {
			$gameId = $payload['gameId'];
			if (array_key_exists('contentPacks', $payload) === false) {
				continue;
			}

			$contentPacks = $payload['contentPacks'];
			if (count($contentPacks) <> 1) {
				unlink($archivePath);
				return Response::NewJsonError('Too many mods included.', null, 400);
			}

			$contentPackInfo = $contentPacks[0];
			if ($contentPackId !== $contentPackInfo['contentPackId']) {
				unlink($archivePath);
				return Response::NewJsonError('Wrong mod included for this url.', null, 400);
			}

			$marketplace = $contentPackInfo['marketplace'];
			$marketplaceId = $contentPackInfo['marketplaceId'];
			$expectedContentPackId = ContentPack::GenerateLocalId($marketplace, $marketplaceId);
			if ($contentPackId !== $expectedContentPackId) {
				unlink($archivePath);
				return Response::NewJsonError('Wrong contentPackId for this url.', null, 400);
			}

			$database->BeginTransaction();
			$contentPackDiscoveryResult = ContentPackDiscoveryResult::Save($contentPackInfo, $gameId);
			if (is_null($contentPackDiscoveryResult)) {
				$database->Rollback();
				unlink($archivePath);
				return Response::NewJsonError('Could not save mod info to database. Newer data may already be saved.', null, 400);
			}

			if (BeaconCloudStorage::PutFile($contentPackDiscoveryResult->StoragePath(), file_get_contents($archivePath)) === false) {
				$database->Rollback();
				unlink($archivePath);
				return Response::NewJsonError('Could not upload mod data to cold storage.', null, 500);
			}

			$database->Commit();
			unlink($archivePath);
			return Response::NewJson($contentPackDiscoveryResult, 200);
		}
	} catch (Exception $err) {
		if ($database->InTransaction()) {
			$database->Rollback();
		}
		if (file_exists($archivePath)) {
			unlink($archivePath);
		}
		return Response::NewJsonError('Encountered an error unpacking mod data.', $err->getMessage(), 400);
	}
}

?>

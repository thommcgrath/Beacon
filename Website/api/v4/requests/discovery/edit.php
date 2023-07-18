<?php

use BeaconAPI\v4\{Core, ModDiscoveryResult, Response};
	
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
		
		$mainData = json_decode($archive['Main.beacondata']->getContent(), true);
		$archive = null;
		$gameIds = ['ark'];
		foreach ($gameIds as $gameId) {
			if (array_key_exists($gameId, $mainData) === false) {
				continue;
			}
			
			$gameData = $mainData[$gameId];
			if (array_key_exists('contentPacks', $gameData) === false) {
				continue;
			}
			
			$contentPacks = $gameData['contentPacks'];
			if (count($contentPacks) <> 1) {
				unlink($archivePath);
				return Response::NewJsonError('Too many mods included.', null, 400);
			}
			
			$contentPackInfo = $contentPacks[0];
			if ($contentPackId !== $contentPackInfo['contentPackId']) {
				unlink($archivePath);
				return Response::NewJsonError('Wrong mod included for this url.', null, 400);
			}
			
			$steamId = $contentPackInfo['steamId'];
			$expectedContentPackId = BeaconUUID::v5('local ' . $steamId);
			if ($contentPackId !== $expectedContentPackId) {
				unlink($archivePath);
				return Response::NewJsonError('Wrong contentPackId for this url.', null, 400);
			}
			
			$database->BeginTransaction();
			$modDiscoveryResult = ModDiscoveryResult::Save($contentPackInfo, $gameId);
			if (is_null($modDiscoveryResult)) {
				$database->Rollback();
				unlink($archivePath);
				return Response::NewJsonError('Could not save mod info to database. Newer data may already be saved.', null, 400);
			}
			
			if (BeaconCloudStorage::PutFile($modDiscoveryResult->StoragePath(), file_get_contents($archivePath)) === false) {
				$database->Rollback();
				unlink($archivePath);
				return Response::NewJsonError('Could not upload mod data to cold storage.', null, 500);
			}
			
			$database->Commit();
			unlink($archivePath);
			return Response::NewJson($modDiscoveryResult, 200);
		}
	} catch (Exception $err) {
		if ($database->InTransaction()) {
			$database->ResetTransactions();	
		}
		if (file_exists($archivePath)) {
			unlink($archivePath);
		}
		return Response::NewJsonError('Encountered an error unpacking mod data.', $err->getMessage(), 400);
	}
}

?>
<?php

use BeaconAPI\v4\{APIResponse, Application, Core};

Core::Authorize('apps:write');

function handleRequest(array $context): APIResponse {
	$appId = $context['pathParameters']['applicationId'];
	$app = Application::Fetch($appId);
	if (empty($app)) {
		return APIResponse::NewJsonError('Application not found', $appId, 404);
	}
	if ($app->UserId() !== Core::UserId()) {
		return APIResponse::NewJsonError('Forbidden', $appId, 403);
	}
	$appId = $app->ApplicationId();
	
	$original = Core::Body();
	$info = new finfo(FILEINFO_MIME_TYPE);
	$mime = $info->buffer($original);
	
	switch ($mime) {
	//case 'image/svg+xml':
	//	$extension = 'svg';
	//	break;
	case 'image/png':
		$extension = 'png';
		break;
	case 'image/jpeg':
		$extension = 'jpg';
		break;
	default:
		return APIResponse::NewJsonError('Unsupported file type', $mime, 400);
	}
	
	$filename = "original.{$extension}";
	$uploads = [
		$filename => $original
	];
	$sizes = [1024, 512, 256, 128, 64, 32];
	
	foreach ($sizes as $size) {
		$magick = new Imagick();
		$magick->setBackgroundColor('none');
		$magick->readImageBlob($original);
		if ($magick->getImageColorspace() !== Imagick::COLORSPACE_SRGB) {
			$magick->transformImageColorspace(Imagick::COLORSPACE_SRGB);
		}
		$magick->resizeImage($size, $size, Imagick::FILTER_BOX, 1, true);
		$actualWidth = $magick->getImageWidth();
		$actualHeight = $magick->getImageHeight();
		
		$canvas = new Imagick();
		$canvas->newImage($size, $size, 'white', 'png');
		$canvas->compositeImage($magick, Imagick::COMPOSITE_OVER, floor(($size - $actualWidth) / 2), floor(($size - $actualHeight) / 2));
		
		$magick->clear();
		$magick->destroy();
		$magick = null;
		
		$uploads["{$size}px.png"] = $canvas->getImageBlob();
		
		$canvas->clear();
		$canvas->destroy();
		$canvas = null;
	}
	
	//return new APIResponse(200, $uploads['1024px.png'], ['Content-Type' => 'image/png']);
	
	$cdn = BeaconCDN::AssetsZone();
	foreach ($uploads as $filename => $data) {
		try {
			$cdn->PutFile("/images/avatars/{$appId}/{$filename}", $data);
		} catch (Exception $err) {
			return APIResponse::NewJsonError('Could not upload avatar', $err->getMessage(), 500);
		}
	}
	
	$app->Edit(['iconFilename' => '{{applicationId}}/{{size}}.png']);
	
	return APIResponse::NewJson([
		'path' => "/images/avatars/{$appId}/",
		'files' => array_keys($uploads)
	], 200);
}

?>

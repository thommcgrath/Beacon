<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');

if (isset($_GET['slug']) == false) {
	echo 'No article specified';
	http_response_code(400);
	exit;
}

BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('help.css'));

$slug = $_GET['slug'];
$database = BeaconCommon::Database();

$results = $database->Query('SELECT article_id, article_updated FROM support_articles WHERE article_slug = $1 AND published = TRUE;', $slug);
if ($results->RecordCount() == 0) {
	echo 'Article not found';
	http_response_code(404);
	exit;
}
$articleId = $results->Field('article_id');
$articleUpdated = $results->Field('article_updated');
$lastModified = new DateTime($articleUpdated);
$cacheKey = sha1($articleId . ':' . $articleUpdated);

$articleData = BeaconCache::Get($cacheKey);
if (is_null($articleData)) {
	$results = $database->Query('SELECT subject, content_markdown, preview, forward_url, array_to_string(affected_ini_keys, \', \',\'\') AS affected_keys FROM support_articles WHERE article_id = $1;', $articleId);
	
	$articleData = [
		'title' => $results->Field('subject'),
		'preview' => $results->Field('preview'),
		'photoswipeGalleries' => [],
	];
	
	if (is_null($results->Field('forward_url'))) {
		$markdown = $results->Field('content_markdown');
		
		// Replace module content
		$pattern = '/\[module:([a-z_]+)\]/i';
		while (preg_match($pattern, $markdown, $matches) === 1) {
			$moduleName = $matches[1];
			$moduleMarkdown = '';
			$match = $matches[0];
			
			$moduleResults = $database->Query('SELECT module_markdown FROM support_article_modules WHERE module_name = $1;', $moduleName);
			if ($moduleResults->RecordCount() === 1) {
				$moduleMarkdown = $moduleResults->Field('module_markdown');
			}
			
			$markdown = str_replace($match, $moduleMarkdown, $markdown);
		}
		
		// This is for images alone, they need to be centered.
		$pattern = '/\n\!\[([^\[\]]*)\]\(([0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-4[0-9A-Fa-f]{3}-[89ABab][0-9A-Fa-f]{3}-[0-9A-Fa-f]{12})\)\n/';
		while (preg_match($pattern, $markdown, $matches) === 1) {
			$alt = $matches[1];
			$imageId = $matches[2];
			$match = $matches[0];
			
			$imageDetails = $database->Query('SELECT image_id, width_points, height_points, min_scale, max_scale, extension FROM support_images WHERE image_id = $1;', $imageId);
			if ($imageDetails->RecordCount() === 0) {
				$html = '';
			} else {
				$imageId = $imageDetails->Field('image_id');
				$widthPoints = $imageDetails->Field('width_points');
				$heightPoints = $imageDetails->Field('height_points');
				$minScale = $imageDetails->Field('min_scale');
				$maxScale = $imageDetails->Field('max_scale');
				$extension = $imageDetails->Field('extension');
				$urls = [];
				$srcSet = [];
				for ($scale = $minScale; $scale <= $maxScale; $scale++) {
					if ($scale > 1) {
						$suffix = '@' . $scale . 'x';
					} else {
						$suffix = '';
					}
					$urls[$scale] = 'https://assets.usebeacon.app/images/help/' . $imageId . $suffix . $extension;
					$srcSet[] = $urls[$scale] . ' ' . $scale . 'x';
				}
				$fullScaleUrl = $urls[$maxScale];
				$lowScaleUrl = $urls[1];
				$srcSet = implode(', ', $srcSet);
				
				if ($widthPoints >= 300 || $heightPoints >= 300) {
					$photoswipeGallery = 'pswp' . BeaconCommon::GenerateRandomKey();
					$articleData['photoswipeGalleries'][] = $photoswipeGallery;
					$html = '<p class="text-center pswp-gallery" id="' . $photoswipeGallery . '"><a href="' . $fullScaleUrl . '" data-pswp-width="' . $widthPoints . '" data-pswp-height="' . $heightPoints . '"><img class="standalone" src="' . $lowScaleUrl . '" srcset="' . $srcSet . '" alt="' . htmlentities($alt) . '"></a></p>';
				} else {
					$html = '<p class="text-center"><img class="standalone" src="' . $lowScaleUrl . '" srcset="' . $srcSet . '" alt="' . htmlentities($alt) . '"></p>';
				}
			}
			
			$markdown = str_replace($match, $html, $markdown);
		}
		
		// This is for inline images.
		$pattern = '/\!\[([^\[\]]*)\]\(([0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-4[0-9A-Fa-f]{3}-[89ABab][0-9A-Fa-f]{3}-[0-9A-Fa-f]{12})\)/';
		while (preg_match($pattern, $markdown, $matches) === 1) {
			$alt = $matches[1];
			$imageId = $matches[2];
			$match = $matches[0];
			$imageDetails = $database->Query('SELECT image_id, width_points, height_points, min_scale, max_scale, extension FROM support_images WHERE image_id = $1;', $imageId);
			if ($imageDetails->RecordCount() === 0) {
				$html = '';
			} else {
				$imageId = $imageDetails->Field('image_id');
				$widthPoints = $imageDetails->Field('width_points');
				$heightPoints = $imageDetails->Field('height_points');
				$minScale = $imageDetails->Field('min_scale');
				$maxScale = $imageDetails->Field('max_scale');
				$extension = $imageDetails->Field('extension');
				$urls = [];
				$srcSet = [];
				for ($scale = $minScale; $scale <= $maxScale; $scale++) {
					if ($scale > 1) {
						$suffix = '@' . $scale . 'x';
					} else {
						$suffix = '';
					}
					$urls[$scale] = 'https://assets.usebeacon.app/images/help/' . $imageId . $suffix . $extension;
					$srcSet[] = $urls[$scale] . ' ' . $scale . 'x';
				}
				$lowScaleUrl = $urls[1];
				$srcSet = implode(', ', $srcSet);
			}
			
			$html = '<img class="inline" src="' . $lowScaleUrl . '" srcset="' . $srcSet . '" alt="' . htmlentities($alt) . '">';
			
			$markdown = str_replace($match, $html, $markdown);
		}
		
		// This is for article links.
		$pattern = '/\[([^\[\]]*)\]\(([0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-4[0-9A-Fa-f]{3}-[89ABab][0-9A-Fa-f]{3}-[0-9A-Fa-f]{12})\)/';
		while (preg_match($pattern, $markdown, $matches) === 1) {
			$match = $matches[0];
			$caption = $matches[1];
			$articleId = $matches[2];
			$linkData = $database->Query('SELECT article_slug, subject FROM support_articles WHERE article_id = $1;', $articleId);
			if ($linkData->RecordCount() !== 1) {
				$html = '<a href="' . $articleId . '">' . htmlentities($caption) . '</a>';
			} else {
				if (empty($caption)) {
					$caption = $linkData->Field('subject');
				}
				$html = '<a href="' . $linkData->Field('article_slug') . '">' . htmlentities($caption) . '</a>';
			}
			
			$markdown = str_replace($match, $html, $markdown);
		}
		
		$parser = new Parsedown();
		$articleData['html'] = '<div class="header-with-subtitle"><h1>' . htmlentities($results->Field('subject')) . '</h1><div class="subtitle text-lighter">Last updated <time datetime="' . htmlentities($lastModified->format('c')) . '">' . htmlentities($lastModified->format('l F jS, Y \a\t g:i:s A T')) . '</time></div></div>' . "\n" . '<p class="help-summary">' . htmlentities($articleData['preview']) . "</p>\n" . str_replace('<table>', '<table class="generic">', $parser->text($markdown));
		
		if ($results->Field('affected_keys') != '') {
			// Want these keys on the page for SEO purposes
			$affected_keys = explode(',', $results->Field('affected_keys'));
			natsort($affected_keys);
			$caption = 'This editor affects the following Ark config key' . (count($affected_keys) > 1 ? 's' : '') . ': ';
			$articleData['html'] .= '<div class="affected_ini_keys">' . htmlentities($caption) . BeaconCommon::ArrayToEnglish($affected_keys) . '</div>';
		}
	} else {
		$articleData['forward'] = $results->Field('forward_url');
	}
	
	BeaconCache::Set($cacheKey, $articleData, 86400);
}
if (isset($articleData['forward'])) {
	BeaconCommon::Redirect($articleData['forward'], false);
}

BeaconTemplate::AddScript(BeaconCommon::AssetUri('helpArticle.js'));
if (count($articleData['photoswipeGalleries']) > 0) {
	BeaconTemplate::AddScript(BeaconCommon::AssetUri('photoswipe.js'));
	BeaconTemplate::AddStylesheet(BeaconCommon::AssetUri('photoswipe.css'));
	
	BeaconTemplate::StartScript();
	?><script>
	document.addEventListener('DOMContentLoaded', () => {
		const event = new Event('beaconRunPhotoswipe');
		event.galleryIds = <?php echo json_encode($articleData['photoswipeGalleries']); ?>;
		document.dispatchEvent(event);
	});
	</script><?php
	BeaconTemplate::FinishScript();
}

header('ETag: "' . $cacheKey . '"');
header('Cache-Control: public, max-age=86400');
header('Last-Modified: ' . $lastModified->format('D, d M Y H:i:s') . ' GMT');

BeaconTemplate::SetTitle($articleData['title']);
BeaconTemplate::SetPageDescription($articleData['preview']);

include('inc.knowledge.php');
ShowKnowledgeContent($articleData['html'], $slug);
	
?>
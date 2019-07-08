<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');

if (isset($_GET['slug']) == false) {
	echo 'No article specified';
	http_response_code(400);
	exit;
}

BeaconTemplate::StartStyles(); ?>
<style>

img.inline {
	max-width: 100%;
	vertical-align: text-bottom;
	background-color: #ffffff;
	border-radius: 2px;
	padding: 2px;
}

img.standalone {
	max-width: 100%;
}

pre {
	code {
		font-size: 1.0em;
	}
	
	border-radius: 0px;
	margin: 0px;
}

</style>
<?php
BeaconTemplate::FinishStyles();

$slug = $_GET['slug'];
$database = BeaconCommon::Database();

$results = $database->Query('SELECT article_id, article_hash FROM support_articles WHERE article_slug = $1 AND published = TRUE;', $slug);
if ($results->RecordCount() == 0) {
	echo 'Article not found';
	http_response_code(404);
	exit;
}
$article_id = $results->Field('article_id');
$cache_key = $results->Field('article_hash');
$photoswipe_triggers = array();

$article_data = BeaconCache::Get($cache_key);
//if (is_null($article_data)) {
	$results = $database->Query('SELECT subject, content_markdown, preview, forward_url, array_to_string(affected_ini_keys, \', \',\'\') AS affected_keys FROM support_articles WHERE article_id = $1;', $article_id);
	
	$article_data = array(
		'title' => $results->Field('subject'),
		'preview' => $results->Field('preview'),
		'pswp_js' => array()
	);
	
	if (is_null($results->Field('forward_url'))) {
		$markdown = $results->Field('content_markdown');
		
		// This is for images alone, they need to be centered.
		$pattern = '/\n\!\[([^\[\]]*)\]\(([0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-4[0-9A-Fa-f]{3}-[89ABab][0-9A-Fa-f]{3}-[0-9A-Fa-f]{12})\)\n/';
		while (preg_match($pattern, $markdown, $matches) === 1) {
			$alt = $matches[1];
			$image_id = $matches[2];
			$match = $matches[0];
			$use_photoswipe = false;
			
			$imagedata = $database->Query('SELECT width_points, height_points FROM support_images WHERE image_id = $1;', $image_id);
			if ($imagedata->RecordCount() == 1 && ($imagedata->Field('width_points') >= 300 || $imagedata->Field('height_points') >= 300)) {
				$image_url = '/help/image/' . $image_id . '@3x';
				$use_photoswipe = true;
				$photoswipe_trigger = 'pswp' . BeaconCommon::GenerateRandomKey();
				$article_data['pswp_js'][] = "document.getElementById('$photoswipe_trigger').addEventListener('click', function(ev) {
		var pswpElement = document.querySelectorAll('.pswp')[0];
		var items = [{src: '$image_url', w: {$imagedata->Field('width_points')}, h: {$imagedata->Field('height_points')}, title: " . json_encode($alt) . "}];
		var options = {};
		var gallery = new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, items, options);
		gallery.init();
		ev.preventDefault();
	});";
			}
			
			$html = '<p class="text-center">' . ($use_photoswipe ? '<a href="' . $image_url . '" id="' . $photoswipe_trigger . '">' : '') . '<img class="standalone" src="/help/image/' . $image_id . '" srcset="/help/image/' . $image_id . ' 1x, /help/image/' . $image_id . '@2x 2x, /help/image/' . $image_id . '@3x 3x" alt="' . htmlentities($alt) . '">' . ($use_photoswipe ? '</a>' : '') . '</p>';
			
			$markdown = str_replace($match, $html, $markdown);
		}
		
		// This is for inline images.
		$pattern = '/\!\[([^\[\]]*)\]\(([0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-4[0-9A-Fa-f]{3}-[89ABab][0-9A-Fa-f]{3}-[0-9A-Fa-f]{12})\)/';
		while (preg_match($pattern, $markdown, $matches) === 1) {
			$alt = $matches[1];
			$image_id = $matches[2];
			$match = $matches[0];
			$html = '<img class="inline" src="/help/image/' . $image_id . '" srcset="/help/image/' . $image_id . ' 1x, /help/image/' . $image_id . '@2x 2x, /help/image/' . $image_id . '@3x 3x" alt="' . htmlentities($alt) . '">';
			
			$markdown = str_replace($match, $html, $markdown);
		}
		
		$parser = new Parsedown();
		$article_data['html'] = '<h1>' . htmlentities($results->Field('subject')) . '</h1>' . "\n" . $parser->text($markdown);
		
		if ($results->Field('affected_keys') != '') {
			// Want these keys on the page for SEO purposes
			$affected_keys = explode(',', $results->Field('affected_keys'));
			natsort($affected_keys);
			$caption = 'This editor affects the following Ark config key' . (count($affected_keys) > 1 ? 's' : '') . ': ';
			$article_data['html'] .= '<div class="affected_ini_keys">' . htmlentities($caption) . BeaconCommon::ArrayToEnglish($affected_keys) . '</div>';
		}
	} else {
		$article_data['forward'] = $results->Field('forward_url');
	}
	
	BeaconCache::Set($cache_key, $article_data, 86400);
//}
if (isset($article_data['forward'])) {
	BeaconCommon::Redirect($article_data['forward'], false);
}

if (count($article_data['pswp_js']) > 0) {
	BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('photoswipe.css'));
	BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('photoswipe-ui.css'));
	BeaconTemplate::AddScript(BeaconCommon::AssetURI('photoswipe.min.js'));
	BeaconTemplate::AddScript(BeaconCommon::AssetURI('photoswipe-ui-default.min.js'));
	
	BeaconTemplate::StartScript();
	echo "<script>\n";
	
	echo "document.addEventListener('DOMContentLoaded', function() {\n\t";
	echo implode("\n\t\n\t", $article_data['pswp_js']);
	echo "\n});";
	
	echo "\n</script>";
	BeaconTemplate::FinishScript();
}

BeaconTemplate::SetTitle($article_data['title']);
BeaconTemplate::SetPageDescription($article_data['preview']);

include('inc.knowledge.php');
ShowKnowledgeContent($article_data['html'], $slug);
	
?>
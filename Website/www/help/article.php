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

$results = $database->Query('SELECT article_id, article_updated FROM support_articles WHERE article_slug = $1 AND published = TRUE;', $slug);
if ($results->RecordCount() == 0) {
	echo 'Article not found';
	http_response_code(404);
	exit;
}
$article_id = $results->Field('article_id');
$article_updated = $results->Field('article_updated');
$last_modified = new DateTime($article_updated);
$cache_key = md5($article_id . ':' . $article_updated);
$photoswipe_triggers = array();

$article_data = BeaconCache::Get($cache_key);
if (is_null($article_data)) {
	$results = $database->Query('SELECT subject, content_markdown, preview, forward_url, array_to_string(affected_ini_keys, \', \',\'\') AS affected_keys FROM support_articles WHERE article_id = $1;', $article_id);
	
	$article_data = array(
		'title' => $results->Field('subject'),
		'preview' => $results->Field('preview'),
		'pswp_js' => array()
	);
	
	if (is_null($results->Field('forward_url'))) {
		$markdown = $results->Field('content_markdown');
		
		// Replace module content
		$pattern = '/\[module:([a-z_]+)\]/i';
		while (preg_match($pattern, $markdown, $matches) === 1) {
			$module_name = $matches[1];
			$module_markdown = '';
			$match = $matches[0];
			
			$module_results = $database->Query('SELECT module_markdown FROM support_article_modules WHERE module_name = $1;', $module_name);
			if ($module_results->RecordCount() === 1) {
				$module_markdown = $module_results->Field('module_markdown');
			}
			
			$markdown = str_replace($match, $module_markdown, $markdown);
		}
		
		// This is for images alone, they need to be centered.
		$pattern = '/\n\!\[([^\[\]]*)\]\(([0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-4[0-9A-Fa-f]{3}-[89ABab][0-9A-Fa-f]{3}-[0-9A-Fa-f]{12})\)\n/';
		while (preg_match($pattern, $markdown, $matches) === 1) {
			$alt = $matches[1];
			$image_id = $matches[2];
			$match = $matches[0];
			$use_photoswipe = false;
			
			$imagedata = $database->Query('SELECT image_id, width_points, height_points, min_scale, max_scale, extension FROM support_images WHERE image_id = $1;', $image_id);
			if ($imagedata->RecordCount() === 0) {
				$html = '';
			} else {
				$image_id = $imagedata->Field('image_id');
				$width_points = $imagedata->Field('width_points');
				$height_points = $imagedata->Field('height_points');
				$min_scale = $imagedata->Field('min_scale');
				$max_scale = $imagedata->Field('max_scale');
				$extension = $imagedata->Field('extension');
				$urls = [];
				$srcset = [];
				for ($scale = $min_scale; $scale <= $max_scale; $scale++) {
					if ($scale > 1) {
						$suffix = '@' . $scale . 'x';
					} else {
						$suffix = '';
					}
					$urls[$scale] = 'https://assets.usebeacon.app/images/help/' . $image_id . $suffix . $extension;
					$srcset[] = $urls[$scale] . ' ' . $scale . 'x';
				}
				$full_scale_url = $urls[$max_scale];
				$low_scale_url = $urls[1];
				$srcset = implode(', ', $srcset);
				
				if ($width_points >= 300 || $height_points >= 300) {
					$photoswipe_trigger = 'pswp' . BeaconCommon::GenerateRandomKey();
					$json_alt = json_encode($alt);
					$article_data['pswp_js'][] = <<<PSWP
document.getElementById('$photoswipe_trigger').addEventListener('click', function(ev) {
	var pswpElement = document.querySelectorAll('.pswp')[0];
	var items = [{src: '$full_scale_url', w: $width_points, h: $height_points, title: $json_alt}];
	var options = {};
	var gallery = new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, items, options);
	gallery.init();
	ev.preventDefault();
});					
PSWP;
					
					$html = '<p class="text-center"><a href="' . $full_scale_url . '" id="' . $photoswipe_trigger . '"><img class="standalone" src="' . $low_scale_url . '" srcset="' . $srcset . '" alt="' . htmlentities($alt) . '"></a></p>';
				} else {
					$html = '<p class="text-center"><img class="standalone" src="' . $low_scale_url . '" srcset="' . $srcset . '" alt="' . htmlentities($alt) . '"></p>';
				}
			}
			
			$markdown = str_replace($match, $html, $markdown);
		}
		
		// This is for inline images.
		$pattern = '/\!\[([^\[\]]*)\]\(([0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-4[0-9A-Fa-f]{3}-[89ABab][0-9A-Fa-f]{3}-[0-9A-Fa-f]{12})\)/';
		while (preg_match($pattern, $markdown, $matches) === 1) {
			$alt = $matches[1];
			$image_id = $matches[2];
			$match = $matches[0];
			$imagedata = $database->Query('SELECT image_id, width_points, height_points, min_scale, max_scale, extension FROM support_images WHERE image_id = $1;', $image_id);
			if ($imagedata->RecordCount() === 0) {
				$html = '';
			} else {
				$image_id = $imagedata->Field('image_id');
				$width_points = $imagedata->Field('width_points');
				$height_points = $imagedata->Field('height_points');
				$min_scale = $imagedata->Field('min_scale');
				$max_scale = $imagedata->Field('max_scale');
				$extension = $imagedata->Field('extension');
				$urls = [];
				$srcset = [];
				for ($scale = $min_scale; $scale <= $max_scale; $scale++) {
					if ($scale > 1) {
						$suffix = '@' . $scale . 'x';
					} else {
						$suffix = '';
					}
					$urls[$scale] = 'https://assets.usebeacon.app/images/help/' . $image_id . $suffix . $extension;
					$srcset[] = $urls[$scale] . ' ' . $scale . 'x';
				}
				$low_scale_url = $urls[1];
				$srcset = implode(', ', $srcset);
			}
			
			$html = '<img class="inline" src="' . $low_scale_url . '" srcset="' . $srcset . '" alt="' . htmlentities($alt) . '">';
			
			$markdown = str_replace($match, $html, $markdown);
		}
		
		// This is for article links.
		$pattern = '/\[([^\[\]]*)\]\(([0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-4[0-9A-Fa-f]{3}-[89ABab][0-9A-Fa-f]{3}-[0-9A-Fa-f]{12})\)/';
		while (preg_match($pattern, $markdown, $matches) === 1) {
			$match = $matches[0];
			$caption = $matches[1];
			$article_id = $matches[2];
			$link_data = $database->Query('SELECT article_slug, subject FROM support_articles WHERE article_id = $1;', $article_id);
			if ($link_data->RecordCount() !== 1) {
				$html = '<a href="' . $article_id . '">' . htmlentities($caption) . '</a>';
			} else {
				if (empty($caption)) {
					$caption = $link_data->Field('subject');
				}
				$html = '<a href="' . $link_data->Field('article_slug') . '">' . htmlentities($caption) . '</a>';
			}
			
			$markdown = str_replace($match, $html, $markdown);
		}
		
		$parser = new Parsedown();
		$article_data['html'] = '<h1>' . htmlentities($results->Field('subject')) . '<br><span class="subtitle text-lighter">Last updated <time datetime="' . htmlentities($last_modified->format('c')) . '">' . htmlentities($last_modified->format('l F jS, Y \a\t g:i:s A T')) . '</time></span></h1>' . "\n" . str_replace('<table>', '<table class="generic">', $parser->text($markdown));
		
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
}
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

BeaconTemplate::AddScript(BeaconCommon::AssetURI('moment.min.js'));
//BeaconTemplate::AddScript(BeaconCommon::AssetURI('moment-timezone-with-data-10-year-range.min.js'));
BeaconTemplate::StartScript();
?><script>
document.addEventListener('DOMContentLoaded', function() {
	var times = document.getElementsByTagName('time');
	for (var idx = 0; idx < times.length; idx++) {
		var last_updated = moment(times[idx].getAttribute('datetime'));
		times[idx].innerText = last_updated.fromNow();
	}
});
</script><?php
BeaconTemplate::FinishScript();

header('ETag: "' . $cache_key . '"');
header('Cache-Control: public, max-age=86400');
header('Last-Modified: ' . $last_modified->format('D, d M Y H:i:s') . ' GMT');

BeaconTemplate::SetTitle($article_data['title']);
BeaconTemplate::SetPageDescription($article_data['preview']);

include('inc.knowledge.php');
ShowKnowledgeContent($article_data['html'], $slug);
	
?>
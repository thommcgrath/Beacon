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
$cache_key = 'support:' . $slug;

$article_data = BeaconCache::Get($cache_key);
if (is_null($article_data)) {
	$results = $database->Query('SELECT subject, content_markdown, forward_url FROM support_articles WHERE article_slug = $1 AND published = TRUE;', $slug);
	if ($results->RecordCount() == 0) {
		echo 'Article not found';
		http_response_code(404);
		exit;
	}
	
	$article_data = array(
		'title' => $results->Field('subject')
	);
	
	if (is_null($results->Field('forward_url'))) {
		$markdown = $results->Field('content_markdown');
		$pattern = '/\!\[([^\[\]]*)\]\(([0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-4[0-9A-Fa-f]{3}-[89ABab][0-9A-Fa-f]{3}-[0-9A-Fa-f]{12})\)/';
		while (preg_match($pattern, $markdown, $matches) === 1) {
			$alt = $matches[1];
			$image_id = $matches[2];
			$match = $matches[0];
			$html = '<p class="text-center"><img class="inline" src="/help/image/' . $image_id . '" srcset="/help/image/' . $image_id . ' 1x, /help/image/' . $image_id . '@2x 2x, /help/image/' . $image_id . '@3x 3x" alt="' . htmlentities($alt) . '"></p>';
			
			$markdown = str_replace($match, $html, $markdown);
		}
		
		$parser = new Parsedown();
		$article_data['html'] = '<h1>' . htmlentities($results->Field('subject')) . '</h1>' . "\n" . $parser->text($markdown);
	} else {
		$article_data['forward'] = $results->Field('forward_url');
	}
	
	BeaconCache::Set($cache_key, $article_data, 86400);
}
if (isset($article_data['forward'])) {
	BeaconCommon::Redirect($article_data['forward'], false);
}

echo '<div id="help_article">';
echo '<div id="article_content">' . $article_data['html'] . '</div>';

BeaconTemplate::SetTitle($article_data['title']);

$results = $database->Query('SELECT support_articles.article_slug, support_articles.subject, support_articles.forward_url, support_article_groups.group_name, support_article_groups.sort_order, support_table_of_contents.sort_order FROM (support_article_groups INNER JOIN support_table_of_contents ON (support_table_of_contents.group_id = support_article_groups.group_id)) LEFT JOIN support_articles ON (support_table_of_contents.article_id = support_articles.article_id) WHERE support_articles.published = TRUE ORDER BY support_article_groups.sort_order, support_table_of_contents.sort_order, support_article_groups.group_name, support_articles.subject;');
$toc = array();
while (!$results->EOF()) {
	$group_name = $results->Field('group_name');
	$group_contents = array();
	if (array_key_exists($group_name, $toc)) {
		$group_contents = $toc[$group_name];
	}
	$group_contents[] = array(
		'slug' => $results->Field('article_slug'),
		'subject' => $results->Field('subject'),
		'forward' => $results->Field('forward_url')
	);
	$toc[$group_name] = $group_contents;
	$results->MoveNext();
}

echo '<div id="toc">';
foreach ($toc as $group_name => $group_contents) {
	echo '<p>' . htmlentities($group_name) . '</p><ul>';
	foreach ($group_contents as $article) {
		if ($article['slug'] == $slug) {
			echo '<li class="current">' . htmlentities($article['subject']) . '</li>';
		} elseif (!is_null($article['forward'])) {
			echo '<li><a href="' . $article['forward'] . '">' . htmlentities($article['subject']) . '</a></li>';
		} else {
			echo '<li><a href="/help/' . $article['slug'] . '">' . htmlentities($article['subject']) . '</a></li>';
		}
	}
	echo '</ul>';
}
echo '</div>';
echo '</div>';
	
?>
<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Content-Type: application/json');

$database = BeaconCommon::Database();
$results = $database->Query('SELECT article_id, subject, content_markdown, article_slug, publish_date, last_updated FROM blog_articles WHERE publish_date < CURRENT_TIMESTAMP ORDER BY publish_date DESC LIMIT 10;');

$feed = array(
	'version' => 'https://jsonfeed.org/version/1',
	'title' => 'Beacon Developer Blog',
	'home_page_url' => BeaconCommon::AbsoluteURL('/'),
	'feed_url' => BeaconCommon::AbsoluteURL('/blog/json.php'),
	'author' => array(
		'name' => 'Thom McGrath'
	),
	'items' => array()
);

$parser = new Parsedown();
$link_find = 'href="/';
$link_replace = 'href="' . BeaconCommon::AbsoluteURL('/');
while (!$results->EOF()) {
	$article_id = $results->Field('article_id');
	$title = $results->Field('subject');
	$publish_date = new DateTime($results->Field('publish_date'), new DateTimeZone('UTC'));
	$modified_date = new DateTime($results->Field('last_updated'), new DateTimeZone('UTC'));
	$link = BeaconCommon::AbsoluteURL('/blog/' . $results->Field('article_slug'));
	$html = str_replace($link_find, $link_replace, $parser->text($results->Field('content_markdown')));
	
	$feed['items'][] = array(
		'id' => $article_id,
		'url' => $link,
		'title' => $title,
		'content_html' => $html,
		'date_published' => $publish_date->format(DateTime::RFC3339_EXTENDED),
		'date_modified' => $modified_date->format(DateTime::RFC3339_EXTENDED)
	);
	
	$results->MoveNext();
}

echo json_encode($feed, JSON_PRETTY_PRINT);

?>
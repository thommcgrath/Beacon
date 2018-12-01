<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Content-Type: application/json');

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
$articles = BeaconArticle::GetRecentArticles(10, 0, 'Blog');
$link_find = 'href="/';
$link_replace = 'href="' . BeaconCommon::AbsoluteURL('/');
foreach ($articles as $article) {
	$html = $parser->text($article->Body());
	$html = str_replace($link_find, $link_replace, $html);
	
	$feed['items'][] = array(
		'id' => $article->ArticleID(),
		'url' => BeaconCommon::AbsoluteURL('/read.php/' . $article->ArticleID()),
		'title' => $article->Title(),
		'content_html' => $html,
		'date_published' => $article->PublishTime()->format(DateTime::RFC3339_EXTENDED),
		'date_modified' => $article->LastUpdate()->format(DateTime::RFC3339_EXTENDED)
	);
}

echo json_encode($feed, JSON_PRETTY_PRINT);

?>
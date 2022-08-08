<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Content-Type: application/rss+xml');

$database = BeaconCommon::Database();
$results = $database->Query('SELECT subject, content_markdown, article_slug, date_trunc(\'second\', publish_date::TIMESTAMP) AS publish_date FROM blog_articles WHERE publish_date < CURRENT_TIMESTAMP ORDER BY publish_date DESC LIMIT 10;');

echo '<?xml version="1.0" encoding="UTF-8"?>';

?><rss version="2.0" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:wfw="http://wellformedweb.org/CommentAPI/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:atom="http://www.w3.org/2005/Atom">
	<channel>
		<title>Beacon Developer Blog</title>
		<link><?php echo BeaconCommon::AbsoluteURL('/'); ?></link>
		<language>en</language>
		<description>News about Beacon</description>
		<atom:link href="<?php echo BeaconCommon::AbsoluteURL('/blog/rss.php'); ?>" rel="self" type="application/rss+xml" /><?php
		$parser = new Parsedown();
		$link_find = 'href="/';
		$link_replace = 'href="' . BeaconCommon::AbsoluteURL('/');
		while (!$results->EOF()) {
			$title = $results->Field('subject');
			$date = new DateTime($results->Field('publish_date'), new DateTimeZone('UTC'));
			$link = BeaconCommon::AbsoluteURL('/blog/' . $results->Field('article_slug'));
			$html = str_replace($link_find, $link_replace, $parser->text($results->Field('content_markdown')));
			
			echo "\n\t\t<item>";
			echo "\n\t\t\t<title>" . htmlentities($title) . "</title>";
			echo "\n\t\t\t<guid isPermaLink=\"true\">$link</guid>";
			echo "\n\t\t\t<link>$link</link>";
			echo "\n\t\t\t<pubDate>{$date->format('r')}</pubDate>";
			echo "\n\t\t\t<description><![CDATA[$html]]></description>";
			echo "\n\t\t</item>";
			
			$results->MoveNext();
		}
		?> 
	</channel>
</rss>
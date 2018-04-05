<?php
require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
header('Content-Type: application/rss+xml');

echo '<?xml version="1.0" encoding="UTF-8"?>';

?><rss version="2.0" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:wfw="http://wellformedweb.org/CommentAPI/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:atom="http://www.w3.org/2005/Atom">
	<channel>
		<title>Beacon Developer Blog</title>
		<link><?php echo BeaconCommon::AbsoluteURL('/'); ?></link>
		<language>en</language>
		<description>News about Beacon</description>
		<atom:link href="<?php echo BeaconCommon::AbsoluteURL('/blog/rss.php'); ?>" rel="self" type="application/rss+xml" />
		<?php
		$parser = new Parsedown();
		$articles = BeaconArticle::GetRecentArticles(10, 'Blog');
		$link_find = 'href="/';
		$link_replace = 'href="' . BeaconCommon::AbsoluteURL('/');
		foreach ($articles as $article) {
			$html = $parser->text($article->Body());
			$html = str_replace($link_find, $link_replace, $html);
			
			echo '<item>';
			echo '<title>' . htmlentities($article->Title()) . '</title>';
			echo '<guid isPermaLink="true">' . BeaconCommon::AbsoluteURL('/read.php/' . $article->ArticleID()) . '</guid>';
			echo '<link>' . BeaconCommon::AbsoluteURL('/read.php/' . $article->ArticleID()) . '</link>';
			echo '<pubDate>' . $article->PublishTime()->format('r') . '</pubDate>';
			echo '<description><![CDATA[' . $html . ']]></description>';
			echo '</item>';
		}
		?>
	</channel>
</rss>
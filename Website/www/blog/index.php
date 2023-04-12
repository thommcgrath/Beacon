<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');

$database = BeaconCommon::Database();
if (isset($_GET['slug'])) {
	$results = $database->Query('SELECT article_id, article_hash, EXTRACT(EPOCH FROM publish_date) AS publish_date_epoch, EXTRACT(EPOCH FROM last_updated) AS last_updated_epoch FROM blog_articles WHERE publish_date < CURRENT_TIMESTAMP AND article_slug = $1;', $_GET['slug']);
} else {
	$results = $database->Query('SELECT article_id, article_hash, EXTRACT(EPOCH FROM publish_date) AS publish_date_epoch, EXTRACT(EPOCH FROM last_updated) AS last_updated_epoch FROM blog_articles WHERE publish_date < CURRENT_TIMESTAMP ORDER BY publish_date DESC LIMIT 1;');
}
if ($results->RecordCount() == 0) {
	http_response_code(404);
	echo '<h1>Article not found</h1><p>Sorry about that, looks like a mistake was made somewhere. Try starting at <a href="/blog/">the blog home page</a> instead.</p>';
	exit;
}

$article_id = $results->Field('article_id');
$article_hash = $results->Field('article_hash');
$article_date = $results->Field('publish_date_epoch');
$article_update_date = $results->Field('last_updated_epoch');

// find the previous article
$results = $database->Query('SELECT article_slug, subject, preview FROM blog_articles WHERE publish_date < LEAST(CURRENT_TIMESTAMP, to_timestamp($1)) ORDER BY publish_date DESC LIMIT 1;', $article_date);
if ($results->RecordCount() == 1) {
	$previous_article = array('slug' => $results->Field('article_slug'), 'subject' => $results->Field('subject'), 'preview' => $results->Field('preview'));
} else {
	$previous_article = null;
}
$results = $database->Query('SELECT article_slug, subject, preview FROM blog_articles WHERE publish_date < CURRENT_TIMESTAMP AND publish_date > to_timestamp($1) ORDER BY publish_date ASC LIMIT 1;', $article_date);
if ($results->RecordCount() == 1) {
	$next_article = array('slug' => $results->Field('article_slug'), 'subject' => $results->Field('subject'), 'preview' => $results->Field('preview'));
} else {
	$next_article = null;
}

$article_data = BeaconCache::Get($article_hash);
if (is_null($article_data)) {
	$results = $database->Query('SELECT subject, content_markdown, preview FROM blog_articles WHERE article_id = $1;', $article_id);
	$parser = new Parsedown();
	
	$format = 'F jS, Y \a\t g:i A \U\T\C';
	$published = new DateTime('@' . $article_date);
	$headline = '<h1>' . htmlentities($results->Field('subject')) . '<br><span class="subtitle text-lighter">Published <time datetime="' . htmlentities($published->format('c')) . '">' . htmlentities($published->format($format)) . '</time>';
	if ($article_update_date - 3600 > $article_date) {
		$updated = new DateTime('@' . $article_update_date);
		$headline .= ' (Updated <time datetime="' . htmlentities($updated->format('c')) . '">' . htmlentities($updated->format($format)) . '</time>)';	
	}
	$headline .= '</span></h1>';
	
	$article_data = [
		'title' => $results->Field('subject'),
		'preview' => $results->Field('preview'),
		'published' => $article_date,
		'updated' => $article_update_date,
		'html' => $headline . "\n" . $parser->text($results->Field('content_markdown'))
	];
	
	BeaconCache::Set($article_hash, $article_data, 86400);
}

BeaconTemplate::SetTitle($article_data['title']);
BeaconTemplate::SetPageDescription($article_data['preview']);
BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('build/blog.css'));

$results = $database->Query('SELECT article_id, article_slug, subject FROM blog_articles WHERE publish_date < CURRENT_TIMESTAMP ORDER BY publish_date DESC LIMIT 10;');

?><div id="knowledge_wrapper">
	<div id="knowledge_contents">
		<p>Recent Entries</p>
		<ul>
			<?php
			
			while (!$results->EOF()) {
				if ($results->Field('article_id') == $article_id) {
					echo '<li class="current">' . htmlentities($results->Field('subject')) . '</li>';
				} else {
					echo '<li><a href="/blog/' . $results->Field('article_slug') . '">' . htmlentities($results->Field('subject')) . '</a></li>';
				}
				$results->MoveNext();
			}
				
			?>
		</ul>
		<p>Feeds</p>
		<ul>
			<li><a href="/blog/json.php">JSON Feed</a></li>
			<li><a href="/blog/rss.php">RSS Feed</a></li>
		</ul>
	</div>
	<div id="knowledge_main">
		<?php echo $article_data['html']; ?>
		<div class="navigation_footer double_column separator-color">
			<div class="previous_article column"><?php if (!is_null($previous_article)) { ?><a href="/blog/<?php echo $previous_article['slug']; ?>">&laquo; <?php echo htmlentities($previous_article['subject']); ?></a><span class="smaller text-lighter"><br><?php echo htmlentities($previous_article['preview']); ?></span><?php } else { ?>&nbsp;<?php } ?></div>
			<div class="next_article column"><?php if (!is_null($next_article)) { ?><a href="/blog/<?php echo $next_article['slug']; ?>"><?php echo htmlentities($next_article['subject']); ?> &raquo;</a><span class="smaller text-lighter"><br><?php echo htmlentities($next_article['preview']); ?></span><?php } else { ?>&nbsp;<?php } ?></div>
		</div>
	</div>
</div><?php

exit;

$per_page = 10;
$page = 1;
if (isset($_GET['page'])) {
	$page = max(intval($_GET['page']), 1);
}
$offset = ($page - 1) * $per_page;
$bound = $offset + $per_page;
$total = BeaconArticle::GetCount('Blog');
$articles = BeaconArticle::GetRecentArticles($per_page, $offset, 'Blog');

$parser = new Parsedown();
foreach ($articles as $article) {
	$html = $parser->text($article->Body());
	$html = str_replace('<table>', '<table class="generic">', $html);
	echo '<div class="article"><h1>' . htmlentities($article->Title()) . '</h1>' . $html . '</div>';
}

if ($page > 1 || $total > $bound) {
	echo '<div id="pagenav">';

	if ($page > 1) {
		echo '<div id="pagenav-newer"><a href="?page=' . ($page - 1) . '">&laquo; Newer</a></div>';
	} else {
		echo '<div id="pagenav-newer">&laquo; Newer</div>';
	}
	
	echo '<div id="pagenav-current">Page ' . $page . '</div>';
	
	if ($total > $bound) {
		echo '<div id="pagenav-older"><a href="?page=' . ($page + 1) . '">Older &raquo;</a></div>';
	} else {
		echo '<div id="pagenav-older">Older &raquo;</div>';
	}
	
	echo '</div>';
}

?>
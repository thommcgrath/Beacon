<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');

$database = BeaconCommon::Database();
if (isset($_GET['slug'])) {
	$results = $database->Query('SELECT article_id, article_hash, publish_date FROM blog_articles WHERE publish_date < CURRENT_TIMESTAMP AND article_slug = $1;', $_GET['slug']);
} else {
	$results = $database->Query('SELECT article_id, article_hash, publish_date FROM blog_articles WHERE publish_date < CURRENT_TIMESTAMP ORDER BY publish_date DESC LIMIT 1;');
}
if ($results->RecordCount() == 0) {
	http_response_code(404);
	echo '<h1>Article not found</h1><p>Sorry about that, looks like a mistake was made somewhere. Try starting at <a href="/blog/">the blog home page</a> instead.</p>';
	exit;
}

$article_id = $results->Field('article_id');
$article_hash = $results->Field('article_hash');
$article_date = $results->Field('publish_date');

// find the previous article
$results = $database->Query('SELECT article_slug, subject, preview FROM blog_articles WHERE publish_date < LEAST(CURRENT_TIMESTAMP, $1) ORDER BY publish_date DESC LIMIT 1;', $article_date);
if ($results->RecordCount() == 1) {
	$previous_article = array('slug' => $results->Field('article_slug'), 'subject' => $results->Field('subject'), 'preview' => $results->Field('preview'));
} else {
	$previous_article = null;
}
$results = $database->Query('SELECT article_slug, subject, preview FROM blog_articles WHERE publish_date < CURRENT_TIMESTAMP AND publish_date > $1 ORDER BY publish_date ASC LIMIT 1;', $article_date);
if ($results->RecordCount() == 1) {
	$next_article = array('slug' => $results->Field('article_slug'), 'subject' => $results->Field('subject'), 'preview' => $results->Field('preview'));
} else {
	$next_article = null;
}

$article_data = BeaconCache::Get($article_hash);
if (is_null($article_data)) {
	$results = $database->Query('SELECT subject, content_markdown, preview FROM blog_articles WHERE article_id = $1;', $article_id);
	$parser = new Parsedown();
	
	$article_data = array(
		'title' => $results->Field('subject'),
		'preview' => $results->Field('preview'),
		'html' => '<h1>' . htmlentities($results->Field('subject')) . '</h1>' . "\n" . $parser->text($results->Field('content_markdown'))
	);
	
	BeaconCache::Set($article_hash, $article_data, 86400);
}

BeaconTemplate::SetTitle($article_data['title']);
BeaconTemplate::SetPageDescription($article_data['preview']);

BeaconTemplate::StartStyles(); ?>
<style>

.next_article, .previous_article {
	text-align: center;
}

.navigation_footer {
	line-height: 1.0em;
	border-top-width: 1px;
	border-top-style: solid;
	margin-top: 30px;
}

@media (min-width: 840px) {
	.next_article {
		text-align: right;
	}
	
	.previous_article {
		text-align: left;
	}
}

</style>
<?php
BeaconTemplate::FinishStyles();

$results = $database->Query('SELECT article_id, article_slug, subject FROM blog_articles WHERE publish_date < CURRENT_TIMESTAMP ORDER BY publish_date DESC LIMIT 10;');

?><div id="help_article">
	<div id="article_content">
		<?php echo $article_data['html']; ?>
		<div class="navigation_footer double_column separator-color">
			<div class="previous_article column"><?php if (!is_null($previous_article)) { ?><a href="/blog/<?php echo $previous_article['slug']; ?>">&laquo; <?php echo htmlentities($previous_article['subject']); ?></a><span class="smaller text-lighter"><br><?php echo htmlentities($previous_article['preview']); ?></span><?php } else { ?>&nbsp;<?php } ?></div>
			<div class="next_article column"><?php if (!is_null($next_article)) { ?><a href="/blog/<?php echo $next_article['slug']; ?>"><?php echo htmlentities($next_article['subject']); ?> &raquo;</a><span class="smaller text-lighter"><br><?php echo htmlentities($next_article['preview']); ?></span><?php } else { ?>&nbsp;<?php } ?></div>
		</div>
	</div>
	<div id="toc">
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
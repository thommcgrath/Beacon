<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
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
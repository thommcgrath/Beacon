<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$article_id = isset($_GET['id']) ? $_GET['id'] : '';
if (!BeaconCommon::IsUUID($article_id)) {
	http_response_code(400);
	echo 'Malformed article id';
	exit;
}

$article = BeaconArticle::GetByArticleID($article_id);
if (is_null($article)) {
	http_response_code(404);
	echo 'Article not found.';
	exit;
}

BeaconTemplate::SetTitle($article->Title());

?><div class="article"><h1><?php echo htmlentities($article->Title()); ?></h1>
<?php

$parser = new Parsedown();
$html = $parser->text($article->Body());
$html = str_replace('<table>', '<table class="generic">', $html);

echo $html;

?></div>
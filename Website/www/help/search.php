<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

if (!isset($_GET['query'])) {
	BeaconCommon::Redirect('/help/');
	exit;
}

$terms = $_GET['query'];
$query = preg_replace('/[^a-z ]/', '', strtolower($terms));
$query = preg_replace('/\s+/', ' | ', trim($query));
$query = preg_replace('/(\w+)/', '$1:*', $query);
$database = BeaconCommon::Database();

BeaconTemplate::SetTitle('Help: ' . $terms);

$build_number = 0;
$builds = $database->Query("SELECT build_number FROM updates WHERE stage >= 3 ORDER BY build_number DESC LIMIT 1;");
if ($builds->RecordCount() == 1) {
	$build_number = intval($builds->Field('build_number'));
}

$results = $database->Query('SELECT support_articles.subject, support_articles.preview, search_contents.uri, ts_rank(lexemes, keywords) AS rank FROM search_contents INNER JOIN support_articles ON (search_contents.id = support_articles.article_id), to_tsquery($1) AS keywords WHERE type = \'Help\' AND keywords @@ lexemes AND min_version <= $2 ORDER BY rank DESC, title ASC;', $query, $build_number);
if ($results->RecordCount() == 0) {
	echo '<h1>No Results</h1><p>Could not find anything for &quot;' . htmlentities($terms) . '&quot;</p>';
	exit;
}

BeaconTemplate::StartStyles(); ?>
<style>

div.support_result {
	border-width: 1px;
	border-style: solid;
	padding: 15px;
	border-radius: 8px;
	margin-top: 15px;
	margin-bottom: 15px;
}

</style>
<?php
BeaconTemplate::FinishStyles();

echo '<h1>Search Results for &quot;' . htmlentities($terms) . '&quot;</h1>';

while (!$results->EOF()) {
	?>
	<div class="support_result separator-color">
		<h3><a href="<?php echo $results->Field('uri'); ?>"><?php echo htmlentities($results->Field('subject')); ?></a></h3>
		<p><?php echo htmlentities($results->Field('preview')); ?></p>
	</div><?php
	
	$results->MoveNext();
}

?>
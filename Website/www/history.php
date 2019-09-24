<?php
require(dirname(__FILE__, 2) . '/framework/loader.php');
$stage = isset($_GET['stage']) ? intval($_GET['stage']) : 3;

if (is_null(filter_var($stage, FILTER_VALIDATE_INT, ['options' => ['min_range' => -2147483648, 'max_range' => 2147483647], 'flags' => FILTER_NULL_ON_FAILURE]))) {
	header('Location: https://www.youtube.com/watch?v=dQw4w9WgXcQ');
	http_response_code(302);
	exit;
}

BeaconTemplate::SetTitle('Version History');
?><h1>Version History</h1>
<div class="indent">
	<?php
	
	$results = BeaconCommon::Database()->Query('SELECT build_number, build_display, notes FROM updates WHERE stage >= $1 ORDER BY build_number DESC;', $stage);
	$parser = new Parsedown();
	$body = '';
	while (!$results->EOF()) {
		$body = trim("$body\n<h2 id=\"build" . $results->Field('build_number') . "\">" . $results->Field('build_display') . "</h2>\n<div class=\"indent\">\n" . $parser->text($results->Field('notes')) . "\n</div>");
		$results->MoveNext();
	}
	
	echo $body;
	
	?>
</div>

<?php
require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
$stage = isset($_GET['stage']) ? intval($_GET['stage']) : 3;
BeaconTemplate::SetTitle('Version History');
?><h1>Version History</h1>
<div class="indent">
	<?php
	
	$results = BeaconCommon::Database()->Query('SELECT build_number, build_display, notes FROM updates WHERE stage >= $1 ORDER BY build_number DESC;', $stage);
	$parser = new Parsedown();
	$body = '';
	while (!$results->EOF()) {
		$body = trim("$body\n<h2 id=\"build" . $results->Field('build_number') . "\">" . $results->Field('build_display') . " (Build " . $results->Field('build_number') . ")</h2>\n<div class=\"indent\">\n" . $parser->text($results->Field('notes')) . "\n</div>");
		$results->MoveNext();
	}
	
	echo $body;
	
	?>
</div>
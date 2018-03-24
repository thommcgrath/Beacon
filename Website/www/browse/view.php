<?php

if (empty($_GET['document_id'])) {
	header('Location: /browse/');
	exit;
}

require($_SERVER['SITE_ROOT'] . '/framework/loader.php');

$document_id = $_GET['document_id'];
$search_keys = array(
	'public' => true,
	'document_id' => $document_id
);
	

$documents = BeaconDocumentMetadata::Search($search_keys);
if (count($documents) != 1) {
	http_response_code(404);
	BeaconTemplate::SetTitle('Document Not Found');
	echo '<h1>Document not found</h1><p><a href="/browse/">Browse community documents</a></p>';
	exit;
}

$document = $documents[0];

$map_filter = $document->MapMask();
if (array_key_exists('map_filter', $_GET)) {
	$map_filter = intval($_GET['map_filter']);
}

BeaconTemplate::SetTitle($document->Name());
BeaconTemplate::AddStylesheet('/assets/css/generator.css');
BeaconTemplate::AddHeaderLine('<script src="/assets/scripts/generator.js"></script>');

?><h1><?php echo htmlentities($document->Name()); ?></h1>
<h3>Description</h3>
<div class="indent">
	<p><?php echo htmlentities($document->Description()); ?></p>
</div>
<h3>Supported Maps</h3>
<div class="indent">
	<p><?php
$map_names = BeaconMaps::Names($document->MapMask());
if (count($map_names) >= 3) {
	$last = array_pop($map_names);
	echo implode(', ', $map_names) . ', and ' . $last;
	$map_names[] = $last;
} elseif (count($map_names) == 2) {
	echo $map_names[0] . ' and ' . $map_names[1];
} else {
	echo $map_names[0];
}
?></p>
</div>
<h3>Download</h3>
<div class="indent">
	<p><a href="<?php echo $document->ResourceURL(); ?>">Download original document</a> or <a href="<?php echo str_replace('https://', 'beacon://', $document->ResourceURL()); ?>">Open document in Beacon</a></p>
</div>
<h3>Create Game.ini</h3>
<div class="indent">
	<p>Create a customized Game.ini from this document.</p>
	<div id="mode_tabs"><div id="mode_tabs_new" class="selected">Create New</div><div id="mode_tabs_paste">Paste Text</div><div id="mode_tabs_upload">Upload File</div></div>
	<div id="mode_customizations">
		<p>Settings<input type="hidden" id="map_mask" name="map_mask" value="<?php echo ($map_filter & $document->MapMask()); ?>"></p>
		<?php if (count($map_names) > 1) { ?><p>Include Maps:<?php
		
		foreach ($map_names as $name) {
			$value = BeaconMaps::ValueForName($name);
			$id = 'map_check_' . $value;
			echo ' <input id="' . $id . '" type="checkbox" value="' . $value . '"' . (($map_filter & $value) == $value ? ' checked' : '') . '> <label for="' . $id . '">' . htmlentities($name) . '</label>';
		}
		
		?></p><?php } ?>
		<p><label for="dino_level_field">Max Dino Level:</label> <input type="number" id="dino_level_field" value="120"></p>
		<p><label for="difficulty_reference">Required Difficulty Settings:</label> <textarea readonly rows="2" id="difficulty_reference"></textarea><br><span class="smaller">This space is merely a reference. These options will produce the desired dino level. Loot will be scaled accordingly.</span></p>
	</div>
	<div id="mode_view">
		<div id="mode_view_new">
			<p>This option creates a new Game.ini from scratch. Use this if your server has no customizations.</p>
			<form action="generate.php" method="get">
				<input type="hidden" name="document_id" value="<?php echo htmlentities($document->DocumentID()); ?>">
				<input type="hidden" name="difficulty_value" value="" id="create_difficulty_value">
				<p class="text-center"><input type="radio" name="mode" value="inline" id="create_inline_check" checked> <label for="create_inline_check">Show new Game.ini in browser</label><br><input type="radio" name="mode" value="download" id="create_download_check"> <label for="create_download_check">Download new Game.ini</label></p>
				<p class="text-center"><input type="submit" value="Generate"></p>
			</form>
		</div>
		<div id="mode_view_paste">
			<p>Paste your current Game.ini here and a customized version will be produced for you.</p>
			<form action="generate.php" method="post">
				<input type="hidden" name="document_id" value="<?php echo htmlentities($document->DocumentID()); ?>">
				<input type="hidden" name="mode" value="inline">
				<input type="hidden" name="difficulty_value" value="" id="paste_difficulty_value">
				<textarea name="content" rows="20" wrap="off"></textarea>
				<p class="text-center"><input type="submit" value="Generate"></p>
			</form>
		</div>
		<div id="mode_view_upload">
			<p>Upload your current Game.ini to download a customized version.</p>
			<form action="generate.php" method="post" enctype="multipart/form-data">
				<input type="hidden" name="document_id" value="<?php echo htmlentities($document->DocumentID()); ?>">
				<input type="hidden" name="mode" value="download">
				<input type="hidden" name="difficulty_value" value="" id="upload_difficulty_value">
				<input type="file" name="content" accept=".ini">
				<p class="text-center"><input type="submit" value="Generate"></p>
			</form>
		</div>
	</div>
</div>
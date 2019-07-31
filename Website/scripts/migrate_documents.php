#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$database = BeaconCommon::Database();
do {
	$results = $database->Query('SELECT document_id, user_id, contents FROM documents WHERE contents IS NOT NULL ORDER BY last_update ASC LIMIT 1;');
	if ($results->RecordCount() == 0) {
		echo "Finished\n";
		exit;
	}
	$reason = '';
	$document_id = $results->Field('document_id');
	if (BeaconDocument::SaveFromContent($document_id, $results->Field('user_id'), $results->Field('contents'), $reason, true) === false) {
		if ($reason == 'Version 1 documents are no longer not accepted.') {
			// Nothing can happen with this.
			$database->BeginTransaction();
			$database->Query('DELETE FROM documents WHERE document_id = $1;', $document_id);
			$database->Commit();
			echo "Document $document_id was deleted from the database because it is too old.\n";
		} else {
			echo "Unable to save document $document_id: $reason\n";
			exit;
		}
	} else {
		echo "Migrated $document_id\n";
	}
} while (true);

?>
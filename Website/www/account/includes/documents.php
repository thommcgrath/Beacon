<?php
BeaconTemplate::StartScript(); ?>
<script>
document.addEventListener('DOMContentLoaded', function(event) {
	var delete_buttons = document.querySelectorAll('[beacon-action="delete"]');
	for (var i = 0; i < delete_buttons.length; i++) {
		var button = delete_buttons[i];
		button.addEventListener('click', function(event) {
			event.preventDefault();
			
			var resource_url = this.getAttribute('beacon-resource-url');
			var resource_name = this.getAttribute('beacon-resource-name');
			
			dialog.confirm('Are you sure you want to delete the document "' + resource_name + '?"', 'The document will be deleted immediately and cannot be recovered.', 'Delete', 'Cancel', function() {
				request.start('DELETE', resource_url, '', '', function(obj) {
					dialog.show('Document deleted', '"' + resource_name + '" has been deleted.', function() {
						window.location.reload(true);
					});
				}, function(http_status) {
					switch (http_status) {
					case 401:
						dialog.show('Document not deleted', 'There was an authentication error');
						break;
					default:
						dialog.show('Document not deleted', 'Sorry, there was a ' + http_status + ' error.');
						break;
					}
				}, {'Authorization': <?php echo json_encode('Session ' . $session->SessionID()); ?>});
			});
			
			return false;
		});
	}
});
</script>
<?php
BeaconTemplate::FinishScript();

$keys = array(
	'user_id' => $user->UserID()
);
$documents = BeaconDocumentMetadata::Search($keys);
if (count($documents) > 0) {
	echo '<table class="generic">';
	echo '<thead><tr><th>Name</th><th>Downloads</th><th>Revision</th><th class="text-center">Published</th><th>Delete</th></tr></thead>';
	foreach ($documents as $document) {
		$status = $document->PublishStatus();
		switch ($status) {
		case BeaconDocument::PUBLISH_STATUS_PRIVATE:
		case BeaconDocument::PUBLISH_STATUS_DENIED:
		case BeaconDocument::PUBLISH_STATUS_APPROVED_PRIVATE:
			$status = 'No';
			break;
		case BeaconDocument::PUBLISH_STATUS_REQUESTED:
			$status = "Pending";
			break;
		case BeaconDocument::PUBLISH_STATUS_APPROVED:
			$status = 'Yes';
			break;
		}
		
		echo '<tr>';
		echo '<td><a href="' . htmlentities($document->ResourceURL()) . '">' . htmlentities($document->Name()) . '</a><br><span class="document_description">' . htmlentities($document->Description()) . '</span></td>';
		echo '<td class="text-right nowrap">' . number_format($document->DownloadCount()) . '</td>';
		echo '<td class="text-right nowrap">' . number_format($document->Revision()) . '</td>';
		echo '<td class="text-center nowrap">' . nl2br(htmlentities($status)) . '</td>';
		echo '<td class="nowrap"><a href="delete/' . htmlentities($document->DocumentID()) . '" beacon-action="delete" beacon-resource-name="' . htmlentities($document->Name()) .'" beacon-resource-url="' . htmlentities($document->ResourceURL()) . '">Delete</a></td>';
		echo '</tr>';
	}
	echo '</table>';
} else {
	echo '<div class="small_section"><p>You have not created any documents yet!<span class="text-lighter smaller"><br>(Or at least haven\'t saved any to Beacon\'s Cloud.)</span></p></div>';
}

?>
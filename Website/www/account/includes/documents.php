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
			
			dialog.confirm('Are you sure you want to delete the project "' + resource_name + '?"', 'The project will be deleted immediately and cannot be recovered.', 'Delete', 'Cancel', function() {
				request.start('DELETE', resource_url, '', '', function(obj) {
					dialog.show('Project deleted', '"' + resource_name + '" has been deleted.', function() {
						window.location.reload(true);
					});
				}, function(http_status) {
					switch (http_status) {
					case 401:
						dialog.show('Project not deleted', 'There was an authentication error');
						break;
					default:
						dialog.show('Project not deleted', 'Sorry, there was a ' + http_status + ' error.');
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
$projects = \Ark\Project::Search($keys);
if (count($projects) > 0) {
	echo '<table class="generic">';
	echo '<thead><tr><th>Name</th><th class="low-priority">Downloads</th><th class="low-priority">Revision</th><th class="text-center low-priority">Published</th><th class="low-priority">Delete</th></tr></thead>';
	foreach ($projects as $project) {
		$status = $project->PublishStatus();
		switch ($status) {
		case Ark\Project::PUBLISH_STATUS_PRIVATE:
		case Ark\Project::PUBLISH_STATUS_DENIED:
		case Ark\Project::PUBLISH_STATUS_APPROVED_PRIVATE:
			$status = 'No';
			break;
		case Ark\Project::PUBLISH_STATUS_REQUESTED:
			$status = "Pending";
			break;
		case Ark\Project::PUBLISH_STATUS_APPROVED:
			$status = 'Yes';
			break;
		}
		
		$delete_link = '<a href="delete/' . htmlentities($project->ProjectID()) . '" beacon-action="delete" beacon-resource-name="' . htmlentities($project->Title()) .'" beacon-resource-url="' . htmlentities($project->ResourceURL()) . '">Delete</a>';
		$details = array(
			'Downloads: ' . number_format($project->DownloadCount()),
			'Revision: ' . number_format($project->Revision()),
			$delete_link
		);
		
		echo '<tr>';
		echo '<td><a href="' . htmlentities($project->ResourceURL()) . '">' . htmlentities($project->Title()) . '</a><br><span class="document_description">' . htmlentities($project->Description()) . '</span><div class="row-details"><span class="detail">' . implode('</span><span class="detail">', $details) . '</span></div></td>';
		echo '<td class="low-priority text-right nowrap">' . number_format($project->DownloadCount()) . '</td>';
		echo '<td class="low-priority text-right nowrap">' . number_format($project->Revision()) . '</td>';
		echo '<td class="low-priority text-center nowrap">' . nl2br(htmlentities($status)) . '</td>';
		echo '<td class="low-priority nowrap">' . $delete_link . '</td>';
		echo '</tr>';
	}
	echo '</table>';
} else {
	echo '<div class="small_section"><p>You have not created any projects yet!<span class="text-lighter smaller"><br>(Or at least haven\'t saved any to Beacon\'s Cloud.)</span></p></div>';
}

?>
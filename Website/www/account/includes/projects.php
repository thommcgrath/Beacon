<?php

use BeaconAPI\v4\Project;

echo '<div class="visual-group"><h3>Your Projects</h3>';

$keys = [
	'userId' => $user->UserId()
];
$projects = Project::Search($keys, true);
if (count($projects) > 0) {
	echo '<table class="generic">';
	echo '<thead><tr><th>Name</th><th class="low-priority">Game</th><th class="low-priority">Downloads</th><th class="low-priority">Revision</th><th class="text-center low-priority">Published</th><th class="low-priority">Delete</th></tr></thead>';
	foreach ($projects as $project) {
		$status = $project->PublishStatus();
		switch ($status) {
		case Project::kPublishStatusPrivate:
		case Project::kPublishStatusDenied:
		case Project::kPublishStatusApprovedPrivate:
			$status = 'No';
			break;
		case Project::kPublishStatusRequested:
			$status = "Pending";
			break;
		case Project::kPublishStatusApproved:
			$status = 'Yes';
			break;
		}

		$projectUrl = 'beacon://' . BeaconCommon::APIDomain() . '/v4/projects/' . urlencode($project->ProjectId()) . '?name=' . urlencode($project->Title());

		$delete_link = '<a href="delete/' . htmlentities($project->ProjectId()) . '" beacon-action="delete" beacon-resource-name="' . htmlentities($project->Title()) .'" beacon-resource-url="' . htmlentities($projectUrl) . '">Delete</a>';
		$details = [
			'Game: ' . htmlentities($project->GameName()),
			'Downloads: ' . number_format($project->DownloadCount()),
			'Revision: ' . number_format($project->Revision()),
			$delete_link,
		];

		echo '<tr>';
		echo '<td><a href="' . htmlentities($projectUrl) . '">' . htmlentities($project->Title()) . '</a><br><span class="document_description">' . htmlentities($project->Description()) . '</span><div class="row-details"><span class="detail">' . implode('</span><span class="detail">', $details) . '</span></div></td>';
		echo '<td class="low-priority text-left nowrap">' . htmlentities($project->GameName()) . '</td>';
		echo '<td class="low-priority text-right nowrap">' . number_format($project->DownloadCount()) . '</td>';
		echo '<td class="low-priority text-right nowrap">' . number_format($project->Revision()) . '</td>';
		echo '<td class="low-priority text-center nowrap">' . nl2br(htmlentities($status)) . '</td>';
		echo '<td class="low-priority nowrap">' . $delete_link . '</td>';
		echo '</tr>';
	}
	echo '</table>';
} else {
	echo '<p>You have not created any projects yet!<span class="text-lighter smaller"><br>(Or at least haven\'t saved any to Beacon\'s Cloud.)</span></p>';
}

echo '</div>';

?>

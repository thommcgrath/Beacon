<?php

use BeaconAPI\v4\{Application, Core};

?><div class="visual-group">
	<h3>Beacon Applications</h3>
	<p>Developers, register for Beacon API access here.</p>
	<?php
	
	$apps = Application::Search(['userId' => $user->UserId()], true);
	if (count($apps) > 0) {
		echo '<table class="generic">';
		echo '<thead>';
		echo '<tr><th>&nbsp;</th><th class="w-100">App Name</th><th>&nbsp;</th></tr>';
		echo '</thead>';
		echo '<tbody>';
		
		foreach ($apps as $app) {
			echo '<tr><td>' . $app->IconHtml(32) . '</td><td>' . htmlentities($app->Name()) . '</td><td><button class="apps-edit-button" beacon-app-id="' . htmlentities($app->ApplicationId()) . '">Edit</button></td></tr>';
		}
		
		echo '</tbody>';
		echo '</table>';
		
		echo '<p class="text-right"><button class="blue" id="apps-create-button">Add Application</button></p>';
	} else {
		echo '<p class="text-center"><button class="blue" id="apps-create-button">Add Application</button></p>';
	}
	
	?>
</div>
<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$project_id = $context['path_parameters']['project_id'];
	if (\BeaconCommon::IsUUID($project_id) === false) {
		BeaconAPI::ReplyError('Specify one project by UUID.', null, 400);
	}
	
	$user_id = BeaconAPI::UserID();
	$success = false;
	$database = \BeaconCommon::Database();
	
	try {
		$results = $database->Query('SELECT role FROM project_members WHERE project_id = $1 AND user_id = $2;', $project_id, $user_id);
		if ($results->RecordCount() !== 1) {
			BeaconAPI::ReplyError('Project not found.', null, 404);
		}
		
		$role = $results->Field('role');
		
		if ($role === 'Owner') {
			$rows = $database->Query('SELECT user_id FROM public.project_members WHERE project_id = $1 AND user_id != $2 ORDER BY public.project_role_permissions(role) DESC LIMIT 1;', $project_id, $user_id);
			if ($rows->RecordCount() === 1) {
				// Move ownership
				$newUserId = $rows->Field('user_id');
				$database->BeginTransaction();
				$database->Query('DELETE FROM public.project_members WHERE project_id = $1 AND user_id = $2;', $project_id, $user_id);
				$database->Query('UPDATE public.project_members SET role = $3 WHERE project_id = $1 AND user_id = $2;', $project_id, $newUserId, 'Owner');
				$database->Commit();
			} else {
				// The project has no other members, so delete it. Do no remove the project member row in case it has to be restored.
				$database->BeginTransaction();
				$database->Query('UPDATE public.projects SET deleted = TRUE WHERE project_id = $1;', $project_id);
				$database->Commit();
			}
		} else {
			// Remove the user from the project
			$database->BeginTransaction();
			$database->Query('DELETE FROM public.project_members WHERE project_id = $1 AND user_id = $2;', $project_id, $user_id);
			$database->Commit();
		}
		
		$success = true;
	} catch (Exception $e) {
	}
	
	if ($success) {
		BeaconAPI::ReplySuccess();
	} else {
		BeaconAPI::ReplyError('No project was deleted.');
	}
}

?>
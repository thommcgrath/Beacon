<?php

include(dirname(__FILE__) . '/loader.php');

if (RequestMethod() != 'POST') {
	Finish(400, 'Must use POST request');
}

$session = BeaconSession::GetFromCookie();
if (is_null($session)) {
	Finish(403, 'Unauthorized');
}

$object = RequestBody();
try {
	$object = json_decode($object, true);
} catch (Exception $e) {
}
if (is_array($object) === false) {
	Finish(400, 'Send JSON next time');
}

if (array_key_exists('action', $object) === false) {
	Finish(400, 'Missing action parameter');
}

$parent_user = $session->User();

try {
	switch(strtolower($object['action'])) {
	case 'create':
		if ($parent_user->CanAddChildAccount() === false) {
			Finish(400, 'Cannot add more members');
		}
		if (empty($object['password'])) {
			Finish(400, 'Missing password parameter');
		}
		if (empty($object['email'])) {
			Finish(400, 'Missing email parameter');
		}
		if (BeaconUser::ValidateEmail($object['email']) === false) {
			Finish(400, 'Email address is not valid');
		}
		$child = BeaconUser::GetByEmail($object['email']);
		if (is_null($child) === false) {
			Finish(400, 'User already exists');
		}
		unset($child);
		if (empty($object['username'])) {
			Finish(400, 'Missing username parameter');
		}
		$private_key = $parent_user->DecryptedPrivateKey($object['password']);
		if (is_null($private_key)) {
			Finish(400, 'Incorrect password');
		}
		$usercloud_key = $parent_user->DecryptedUsercloudKey($private_key);
		
		$child = new BeaconUser();
		$child->SetParentAccountID($parent_user->UserID());
		$child_password = BeaconCommon::GenerateUUID();
		if ($child->AddAuthentication($object['username'], $object['email'], $child_password, $private_key) === false) {
			Finish(400, 'Unable to add authentication to new user');
		}
		$child->SetDecryptedUsercloudKey($usercloud_key);
		$child->SetRequiresPasswordChange(true);
		if ($child->Commit() && BeaconLogin::SendTeamWelcome($object['email'], $child_password, $parent_user->Username())) {
			Finish(200, 'User created', ['user_id' => $child->UserID()]);
		} else {
			Finish(400, 'Unable to create user');
		}
		
		break;
	case 'reset':
		if (empty($object['email'])) {
			Finish(400, 'Missing email parameter');
		}
		if (BeaconUser::ValidateEmail($object['email']) === false) {
			Finish(400, 'Email address is not valid');
		}
		if (empty($object['password'])) {
			Finish(400, 'Missing password parameter');
		}
		
		$child = BeaconUser::GetByEmail($object['email']);
		if (is_null($child) || $child->ParentAccountID() != $parent_user->UserID()) {
			Finish(400, 'Unknown team member');
		}
		
		$private_key = $parent_user->DecryptedPrivateKey($object['password']);
		if (is_null($private_key)) {
			Finish(400, 'Incorrect password');
		}
		$usercloud_key = $parent_user->DecryptedUsercloudKey($private_key);
		
		$child_password = BeaconCommon::GenerateUUID();
		$temp = [];
		if ($child->ReplacePassword($child_password, $private_key, $usercloud_key, $temp) && $child->Commit() && BeaconLogin::SendForcedPasswordChangeEmail($object['email'], $child_password)) {
			Finish(200, 'Password changed', ['user_id' => $child->UserID()]);
		} else {
			Finish(400, 'Unable to replace password team account password');
		}
		
		break;
	case 'disable':
		if (empty($object['child_id'])) {
			Finish(400, 'Missing child_id parameter');
		}
		$child_id = $object['child_id'];
		$child = BeaconUser::GetByUserID($child_id);
		if (is_null($child) || $child->ParentAccountID() != $parent_user->UserID()) {
			Finish(400, 'Unknown team member');
		}
		
		$child->SetIsEnabled(false);
		if ($child->Commit()) {
			Finish(200, 'Team member account has been disabled', ['user_id' => $child->UserID()]);
		} else {
			Finish(400, 'Could not disable team member account');
		}
		
		break;
	case 'enable':
		if (empty($object['child_id'])) {
			Finish(400, 'Missing child_id parameter');
		}
		$child_id = $object['child_id'];
		$child = BeaconUser::GetByUserID($child_id);
		if (is_null($child) || $child->ParentAccountID() != $parent_user->UserID()) {
			Finish(400, 'Unknown team member');
		}
		
		$child->SetIsEnabled(true);
		if ($child->Commit()) {
			Finish(200, 'Team member account has been enabled', ['user_id' => $child->UserID()]);
		} else {
			Finish(400, 'Could not enable team member account');
		}
		
		break;
	case 'delete':
		if (empty($object['child_id'])) {
			Finish(400, 'Missing child_id parameter');
		}
		$child_id = $object['child_id'];
		$child = BeaconUser::GetByUserID($child_id);
		if (is_null($child) || $child->ParentAccountID() != $parent_user->UserID()) {
			Finish(400, 'Unknown team member');
		}
		
		if ($child->IsEnabled()) {
			Finish(400, 'Cannot delete a team member account until it has been disabled');
		}
		
		if ($child->Delete()) {
			Finish(200, 'Team member account has been deleted');
		} else {
			Finish(400, 'Could not delete team member account');
		}
		
		break;
	default:
		Finish(400, 'Unknown action parameter');
	}
} catch (Exception $e) {
	Finish(500, 'Internal server error');
}

?>
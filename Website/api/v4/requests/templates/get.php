<?php

function handle_request(array $context): void {
	$template_id = $context['path_parameters']['template_id'];
	$template = BeaconAPI\Template::GetByObjectID($template_id, \BeaconCommon::MinVersion());
	if (is_null($template)) {
		BeaconAPI::ReplyError('Template not found', null, 404);
	} else {
		BeaconAPI::ReplySuccess($template);
	}
}

?>
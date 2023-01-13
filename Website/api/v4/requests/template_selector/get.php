<?php

function handle_request(array $context): void {
	$selector_id = $context['path_parameters']['selector_id'];
	$selector = BeaconAPI\TemplateSelector::GetByObjectID($selector_id, \BeaconCommon::MinVersion());
	if (is_null($selector)) {
		BeaconAPI::ReplyError('Template selector not found', null, 404);
	} else {
		BeaconAPI::ReplySuccess($selector);
	}
}

?>
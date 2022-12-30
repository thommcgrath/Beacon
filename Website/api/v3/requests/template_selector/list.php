<?php

function handle_request(array $context): void {
	$selectors = BeaconAPI\TemplateSelector::GetAll(\BeaconCommon::MinVersion());
	BeaconAPI::ReplySuccess($selectors);
}

?>
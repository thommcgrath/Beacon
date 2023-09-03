<?php

BeaconAPI::Authorize();
	
function handleRequest(array $context): Response {
	$user_id = BeaconAPI::UserID();
	$service_id = $context['pathParameters']['service_id'];
	$service = Sentinel\Service::GetByServiceID($service_id);
	if (is_null($service) || $service->HasPermission($user_id, Sentinel\Service::PermissionView) === false) {
		BeaconAPI::ReplyError('Service not found.', null, 404);
	}
	
	$filters = [];
	$whitelist = ['query', 'message_type', 'event_type', 'min_level', 'max_level', 'newer_than', 'older_than'];
	foreach ($whitelist as $filter_key) {
		if (isset($_GET[$filter_key])) {
			$filters[$filter_key] = trim($_GET[$filter_key]);
		}
	}
	
	$newest_first = isset($_GET['newest_first']) ? filter_var($_GET['newest_first'], FILTER_VALIDATE_BOOLEAN) : true;
	$page_size = isset($_GET['page_size']) ? intval($_GET['page_size']) : 250;
	$page_num = isset($_GET['page_num']) ? intval($_GET['page_num']) : 1;
		
	$logs = Sentinel\LogMessage::Search($service_id, $filters, $newest_first, $page_num, $page_size);
	BeaconAPI::ReplySuccess($logs);
}

?>

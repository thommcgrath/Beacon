<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
	$service_id = $context['path_parameters']['service_id'];
	$service = Sentinel\Service::GetByServiceID($service_id);
	if (is_null($service) || $service->HasPermission($user_id, Sentinel\Service::PermissionView) === false) {
		BeaconAPI::ReplyError('Service not found.', null, 404);
	}
	
	$query = isset($_GET['query']) ? $_GET['query'] : '';
	$newest_first = isset($_GET['newest_first']) ? filter_var($_GET['newest_first'], FILTER_VALIDATE_BOOLEAN) : true;
	$page_size = isset($_GET['page_size']) ? intval($_GET['page_size']) : 250;
	$page_num = isset($_GET['page_num']) ? intval($_GET['page_num']) : 1;
		
	$logs = Sentinel\LogMessage::Search($service_id, $query, $newest_first, $page_num, $page_size);
	BeaconAPI::ReplySuccess($logs);
}

?>

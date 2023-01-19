<?php

use BeaconAPI\v4\{APIResponse, Core, Project, User};

function handle_request(array $context): APIResponse {
	$database = BeaconCommon::Database();
	$user_id = Core::Authenticated() ? Core::UserId() : null;
	
	$public_only = true;
	$filters = $_GET;
	if ($context['route_key'] === 'GET /users/{userId}/projects') {
		$filters['user_id'] = $context['path_parameters']['userId'];
		if ($context['path_parameters']['userId'] === $user_id) {
			$public_only = false;
		}
	}
	if ($public_only) {
		$filters['published'] = 'Approved';	
	}
	
	$results = Project::Search($filters);
	return APIResponse::NewJSON($results, 200);
	
	/*$params = [];
	$clauses = [];
	if ($context['route_key'] === 'GET /users/{userId/projects') {
		$clauses[] = 'user_id = ::limit_user_id::';
		$params['limit_user_id'] = $context['path_parameters']['userId'];
	}
	if (isset($user_id)) {
		$clauses[] = '(user_id = ::current_user_id:: OR (published = \'Approved\' AND role = \'Owner\'))';
		$params['current_user_id'] = $user_id;
	} else {
		$clauses[] = 'published = \'Approved\' AND role = \'Owner\'';
	}
	if (isset($_GET['console_only'])) {
		$clauses[] = 'console_safe = TRUE';
	}
	if (isset($_GET['mask'])) {
		$require_all = isset($_GET['mask_require_all']);
		if ($require_all) {
			$clauses[] = '((game_specific->\'map\')::int & ::mask::) = ::mask::';
		} else {
			$clauses[] = '((game_specific->\'map\')::int & ::mask::) > 0';
		}
		$params['mask'] = $_GET['mask'];
	}
	if (isset($_GET['search'])) {
		$search = new BeaconSearch();
		$results = $search->Search($_GET['search'], null, 100, 'Document');
		if (count($results) > 0) {
			$ids = [];
			foreach ($results as $result) {
				$ids[] = $database->EscapeLiteral($result['objectID']);
			}
			$clauses[] = 'project_id IN (' . implode(', ', $ids) . ')';
		} else {
			$clauses[] = "project_id = '00000000-0000-0000-0000-000000000000'";
		}
	}
	$sql = 'SELECT ' . implode(', ', Project::SQLColumns()) . ' FROM ' . Project::SchemaName() . '.' . Project::AllowedTableName() . ' WHERE ' . implode(' AND ', $clauses);
	
	$sort_column = 'last_update';
	$sort_direction = 'DESC';
	if (isset($_GET['sort'])) {
		switch ($_GET['sort']) {
		case 'download_count':
			$sort_column = 'download_count';
			break;
		case 'name':
			$sort_column = 'title';
			break;
		case 'console_safe':
			$sort_column = 'console_safe';
			break;
		case 'description':
			$sort_column = 'description';
			break;
		}
	}
	if (isset($_GET['direction'])) {
		$sort_direction = (strtolower($_GET['direction']) === 'desc' ? 'DESC' : 'ASC');
	}
	$sql .= ' ORDER BY ' . $sort_column . ' ' . $sort_direction;
		
	if (isset($_GET['count'])) {
		$sql .= ' LIMIT ::limit::';
		$params['limit'] = $_GET['count'];
	}
	if (isset($_GET['offset'])) {
		$sql .= ' OFFSET ::offset::';
		$params['offset'] = $_GET['offset'];
	}
	$keys = array_keys($params);
	$values = array_values($params);
	for ($i = 0; $i < count($keys); $i++) {
		$sql = str_replace('::' . $keys[$i] . '::', '$' . ($i + 1), $sql);
	}
	
	$results = $database->Query($sql, $values);
	$projects = Project::GetFromResults($results);*/
	return APIResponse::NewJSON($projects, 200);
}

?>
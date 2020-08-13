<?php

if ($user->IsChildAccount()) {
	echo '<p class="text-center">Your account is controlled by another user. Your account cannot have team members.</p>';
	return;
}

BeaconTemplate::AddStylesheet('/account/assets/team.scss');
BeaconTemplate::AddScript('/account/assets/team.js');

echo '<div class="child_seat_status">';
$purchased_seat_count = $user->TotalChildSeats();
$used_seat_count = $user->UsedChildSeats();
$remaining_seats = $purchased_seat_count - $used_seat_count;
echo '<p class="slot_explanation">';
if ($purchased_seat_count == 0) {
	echo 'You have not purchased any team member licenses.';
} else {
	echo 'You have used <span class="slot_count used_slot_count">' . $user->UsedChildSeats() . '</span> of your <span class="slot_count total_slot_count">' . number_format($purchased_seat_count, 0) . '</span> team member license' . ($purchased_seat_count != 1 ? 's' : '') . '.';
}
echo '</p><p><button id="buy_slots_button" class="default">Buy More Licenses</button>';
if ($remaining_seats > 0) {
	echo '<button id="add_account_button">Add Team Member</button>';
}
echo '</p><p><a href="#">Learn more about Beacon for teams</a></div>';

$children = $user->ChildAccounts();
if (count($children) === 0) {
	return;
}

echo '<table class="generic">';
echo '<thead><tr><th>Name</th><th class="low-priority">Enabled</th><th class="low-priority">Actions</th></tr></thead>';
foreach ($children as $child) {
	$action_links = ['<a href="#">Reset Password</a>'];
	if ($child->IsEnabled() === false && $remaining_seats > 0) {
		$action_links[] = '<a href="#">Enable</a>';	
	} else if ($child->IsEnabled()) {
		$action_links[] = '<a href="#">Disable</a>';
	}
	
	echo '<tr>';
	echo '<td>' . htmlentities($child->Username()) . '<span class="user-suffix">#' . htmlentities($child->Suffix()) . '</span><div class="row-details"><span class="detail">' . ($child->IsEnabled() ? 'Enabled' : 'Disabled') . '</span><span class="detail">' . implode('</span><span class="detail">', $action_links) . '</span></div></td>';
	echo '<td class="low-priority text-center nowrap">' . ($child->IsEnabled() ? 'Yes' : 'No') . '</td>';
	echo '<td class="low-priority text-center nowrap">' . implode('<br>', $action_links) . '</td>';
}
echo '</table>';
echo '<p class="smaller text-center text-lighter">Disabled accounts do not count against your license usage.</p>';

?>
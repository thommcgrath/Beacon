<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Submit Ticket');
BeaconTemplate::SetPageDescription('Submit a new support request');

$valid = true;

$requester_name = '';
$requester_email = '';
$requester_uuid = null;

$ticket_platform = '';
$ticket_host = '';
$ticket_body = '';

$valid_platforms = array(
	'pc_/_steam' => 'Steam',
	'xbox_/_windows_store' => 'Xbox / Windows Store',
	'playstation' => 'PlayStation',
	'switch_/_mobile_/_other' => 'Switch / Mobile / Other'
);

$session = BeaconSession::GetFromCookie();
if (!is_null($session)) {
	$user = BeaconUser::GetByUserID($session->UserID());
	$requester_name = $user->Username();
	$requester_uuid = $user->UserID();
}
if (isset($_SESSION['login_email'])) {
	$requester_email = $_SESSION['login_email'];
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	$requester_name = trim($_POST['username']);
	$requester_email = trim($_POST['email']);
	$ticket_platform = $_POST['platform'];
	$ticket_host = trim($_POST['host']);
	$ticket_body = trim($_POST['body']);
	
	if (!array_key_exists($ticket_platform, $valid_platforms)) {
		$valid = false;
		$ticket_platform = '';
	}
	
	if (!BeaconUser::ValidateEmail($requester_email)) {
		$valid = false;
	}
	
	if (empty($requester_email) || empty($requester_name) || empty($ticket_body) || empty($ticket_host)) {
		$valid = false;
	}
	
	if ($valid) {
		if (is_null($requester_uuid)) {
			$user = BeaconUser::GetByEmail($requester_email);
			if (!is_null($user)) {
				$requester_uuid = $user->UserID();
			}
		}
		
		$ticket = array(
			'ticket' => array(
				'custom_fields' => array(
					array(
						'id' => 360019496992,
						'value' => $ticket_platform
					),
					array(
						'id' => 360019555031,
						'value' => $ticket_host
					)
				),
				'requester' => array(
					'locale_id' => 1,
					'name' => $requester_name,
					'email' => $requester_email
				),
				'comment' => array(
					'body' => $ticket_body
				)
			)
		);
		
		$curl = curl_init('https://thezaz.zendesk.com/api/v2/tickets.json');
		curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($ticket));
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'POST');
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));
		curl_setopt($curl, CURLOPT_USERPWD, BeaconCommon::GetGlobal('ZenDesk_Username') . ":" . BeaconCommon::GetGlobal('ZenDesk_Password'));
		$zendesk_body = curl_exec($curl);
		
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		if ($status == 201) {
			$html = 'Thanks, your request has been received! You will receive a confirmation email shortly.';
		} else {
			$html = 'Uh oh, there was a ' . $status . ' from ZenDesk. Your ticket has not been created.' . "\n\n$zendesk_body";
		}
	}
}

if (empty($html)) {
	ob_start();
	?><h2>Submit a new support request</h2>
	<?php if (!$valid) { ?><blockquote>Hey, it looks like the form wasn't filled out completely. Please give it another look.</blockquote><?php } ?>
	<form method="post" action="/help/contact">
		<table width="100%" cellpadding="0" cellspacing="10">
			<tr>
				<td class="text-right bold">Name:</td>
				<td><input type="text" placeholder="Name" value="<?php echo htmlentities($requester_name); ?>" name="username" id="ticket_username_field" required></td>
			</tr>
			<tr>
				<td class="text-right bold">Email:</td>
				<td><input type="email" placeholder="E-Mail Address" value="<?php echo htmlentities($requester_email); ?>" name="email" id="ticket_email_fields" required></td>
			</tr>
			<tr>
				<td class="text-right bold">Platform:</td>
				<td><div class="select"><span></span><select name="platform" id="ticket_platform_menu" required>
					<option disabled<?php if ($ticket_platform === '') { echo ' selected'; } ?>></option><?php
					
					foreach ($valid_platforms as $platform => $label) {
						echo "\n\t\t\t\t" . '<option value="' . htmlentities($platform) . '"' . ($ticket_platform === $platform ? ' selected' : '') . '>' . htmlentities($label) . '</option>';
					}
					
					?>
					
				</select></div></td>
			</tr>
			<tr>
				<td class="text-right bold">Host:</td>
				<td><input type="text" placeholder="Hosting Provider" value="<?php echo htmlentities($ticket_host); ?>" name="host" id="ticket_host_field" required><br><span class="smaller text-lighter">For example: Nitrado, GPortal, single player, self-hosted</span></td>
			</tr>
			<tr>
				<td colspan="2"><textarea name="body" id="ticket_body_area" placeholder="How can we help?" rows="14"><?php echo htmlentities($ticket_body); ?></textarea></td>
			</tr>
			<tr>
				<td colspan="2" class="text-right"><input type="submit" id="ticket_submit_button" value="Submit"></td>
			</tr>
		</table>
	</form>
	<?php
	$html = ob_get_contents();
	ob_end_clean();
}

include('inc.knowledge.php');
ShowKnowledgeContent($html, '');

?>
<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');

define('OMNI_PRODUCT_ID', '972f9fc5-ad64-4f9c-940d-47062e705cc5');

BeaconCommon::StartSession();

$session = BeaconSession::GetFromCookie();
if (is_null($session)) {
	BeaconCommon::Redirect('/account/login/?return=' . $_SERVER['REQUEST_URI']);
	exit;
}

header('Cache-Control: no-cache');

$database = BeaconCommon::Database();
$user = BeaconUser::GetByUserID($session->UserID());
BeaconTemplate::SetTitle('Account: ' . $user->Username());

BeaconTemplate::StartStyles(); ?>
<style>

#redeem_form {
	width: 600px;
	max-width: 100%;
	margin-left: auto;
	margin-right: auto;
}	

</style><?php
BeaconTemplate::FinishStyles();

if (isset($_REQUEST['code'])) {
	$code = substr($_REQUEST['code'], 0, 9);
} else {
	$code = '';
}

$email_id = $user->EmailID();

$results = $database->Query('SELECT * FROM purchased_products WHERE purchaser_email = $1 AND product_id = $2;', $email_id, OMNI_PRODUCT_ID);
if ($results->RecordCount() > 0) {
	echo '<div id="redeem_form"><p class="text-center"><span class="text-red">You already own Omni! There\'s no reason to redeem the code again!</span><br>But you can <a href="/account/#omni">click here</a> to see activation instructions instead.</p></div>';
	return;
}

if (strtoupper($_SERVER['REQUEST_METHOD']) === 'POST') {
	$results = $database->Query('SELECT COUNT(log_id) AS num_attempts FROM purchase_code_log WHERE user_id = $1 AND attempt_time > CURRENT_TIMESTAMP - \'1 hour\'::INTERVAL;', $user->UserID());
	if (intval($results->Field('num_attempts')) >= 20) {
		$error = 'Sorry, the code is either invalid or already redeemed.';
		$database->BeginTransaction();
		$database->Query('INSERT INTO purchase_code_log (code, user_id, source_ip, success) VALUES ($1, $2, $3, FALSE);', $code, $user->UserID(), $_SERVER['REMOTE_ADDR']);
		$database->Commit();
	} else {
		$results = $database->Query('SELECT retail_price FROM products WHERE product_id = $1;', OMNI_PRODUCT_ID);
		$retail_price = $results->Field('retail_price');
		
		$results = $database->Query('SELECT code FROM purchase_codes WHERE LOWER(code) = LOWER($1) AND redemption_date IS NULL;', $code);
		if ($results->RecordCount() == 0) {
			$error = 'Sorry, the code is either invalid or already redeemed.';
			$database->BeginTransaction();
			$database->Query('INSERT INTO purchase_code_log (code, user_id, source_ip, success) VALUES ($1, $2, $3, FALSE);', $code, $user->UserID(), $_SERVER['REMOTE_ADDR']);
			$database->Commit();
		} else {
			$code = $results->Field('code');
			if ($user->IsBanned()) {
				BeaconCommon::PostSlackMessage('Banned account ' . $user->UserID() . ' tried to redeem gift code ' . $code . '.');
				BeaconCommon::Redirect('https://www.youtube.com/watch?v=sKbP-M8vVtw');
			}
			
			$purchase_id = BeaconCommon::GenerateUUID();
			
			$database->BeginTransaction();
			$database->Query('UPDATE purchase_codes SET redemption_date = CURRENT_TIMESTAMP, redemption_purchase_id = $2 WHERE code = $1;', $code, $purchase_id);
			$database->Query('INSERT INTO purchases (purchase_id, purchaser_email, subtotal, discount, tax, total_paid, merchant_reference) VALUES ($1, $2, $3, $3, 0, 0, $4);', $purchase_id, $email_id, $retail_price, 'Code ' . $code);
			$database->Query('INSERT INTO purchase_items (purchase_id, product_id, retail_price, discount, quantity, line_total) VALUES ($1, $2, $3, $3, 1, 0);', $purchase_id, OMNI_PRODUCT_ID, $retail_price);
			$database->Query('INSERT INTO purchase_code_log (code, user_id, source_ip, success) VALUES ($1, $2, $3, TRUE);', $code, $user->UserID(), $_SERVER['REMOTE_ADDR']);
			$database->Commit();
			
			echo '<div id="redeem_form"><p class="text-center"><span class="text-blue">You now own Beacon Omni!</span><br><a href="/account/#omni">Activation instructions</a> are available if you need them.</p></div>';
			return;
		}
	}
}

?><h1>Redeem a Code for Beacon Omni</h1>
<div id="redeem_form">
	<form action="redeem.php" method="post">
		<p>Got a code for Beacon Omni? Redeem it here!</p>
		<?php if (isset($error)) { ?><p class="text-center text-red"><?php echo htmlentities($error); ?></p><?php } ?>
		<p><input type="text" name="code" placeholder="Code" minlength="9" maxlength="9" value="<?php echo htmlentities($code); ?>"></p>
		<p class="text-right"><input type="submit" value="Redeem"></p>
	</form>
</div>
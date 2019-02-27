<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
BeaconTemplate::SetTitle('Share The Wealth');

$utc = new DateTime(date('Y-m-d 13:00', time()));
$est = clone $utc;
$est->setTimezone(new DateTimeZone('America/New_York'));
$pst = clone $utc;
$pst->setTimezone(new DateTimeZone('America/Los_Angeles'));

BeaconCommon::StartSession();
if (isset($_SESSION['STW_PUBLIC_KEY'])) {
	$public_key = $_SESSION['STW_PUBLIC_KEY'];
} else {
	BeaconEncryption::GenerateKeyPair($public_key, $private_key);
	$_SESSION['STW_PRIVATE_KEY'] = $private_key;
	$_SESSION['STW_PUBLIC_KEY'] = $public_key;
	unset($private_key);
}

BeaconTemplate::AddScript('https://cdnjs.cloudflare.com/ajax/libs/jsencrypt/2.3.1/jsencrypt.min.js');

BeaconTemplate::StartScript(); ?>
<script>

document.addEventListener('DOMContentLoaded', function() {
	document.getElementById('stw_form').addEventListener('submit', function(ev) {
		var encrypt = new JSEncrypt();
		encrypt.setPublicKey(<?php echo json_encode($public_key); ?>);
		
		var encrypted = encrypt.encrypt(document.getElementById('stw_email_field').value);
		
		var fields = {'email': encrypted};
		request.post('submit.php', fields, function (obj) {
			var container = document.getElementById('stw_container');
			container.innerHTML = 'Ok, ' + obj.email + ' is now on the list! If selected, you will receive an email with instructions.';
		}, function (http_status, response_body) {
			switch (http_status) {
			case 404:
				dialog.show('Unable to submit the email address', 'The receiver script was not found.');
				break;
			case 400:
				var obj = JSON.parse(response_body);
				dialog.show('Sorry, that didn\'t work.', obj.error);
				break;
			default:
				dialog.show('Unable to submit the email address', 'Sorry, there was a ' + http_status + ' error: ' + response_body);
				break;
			}
		});
		
		ev.preventDefault();
		return true;
	});
});

</script>
<?php
BeaconTemplate::FinishScript();

?><h1>Beacon Omni's <em>Share The Wealth</em> Program</h1>
<p>The <em>Share The Wealth</em> program is designed for users in one of two groups: users who are unable to purchase for any reason, and users who want to show more support for Beacon. The program allows buyers to purchase extra copies of Beacon Omni which then gets awarded to another random user.</p>
<h3>How to give a copy of Beacon Omni</h3>
<p>When purchasing, there is a line labeled &quot;Beacon Share The Wealth&quot; which allows purchasing up to 10 additional copies of Beacon Omni to be given away to random users.</p>
<h3>How to get a free copy of Beacon Omni</h3>
<p>If you'd like to be a potential recipient of a free Beacon Omni license under the <em>Share The Wealth</em> program, all you need to do is add your email address.</p>
<div id="stw_container" class="text-center inset-note">
<form action="#" method="post" id="stw_form"><input type="email" placeholder="E-Mail Address" id="stw_email_field" name="email"><br><br><input type="submit" value="Join the Program"></form>
</div>
<p class="smaller">There's no guarantee when or if your address will be chosen at random. Odds of selection depend on number of participants and purchasers. One recipient will be chosen each day at <?php echo $utc->format('g:i A T'); ?> / <?php echo $est->format('g:i A T'); ?> / <?php echo $pst->format('g:i A T'); ?>, as long as there are Beacon Omni licenses waiting in the <em>Share The Wealth</em> program.</p>
<p class="smaller">Because Beacon is so interested in privacy, email addresses are normally stored as a one-way hash. However, the <em>Share The Wealth</em> program requires email addresses to be accessible to send out notifications to recipients. Therefore, email addresses entered into the <em>Share The Wealth</em> program will be stored using encryption instead of hashing. If selected, the encrypted email address will be discarded and converted to a high security hashed value.</p>
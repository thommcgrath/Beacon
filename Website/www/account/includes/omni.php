<?php

$has_purchased = $user->OmniVersion() >= BeaconCommon::CurrentOmniVersion();

if (!$has_purchased) {
	echo '<div class="small_section"><p>You have not purchased Beacon Omni. <a href="/omni/">Learn more about Beacon Omni here.</a></p></div>';
	ShowGiftCodes();
	return;
}

BeaconTemplate::StartStyles(); ?>
<style>

#omni_instructions_internet, #omni_instructions_no_internet {
	margin-top: 40px;
	margin-bottom: 40px;
}

#drop_area, #drop_hover_instructions {
	display: none;
}

#upload_container.live-supported {
	#upload_activation_form {
		display: none;
	}
	
	#drop_area {
		display: block;
		text-align: center;
		border-width: 1px;
		border-style: solid;
		padding: 30px 15px;
		margin-left: auto;
		margin-right: auto;
		max-width: 500px;
		box-sizing: border-box;
		
		&.highlight {
			#drop_hover_instructions {
				display: inline;
			}
			
			#drop_initial_instructions {
				display: none;
			}
		}
	}
}

#img_signin_auth {
	background-image: url(/omni/welcome/auth.png);
	width: 150px;
	height: 118px;
}

#img_signin_import {
	background-image: url(/omni/welcome/import.png);
	width: 150px;
	height: 59px;
}

#img_signin_password {
	background-image: url(/omni/welcome/password.png);
	width: 150px;
	height: 59px;
	clear: left;
	margin-top: 6px;
}

</style><?php
BeaconTemplate::FinishStyles();

BeaconTemplate::StartScript(); ?>
<script>
document.addEventListener('DOMContentLoaded', function(event) {
	document.getElementById('omni_show_instructions_internet').addEventListener('click', function(ev) {
		ev.preventDefault();
		
		var instructions = document.getElementById('omni_instructions_internet');
		if (instructions.className == 'hidden') {
			instructions.className = '';
		} else {
			instructions.className = 'hidden';
		}
	});
	
	document.getElementById('omni_show_instructions_no_internet').addEventListener('click', function(ev) {
		ev.preventDefault();
		
		var instructions = document.getElementById('omni_instructions_no_internet');
		if (instructions.className == 'hidden') {
			instructions.className = '';
		} else {
			instructions.className = 'hidden';
		}
	});
	
	let drag_and_drop_supported = self.fetch && window.FileReader && ('classList' in document.createElement('a'));
	if (drag_and_drop_supported) {
		var upload_file = function(file) {
			let formData = new FormData();
			formData.append('file', file);
			
			fetch(document.getElementById('upload_activation_form').getAttribute('action'), { method: 'POST', body: formData, credentials: 'same-origin', headers: {'Accept': 'application/json'} }).then(function(response) {
				if (!response.ok) {
					let obj = response.json().then(function(obj) {
						let message = 'Sorry, there was an error creating the authorization file.';
						if (obj.message) {
							message += ' ' + obj.message.trim();
						}
						if (!message.endsWith('.')) {
							message += '.';
						}
						dialog.show('Unable to create authorization file', message);
					});
					return;
				}
				
				let disposition = response.headers.get('content-disposition');
				let matches = /"([^"]*)"/.exec(disposition);
				let filename = (matches != null && matches[1] ? matches[1] : 'Default.beaconidentity');
				
				response.blob().then(function(blob) {
					let link = document.createElement('a');
					link.href = window.URL.createObjectURL(blob);
					link.download = filename;
					
					document.body.appendChild(link);
					link.click();
					document.body.removeChild(link);
				});
			}).catch(function(error) {
				dialog.show('Unable to create authorization file', 'There was a network error: ' + error);
			});
		};
		
		var upload_container = document.getElementById('upload_container');
		upload_container.classList.add('live-supported');
		
		var drop_area = document.getElementById('drop_area');
		
		['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
			drop_area.addEventListener(eventName, function(e) {
				e.preventDefault();
				e.stopPropagation();
			}, false);
		});
		
		['dragenter', 'dragover'].forEach(eventName => {
			drop_area.addEventListener(eventName, function(e) {
				this.classList.add('highlight');
			}, false);
		});
		
		['dragleave', 'drop'].forEach(eventName => {
			drop_area.addEventListener(eventName, function(e) {
				this.classList.remove('highlight');
			}, false);
		});
		
		document.getElementById('choose_file_button').addEventListener('click', function(ev) {
			ev.preventDefault();
			
			let chooser = document.getElementById('file_chooser');
			if (chooser) {
				chooser.addEventListener('change', function(ev) {
					upload_file(this.files[0]);
				});
				
				chooser.click();
			}
		});
		
		drop_area.addEventListener('drop', function(e) {
			upload_file(e.dataTransfer.files[0]);
		}, false);
	}
});
</script><?php
BeaconTemplate::FinishScript();

?><p>Thanks for purchasing Beacon Omni! Your support means a lot.</p>
<h2>Activating Beacon Omni</h2>
<h3><a href="#with-internet" id="omni_show_instructions_internet">Method 1: Sign into your account in Beacon</a></h3>
<div id="omni_instructions_internet" class="hidden"><?php include(BeaconCommon::WebRoot() . '/omni/welcome/instructions.php'); ?></div>
<h3><a href="#without-internet" id="omni_show_instructions_no_internet">Method 2: Use an activation file for a computer without internet</a></h3>
<div id="omni_instructions_no_internet" class="hidden">
	<div class="signin_step separator-color">
		<div id="img_signin_auth" class="img_signin separator-color">&nbsp;</div>
		<div class="signin_text">
			<h4>Create an Offline Authorization Request</h4>
			<p>Using the Help menu, choose &quot;Create Offline Authorization Request&quot; and save the file when prompted. You will need to transfer the to this computer. A USB memory stick is usually the easiest way to do it.</p>
		</div>
		<div class="push">&nbsp;</div>
	</div>
	<div class="signin_step separator-color" id="upload_container">
		<form id="upload_activation_form" method="post" action="/account/actions/activate.php" enctype="multipart/form-data">
			<input type="file" name="file" accept=".beaconauth" id="file_chooser"><input type="submit" value="Upload">
		</form>
		<div id="drop_area" class="separator-color"><span id="drop_initial_instructions">Drop your activation file here or <a href="" id="choose_file_button">choose the file</a>.</span><span id="drop_hover_instructions">Do it!</span></div>
	</div>
	<div class="signin_step separator-color">
		<div id="img_signin_import" class="img_signin separator-color">&nbsp;</div>
		<div id="img_signin_password" class="img_signin separator-color">&nbsp;</div>
		<div class="signin_text">
			<h4>Import your identity file</h4>
			<p>After uploading your activation file, you will have downloaded an identity file. Transfer the identity file back to the computer which created the authorization request.</p>
			<p>In Beacon, use the File menu, choose &quot;Import&quot; and select the identity file. When prompted, enter your account password.</p>
			<p>That's it, Beacon Omni will be ready for use.</p>
		</div>
		<div class="push">&nbsp;</div>
	</div>
</div><?php
	
ShowGiftCodes();

function ShowGiftCodes() {
	global $user;
	
	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT code, redemption_date FROM purchase_codes WHERE purchaser_email_id = $1;', $user->EmailID());
	if ($results->RecordCount() == 0) {
		return;
	}
	
	echo '<h2>Gift Codes</h2>';
	echo '<p>Codes can be redeemed at <a href="/redeem">https://' . BeaconCommon::Domain() . '/redeem</a> or using the link next to each code.</p>';
	echo '<table class="generic"><thead><tr><th>Code</th><th class="low-priority">Status</th><th class="low-priority">Redeem Link</th></thead>';
	while (!$results->EOF()) {
		$code = $results->Field('code');
		$redeemed = is_null($results->Field('redemption_date')) === false;
		
		echo '<tr><td>' . htmlentities($code) . '<div class="row-details"><span class="detail">' . ($redeemed ? 'Redeemed' : '/redeem/' . htmlentities($code)) . '<span></div></td><td class="low-priority">' . ($redeemed ? 'Redeemed' : '&nbsp;') . '</td><td class="low-priority">' . ($redeemed ? '&nbsp;' : '/redeem/' . htmlentities($code)) . '</td>';
		$results->MoveNext();
	}
	echo '</table>';
}

?>

<?php

$has_purchased = $user->OmniVersion() >= BeaconCommon::CurrentOmniVersion();

if (!$has_purchased) {
	echo '<div class="small_section"><p>You have not purchased Beacon Omni. <a href="/omni/">Learn more about Beacon Omni here.</a></p></div>';
	exit;
}

BeaconTemplate::StartStyles(); ?>
<style>

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
		width: 500px;
		
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
	<div id="upload_container">
		<form id="upload_activation_form" method="post" action="/account/actions/activate.php" enctype="multipart/form-data">
			<input type="file" name="file" accept=".beaconauth" id="file_chooser"><input type="submit" value="Upload">
		</form>
		<div id="drop_area" class="separator-color"><span id="drop_initial_instructions">Drop your activation file here or <a href="" id="choose_file_button">choose the file</a> to begin.</span><span id="drop_hover_instructions">Do it!</span></div>
	</div>
</div>
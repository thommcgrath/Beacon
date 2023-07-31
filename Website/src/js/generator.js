"use strict";

document.addEventListener('DOMContentLoaded', () => {
	const updateUI = () => {
		let desiredDinoLevel = 120;
		const dinoLevelField = document.getElementById('dinoLevelField');
		if (dinoLevelField) {
			desiredDinoLevel = Number.parseInt(dinoLevelField.value);
		}
		
		const override = desiredDinoLevel / 30;
		const reference = document.getElementById('difficulty_reference');
		if (reference) {
			const lines = [];
			lines.push('DifficultyOffset=1.0');
			lines.push('OverrideOfficialDifficulty=' + override.toFixed(4));
			reference.value = lines.join("\n");
		}
		
		const valueCreate = document.getElementById('create_difficulty_value');
		if (valueCreate) {
			valueCreate.value = override.toFixed(1);
		}
		
		const valuePaste = document.getElementById('paste_difficulty_value');
		if (valuePaste) {
			valuePaste.value = override.toFixed(1);
		}
		
		const valueUpload = document.getElementById('upload_difficulty_value');
		if (valueUpload) {
			valueUpload.value = override.toFixed(1);
		}
	};
	
	const dinoLevelField = document.getElementById('dino_level_field');
	if (dinoLevelField) {
		dinoLevelField.addEventListener('input', updateUI);
	}
	updateUI();
	
	if (document.getElementById('mode_tabs') !== null) {
		document.getElementById('mode_tabs_new').addEventListener('click', () => {
			document.getElementById('mode_view_new').style.display = 'block';
			document.getElementById('mode_view_paste').style.display = 'none';
			document.getElementById('mode_view_upload').style.display = 'none';
			document.getElementById('mode_tabs_new').className = 'selected';
			document.getElementById('mode_tabs_paste').className = '';
			document.getElementById('mode_tabs_upload').className = '';
		});
		document.getElementById('mode_tabs_paste').addEventListener('click', () => {
			document.getElementById('mode_view_new').style.display = 'none';
			document.getElementById('mode_view_paste').style.display = 'block';
			document.getElementById('mode_view_upload').style.display = 'none';
			document.getElementById('mode_tabs_new').className = '';
			document.getElementById('mode_tabs_paste').className = 'selected';
			document.getElementById('mode_tabs_upload').className = '';
		});
		document.getElementById('mode_tabs_upload').addEventListener('click', () => {
			document.getElementById('mode_view_new').style.display = 'none';
			document.getElementById('mode_view_paste').style.display = 'none';
			document.getElementById('mode_view_upload').style.display = 'block';
			document.getElementById('mode_tabs_new').className = '';
			document.getElementById('mode_tabs_paste').className = '';
			document.getElementById('mode_tabs_upload').className = 'selected';
		});
	}
	
	const copyButton = document.getElementById('copy_button');
	if (copyButton) {
		copyButton.addEventListener('click', (event) => {
			const cell = document.getElementById('content_output');
			if (cell) {
				try {
					navigator.clipboard.writeText(cell.value);
					event.currentTarget.innerText = 'Copied!';
					event.currentTarget.disabled = true;
					setTimeout(() => {
						event.currentTarget.innerText = 'Copy';
						event.currentTarget.disabled = false;
					}, 3000);
				} catch (err) {
					alert('Looks like this browser does not support automatic copy. You will need to do it yourself.');
				}
			}
		});
	}
	
	const chooseField = document.getElementById('upload_file_selector');
	const chooseButton = document.getElementById('upload_file_selector_button');
	if (chooseField && chooseButton) {
		chooseButton.addEventListener('click', (event) => {
			chooseField.click();
			if (event.preventDefault) {
				event.preventDefault();
			}
			return false;
		});
		chooseField.addEventListener('change', (event) => {
			if (event.currentTarget.value !== '') {
				event.currentTarget.form.submit();
			}
		});
	}
});

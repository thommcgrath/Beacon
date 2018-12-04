if (Number.parseInt === undefined) {
    Number.parseInt = window.parseInt;
}

var difficulty = {
	maps: 0,
	init: function() {
		var map_mask = document.getElementById('map_mask');
		if (map_mask) {
			this.maps = Number.parseInt(map_mask.value);
		}
		
		var dino_level_field = document.getElementById('dino_level_field');
		if (dino_level_field) {
			dino_level_field.addEventListener('input', function(event) {
				difficulty.updateUI();
			});
		}
		
		var fn_map_check = function(event) {
			var mask_value = Number.parseInt(this.value);
			if (this.checked) {
				difficulty.maps = difficulty.maps | mask_value;
			} else {
				difficulty.maps = difficulty.maps & ~mask_value;
			}
			
			difficulty.updateUI();
		};
		var map_masks = [1, 2, 4, 8, 16];
		for (var i = 0; i < map_masks.length; i++) {
			var mask_value = map_masks[i];
			var check = document.getElementById('map_check_' + mask_value);
			if (check) {
				check.addEventListener('change', fn_map_check);
				if (check.checked) {
					this.maps = this.maps | Number.parseInt(check.value);
				}
			}
		}
		this.updateUI();
	},
	updateUI: function() {
		var map_difficulties = [];
		if ((difficulty.maps & 1) == 1 || (difficulty.maps & 2) == 2 || (difficulty.maps & 16) == 16) {
			map_difficulties.push(4.0);
		}
		if ((difficulty.maps & 4) == 4 || (difficulty.maps & 8) == 8) {
			map_difficulties.push(5.0);
		}
		
		var desired_dino_level = 120;
		var dino_level_field = document.getElementById('dino_level_field');
		if (dino_level_field) {
			desired_dino_level = Number.parseInt(dino_level_field.value);
		}
		
		var required_map_maximum = Math.ceil(desired_dino_level / 30);
		var map_maximum = 0;
		for (var i = 0; i < map_difficulties.length; i++) {
			map_maximum = Math.max(map_maximum, map_difficulties[i]);
		}
		var difficulty_maximum = Math.max(required_map_maximum, map_maximum);
		var requires_difficulty_override = map_difficulties.length > 1 || difficulty_maximum != map_maximum;
		
		var difficulty_offset = Math.max((desired_dino_level - 15) / ((difficulty_maximum * 30) - 15), 0.001);
		var difficulty_value = (difficulty_offset * (difficulty_maximum - 0.5)) + 0.5;
		var fixed_value = difficulty_value.toFixed(4);
		
		var reference = document.getElementById('difficulty_reference');
		if (reference) {
			var lines = [];
			lines.push('DifficultyOffset=' + difficulty_offset.toFixed(4));
			
			if (requires_difficulty_override) {
				lines.push('OverrideOfficialDifficulty=' + difficulty_maximum.toFixed(1));
			}
			
			reference.value = lines.join("\n");
		}
		
		var value_create = document.getElementById('create_difficulty_value');
		if (value_create) {
			value_create.value = fixed_value;
		}
		
		var value_paste = document.getElementById('paste_difficulty_value');
		if (value_paste) {
			value_paste.value = fixed_value;
		}
		
		var value_upload = document.getElementById('upload_difficulty_value');
		if (value_upload) {
			value_upload.value = fixed_value;
		}
	}
};

document.addEventListener('DOMContentLoaded', function() {
	difficulty.init();
	
	if (document.getElementById('mode_tabs') !== null) {
		document.getElementById('mode_tabs_new').addEventListener('click', function(event) {
			document.getElementById('mode_view_new').style.display = 'block';
			document.getElementById('mode_view_paste').style.display = 'none';
			document.getElementById('mode_view_upload').style.display = 'none';
			document.getElementById('mode_tabs_new').className = 'selected';
			document.getElementById('mode_tabs_paste').className = '';
			document.getElementById('mode_tabs_upload').className = '';
		});
		document.getElementById('mode_tabs_paste').addEventListener('click', function(event) {
			document.getElementById('mode_view_new').style.display = 'none';
			document.getElementById('mode_view_paste').style.display = 'block';
			document.getElementById('mode_view_upload').style.display = 'none';
			document.getElementById('mode_tabs_new').className = '';
			document.getElementById('mode_tabs_paste').className = 'selected';
			document.getElementById('mode_tabs_upload').className = '';
		});
		document.getElementById('mode_tabs_upload').addEventListener('click', function(event) {
			document.getElementById('mode_view_new').style.display = 'none';
			document.getElementById('mode_view_paste').style.display = 'none';
			document.getElementById('mode_view_upload').style.display = 'block';
			document.getElementById('mode_tabs_new').className = '';
			document.getElementById('mode_tabs_paste').className = '';
			document.getElementById('mode_tabs_upload').className = 'selected';
		});
	}
	
	var button = document.getElementById('copy_button');
	if (button !== null) {
		button.addEventListener('click', function(event) {
			var cell = document.getElementById('content_output');
			if (cell) {
				try {
					clipboard.writeText(cell.value);
					event.target.innerText = 'Copied!';
					event.target.disabled = true;
					setTimeout(function() {
						event.target.innerText = 'Copy';
						event.target.disabled = false;
					}, 3000);
				} catch (err) {
					alert('Looks like this browser does not support automatic copy. You will need to do it yourself.');
				}
			}
		});
	}
	
	var choose_field = document.getElementById('upload_file_selector');
	var choose_button = document.getElementById('upload_file_selector_button');
	if (choose_field && choose_button) {
		choose_button.addEventListener('click', function(event) {
			choose_field.click();
			if (event.preventDefault) {
				event.preventDefault();
			}
			return false;
		});
		choose_field.addEventListener('change', function(event) {
			if (this.value !== '') {
				this.form.submit();
			}
		});
	}
});
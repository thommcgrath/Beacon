var request = {
	start: function(method, uri, success_handler, error_handler, headers) {
		var xhr = new XMLHttpRequest();
		xhr.open(method, uri, true);
		xhr.setRequestHeader('Accept', 'application/json');
		if (headers !== null) {
			for (var key in headers) {
				xhr.setRequestHeader(key, headers[key]);
			}
		}
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return;
			}
			
			if (xhr.status != 200) {
				error_handler(xhr.status, xhr.responseText);
				return;
			}
			
			var obj
			if (xhr.responseText != '') {
				obj = JSON.parse(xhr.responseText);
			} else {
				obj = {};
			}
			success_handler(obj);
		};
		xhr.send();
	}
};

var dialog = {
	show: function(message, explanation, handler = null) {
		var overlay = document.getElementById('overlay');
		var dialog_frame = document.getElementById('dialog');
		var dialog_message = document.getElementById('dialog_message');
		var dialog_explanation = document.getElementById('dialog_explanation');
		var dialog_action_button = document.getElementById('dialog_action_button');
		if (overlay && dialog && dialog_message && dialog_explanation && dialog_action_button) {
			overlay.className = 'exist';
			dialog_frame.className = 'exist';
			setTimeout(function() {
				overlay.className = 'exist visible';
				dialog_frame.className = 'exist visible';
			}, 10);
			dialog_message.innerText = message;
			dialog_explanation.innerText = explanation;
			dialog_action_button.addEventListener('click', function(event) {
				dialog.hide(handler);
			});
		}
	},
	hide: function (handler = null) {
		var overlay = document.getElementById('overlay');
		var dialog_frame = document.getElementById('dialog');
		if (overlay && dialog_frame) {
			overlay.className = 'exist';
			dialog_frame.className = 'exist';
			setTimeout(function() {
				overlay.className = '';
				dialog_frame.className = '';
				if (handler) {
					handler();
				}
			}, 200);
		}
	}
};
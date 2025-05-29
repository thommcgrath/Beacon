export const SecureOptionPassword = 'password';
export const SecureOptionAnyAuthenticator = 'anyAuthenticator';

export class BeaconDialog {
	static activeModal = null;
	static viewportWatcher = null;

	static show(message, explanation = null, actionCaption = 'Ok') {
		return this.confirm(message, explanation, actionCaption, null);
	}

	static confirm(message, explanation = null, actionCaption = 'Ok', cancelCaption = 'Cancel', slotHtml = null) {
		return new Promise((resolve, reject) => {
			const overlay = document.getElementById('overlay');
			const dialogFrame = document.getElementById('dialog');
			const dialogMessage = document.getElementById('dialog_message');
			const dialogExplanation = document.getElementById('dialog_explanation');
			const dialogSlot = document.getElementById('dialog_slot');
			const dialogActionButton = document.getElementById('dialog_action_button');
			const dialogCancelButton = document.getElementById('dialog_cancel_button');

			if (!(overlay && dialogFrame && dialogMessage && dialogExplanation && dialogActionButton && dialogCancelButton)) {
				reject();
				return;
			}

			overlay.className = 'exist';
			dialogFrame.className = 'exist';
			setTimeout(() => {
				overlay.className = 'exist visible';
				dialogFrame.className = 'exist visible';
			}, 10);
			dialogMessage.innerText = message;
			if (explanation) {
				dialogExplanation.innerText = explanation;
				dialogExplanation.classList.remove('hidden');
			} else {
				dialogExplanation.innerText = '';
				dialogExplanation.classList.add('hidden');
			}
			if (dialogSlot) {
				if (slotHtml) {
					dialogSlot.innerHTML = slotHtml;
					dialogSlot.classList.remove('hidden');
				} else {
					dialogSlot.innerText = '';
					dialogSlot.classList.add('hidden');
				}
			}

			if (dialogActionButton.clickHandler) {
				dialogActionButton.removeEventListener('click', dialogActionButton.clickHandler);
			}
			if (dialogCancelButton.clickHandler) {
				dialogCancelButton.removeEventListener('click', dialogCancelButton.clickHandler);
			}

			dialogActionButton.clickHandler = () => {
				this.hide();
				setTimeout(() => {
					resolve();
				}, 300);
			};
			dialogActionButton.addEventListener('click', dialogActionButton.clickHandler);
			dialogActionButton.innerText = actionCaption;

			if (cancelCaption) {
				dialogCancelButton.clickHandler = () => {
					this.hide();
					setTimeout(() => {
						reject();
					}, 300);
				};
				dialogCancelButton.addEventListener('click', dialogCancelButton.clickHandler);
				dialogCancelButton.innerText = cancelCaption;
			} else {
				dialogCancelButton.className = 'hidden';
			}
		});
	}

	static secureConfirm = (requireMethod, message, explanation = null, actionCaption = 'Ok', cancelCaption = 'Cancel') => {
		return new Promise((resolve, reject) => {
			let confirm;
			switch (requireMethod) {
			case SecureOptionPassword:
				confirm = this.confirm(message, explanation, actionCaption, cancelCaption, '<div class="floating-label"><input type="password" class="text-field" id="dialog_confirm_field" placeholder="Account Password"><label for="dialog_confirm_field">Account Password</label></div>');
				break;
			case SecureOptionAnyAuthenticator:
				confirm = this.confirm(message, explanation, actionCaption, cancelCaption, '<div class="floating-label"><input type="text" class="text-field" id="dialog_confirm_field" placeholder="Two Step Code"><label for="dialog_confirm_field">Two Step Code</label></div>');
				break;
			default:
				console.log(`Unknown security option ${requireMethod}`);
				reject('Unknown security option');
			}

			confirm.then(() => {
				const confirmField = document.getElementById('dialog_confirm_field');
				resolve(confirmField.value);
			}).catch(() => {
				reject();
			});
		});
	};

	static hide() {
		var overlay = document.getElementById('overlay');
		var dialogFrame = document.getElementById('dialog');
		if (!(overlay && dialogFrame)) {
			return;
		}
		overlay.className = 'exist';
		dialogFrame.className = 'exist';
		setTimeout(() => {
			overlay.className = '';
			dialogFrame.className = '';
		}, 300);
	}

	static showModal(elementId) {
		if (this.activeModal) {
			return;
		}

		const overlay = document.getElementById('overlay');
		const modal = document.getElementById(elementId);
		if (!(overlay && modal)) {
			return;
		}

		overlay.classList.add('exist');
		modal.classList.add('exist');
		this.activeModal = elementId;

		setTimeout(() => {
			overlay.classList.add('visible');
			modal.classList.add('visible');
		}, 10);

		this.viewportWatcher = setInterval(() => {
			if (!this.activeModal) {
				return;
			}

			const contentAreas = document.querySelectorAll(`#${this.activeModal} .modal-content .content`);
			contentAreas.forEach((contentArea) => {
				modal.classList.toggle('scrolled', contentArea.scrollHeight > contentArea.clientHeight);
			});

			const viewportHeight = Math.max(document.documentElement.clientHeight || 0, window.innerHeight || 0);
			modal.classList.toggle('centered', modal.clientHeight > viewportHeight * 0.75);
		}, 100);
	}

	static hideModal() {
		return new Promise((resolve, reject) => {
			if (!this.activeModal) {
				reject();
				return;
			}

			const overlay = document.getElementById('overlay');
			const modal = document.getElementById(this.activeModal);
			if (!(overlay && modal)) {
				reject();
				return;
			}

			if (this.viewportWatcher) {
				clearInterval(this.viewportWatcher);
				this.viewportWatcher = null;
			}

			overlay.classList.remove('visible');
			modal.classList.remove('visible');

			setTimeout(() => {
				overlay.classList.remove('exist');
				modal.classList.remove('exist');
				this.activeModal = null;
				resolve();
			}, 300);
		});
	}
}

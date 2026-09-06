export const SecureOptionPassword = 1;
export const SecureOptionAnyAuthenticator = 2;
export const SecureOptionPasskeys = 4;

import { BeaconWebRequest } from "./BeaconWebRequest.js";
import { testPasskeySupport, verifyPasskey } from "../common.js";

export class BeaconDialog {
	static activeModal = null;
	static viewportWatcher = null;

	static show(message, explanation = null, actionCaption = 'Ok') {
		return this.confirm(message, explanation, actionCaption, null);
	}

	static confirm(message, explanation = null, actionCaption = 'Ok', cancelCaption = 'Cancel', slotNode = null) {
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
				dialogSlot.replaceChildren();
				if (slotNode) {
					dialogSlot.appendChild(slotNode);
					dialogSlot.classList.remove('hidden');
				} else {
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
					}, 200);
				};
				dialogCancelButton.addEventListener('click', dialogCancelButton.clickHandler);
				dialogCancelButton.innerText = cancelCaption;
				dialogCancelButton.classList.remove('hidden');
			} else {
				dialogCancelButton.classList.add('hidden');
			}
		});
	}

	static secureConfirm = (availableMethods, message, explanation = null, actionCaption = 'Ok', cancelCaption = 'Cancel') => {
		return new Promise(async (resolve, reject) => {
			const verifyValues = {};
			const optionNodes = [];
			if ((availableMethods & SecureOptionAnyAuthenticator) === SecureOptionAnyAuthenticator) {
				const floatingLabel = document.createElement('div');
				floatingLabel.classList.add('floating-label');

				const field = document.createElement('input');
				field.classList.add('text-field');
				field.setAttribute('id', 'dialog_confirm_totp');
				field.setAttribute('type', 'text');
				field.setAttribute('placeholder', 'Two Step Code');
				field.setAttribute('autocomplete', 'one-time-code');

				const label = document.createElement('label');
				label.setAttribute('for', field.getAttribute('id'));
				label.appendChild(document.createTextNode(field.getAttribute('placeholder')));

				floatingLabel.appendChild(field);
				floatingLabel.appendChild(label);
				optionNodes.push(floatingLabel);
			} else if ((availableMethods & SecureOptionPassword) === SecureOptionPassword) {
				const floatingLabel = document.createElement('div');
				floatingLabel.classList.add('floating-label');

				const field = document.createElement('input');
				field.classList.add('text-field');
				field.setAttribute('id', 'dialog_confirm_password');
				field.setAttribute('type', 'password');
				field.setAttribute('placeholder', 'Account Password');
				field.setAttribute('autocomplete', 'current-password');

				const label = document.createElement('label');
				label.setAttribute('for', field.getAttribute('id'));
				label.appendChild(document.createTextNode(field.getAttribute('placeholder')));

				floatingLabel.appendChild(field);
				floatingLabel.appendChild(label);
				optionNodes.push(floatingLabel);
			}
			if ((availableMethods & SecureOptionPasskeys) === SecureOptionPasskeys) {
				const supported = await testPasskeySupport();
				if (supported) {
					const button = document.createElement('button');
					button.classList.add('blue');
					button.appendChild(document.createTextNode('Verify With Passkey'));
					button.addEventListener('click', (ev) => {
						ev.preventDefault();

						verifyPasskey('/account/actions/verifyIdentity').then(({verified, response}) => {
							if (verified) {
								this.hide().then(() => {
									resolve({
										challenge: response.identityChallenge,
										requestValues: {},
									});
								});
							}
						}).catch(() => {
							this.hide();
							reject();
						});
					});
					optionNodes.push(button);
				}
			}

			if (optionNodes.length > 0) {
				const nodes = document.createElement('div');
				nodes.classList.add('dialog_confirm_options');

				optionNodes.forEach((node) => {
					const optionNode = document.createElement('div');
					optionNode.classList.add('dialog_confirm_option');
					optionNode.appendChild(node);
					nodes.appendChild(optionNode);

					const separator = document.createElement('div');
					separator.classList.add('dialog_confirm_or');
					separator.appendChild(document.createTextNode('Or'));
					nodes.appendChild(separator);
				});
				nodes.removeChild(nodes.lastChild); // Remove the trailing separator

				try {
					await this.confirm(message, explanation, actionCaption, cancelCaption, nodes);

					const totpField = document.getElementById('dialog_confirm_totp');
					if (totpField) {
						verifyValues.verificationCode = totpField.value.trim();
					}

					const passwordField = document.getElementById('dialog_confirm_password');
					if (passwordField) {
						verifyValues.password = passwordField.value;
					}
				} catch {
					reject();
					return;
				}
			}

			try {
				const response = await BeaconWebRequest.post('/account/actions/verifyIdentity', verifyValues);
				const responseValues = JSON.parse(response.body);
				resolve({
					challenge: responseValues.identityChallenge,
					requestValues: verifyValues,
				});
				return;
			} catch {
				await this.show('Identity verification failed', 'Beacon was unable to verify your identity. You are welcome to try again.');
				reject();
			}
		});
	};

	static hide() {
		return new Promise((resolve) => {
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
				resolve();
			}, 200);
		});
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

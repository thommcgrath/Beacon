export const SecureOptionPassword = 1;
export const SecureOptionAnyAuthenticator = 2;
export const SecureOptionPasskeys = 4;
export const SecureOptionForcePassword = 8;
export const SecureOptionUseSecret = 16;

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

	static secureConfirm = (availableMethods, jobName, message, explanation = null, actionCaption = 'Ok', cancelCaption = 'Cancel') => {
		return new Promise(async (resolve, reject) => {
			const verifyValues = {jobName};
			const passwordRequired = (availableMethods & SecureOptionForcePassword) === SecureOptionForcePassword
			const withTOTP = (availableMethods & SecureOptionAnyAuthenticator) === SecureOptionAnyAuthenticator;
			const withPassword = ((availableMethods & SecureOptionPassword) === SecureOptionPassword && withTOTP === false) || passwordRequired;
			const withPasskeys = (availableMethods & SecureOptionPasskeys) === SecureOptionPasskeys;
			const useSecretTerminology = withPassword && (availableMethods & SecureOptionUseSecret) === SecureOptionUseSecret;

			let identityChallenge, passwordNode, totpNode, passkeyNode;

			if (withPassword) {
				const floatingLabel = document.createElement('div');
				floatingLabel.classList.add('floating-label');
				floatingLabel.classList.add('m-0');

				const field = document.createElement('input');
				field.classList.add('text-field');
				field.setAttribute('id', 'dialog_confirm_password');
				field.setAttribute('type', 'password');
				if (useSecretTerminology) {
					field.setAttribute('placeholder', 'Account Secret');
				} else {
					field.setAttribute('placeholder', 'Account Password');
				}
				field.setAttribute('autocomplete', 'current-password');

				const label = document.createElement('label');
				label.setAttribute('for', field.getAttribute('id'));
				label.appendChild(document.createTextNode(field.getAttribute('placeholder')));

				floatingLabel.appendChild(field);
				floatingLabel.appendChild(label);
				passwordNode = floatingLabel;
			}
			if (withTOTP) {
				const floatingLabel = document.createElement('div');
				floatingLabel.classList.add('floating-label');
				floatingLabel.classList.add('m-0');

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
				totpNode = floatingLabel;
			}
			if (withPasskeys) {
				const supported = await testPasskeySupport();
				if (supported) {
					const button = document.createElement('button');
					button.classList.add('blue');
					button.appendChild(document.createTextNode('Verify With Passkey'));
					button.addEventListener('click', (ev) => {
						ev.preventDefault();

						verifyPasskey('/account/actions/verifyIdentity', {jobName}).then(({verified, response}) => {
							if (verified) {
								if (passwordRequired) {
									identityChallenge = response.identityChallenge;
									ev.target.disabled = true;
									ev.target.innerText = 'Verified';

									if (totpNode) {
										totpNode.firstChild.value = '';
										totpNode.firstChild.disabled = true;
									}
								} else {
									this.hide().then(() => {
										resolve({
											challenge: response.identityChallenge,
											requestValues: {},
										});
									});
								}
							}
						}).catch(() => {
							console.log('Verify rejected');
							this.hide();
							reject();
						});
					});

					const wrapper = document.createElement('div');
					wrapper.classList.add('m-0');
					wrapper.classList.add('text-center');
					wrapper.appendChild(button);
					passkeyNode = wrapper;
				}
			}

			// AND is outer, OR is inner
			// [password, [totp, passkey]] = password AND (totp or passkey)
			// [[totp, passkey]] = totp or passkey
			const andNodes = [];
			if (withPassword && withTOTP) {
				andNodes.push(passwordNode);
				if (withPasskeys) {
					andNodes.push([totpNode, passkeyNode]);
				} else {
					andNodes.push(totpNode);
				}
			} else {
				const orNodes = [];
				if (passwordNode) {
					orNodes.push(passwordNode);
				}
				if (totpNode) {
					orNodes.push(totpNode);
				}
				if (passkeyNode) {
					orNodes.push(passkeyNode);
				}
				andNodes.push(orNodes);
			}

			const buildOptionGroup = (sourceNodes, destinationNodes, separatorText) => {
				const group = document.createElement('div');
				group.classList.add('dialog_confirm_group');

				for (let idx = 0; idx < sourceNodes.length; idx++) {
					if (idx > 0) {
						const separator = document.createElement('div');
						separator.classList.add('dialog_confirm_or');
						separator.appendChild(document.createTextNode(separatorText));
						group.appendChild(separator);
					}

					const sourceNode = sourceNodes[idx];
					if (Array.isArray(sourceNode)) {
						buildOptionGroup(sourceNode, group, 'Or');
					} else {
						const optionNode = document.createElement('div');
						optionNode.classList.add('dialog_confirm_option');
						optionNode.appendChild(sourceNode);
						group.appendChild(optionNode);
					}
				}

				destinationNodes.appendChild(group);
			};

			if (andNodes.length > 0) {
				const nodes = document.createElement('div');
				nodes.classList.add('dialog_confirm_options');

				if (andNodes.length === 1) {
					buildOptionGroup(andNodes[0], nodes, 'Or');
				} else {
					buildOptionGroup(andNodes, nodes, 'And');
				}

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

			if (identityChallenge) {
				// Passkey verification doesn't actually test to make sure the other values are correct
				resolve({
					challenge: identityChallenge,
					requestValues: verifyValues,
				});
				return;
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

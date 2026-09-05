"use strict";

import { BeaconWebRequest } from "./classes/BeaconWebRequest.js";

export const getCurrencyFormatter = (currencyCode) => {
	return Intl.NumberFormat('en-US', {
		style: 'currency',
		currency: currencyCode,
	}).format;
};

export const formatPrices = (defaultCurrency) => {
	const prices = document.querySelectorAll('.formatted-price');
	prices.forEach((elem) => {
		const price = parseFloat(elem.getAttribute('beacon-price') ?? elem.innerText);
		const currency = elem.getAttribute('beacon-currency');
		const formatter = getCurrencyFormatter(currency ?? defaultCurrency);
		if (formatter) {
			elem.innerText = formatter(price);
		}
	});
};

export const epochToDate = (epoch) => {
	return new Date(epoch * 1000);
};

export const formatDate = (date, withTime = false, withTimeZone = false) => {
	const resolvedOptions = Intl.DateTimeFormat().resolvedOptions();
	const options = {
		dateStyle: 'medium',
	};
	if (withTime) {
		options.timeStyle = 'short';
	}
	let formatted = Intl.DateTimeFormat(resolvedOptions.locale, options).format(date);
	if (withTimeZone) {
		formatted = `${formatted} ${resolvedOptions.timeZone}`;
	}
	return formatted;
};

export const formatDates = (withTime = false, withTimeZone = false) => {
	const timeElements = document.querySelectorAll('time');
	timeElements.forEach((elem) => {
		const timestamp = new Date(elem.getAttribute('datetime'));
		elem.innerText = formatDate(timestamp, withTime, withTimeZone);
	});
};

export const randomUUID = () => {
	if (crypto.randomUUID) {
		return crypto.randomUUID();
	} else {
		return ([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g, c => (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16));
	}
};

export const readFile = (file) => {
	return new Promise((resolve, reject) => {
		const reader = new FileReader();
		reader.onload = () => {
			resolve(reader.result);
		};
		reader.onerror = reject;
		reader.readAsBinaryString(file);
	});
};

export const recursiveBase64StrToArrayBuffer = (obj) => {
	switch (typeof obj) {
	case 'object':
		if (Array.isArray(obj)) {
			return obj.reduce((newArray, value) => {
				newArray.push(recursiveBase64StrToArrayBuffer(value));
				return newArray;
			}, []);
		} else {
			return Object.keys(obj).reduce((newObj, key) => {
				newObj[key] = recursiveBase64StrToArrayBuffer(obj[key]);
				return newObj;
			}, {});
		}
	case 'string':
		const prefix = '=?BINARY?B?';
		const suffix = '?=';

		if (obj.startsWith(prefix) === false || obj.endsWith(suffix) === false) {
			return obj;
		}

		const binaryString = window.atob(obj.substring(prefix.length, obj.length - suffix.length));
		const length = binaryString.length;
		const bytes = new Uint8Array(length);
		for (let idx = 0; idx < length; idx++) {
			bytes[idx] = binaryString.charCodeAt(idx);
		}
		return bytes.buffer;
	default:
		return obj;
	}
};

export const arrayBufferToBase64 = (buffer) => {
	let binary = '';
	const bytes = new Uint8Array(buffer);
	const len = bytes.byteLength;
	for (let i = 0; i < len; i++) {
		binary += String.fromCharCode(bytes[i]);
	}
	return window.btoa(binary);
};

export const testPasskeySupport = () => {
	return new Promise((resolve) => {
		if (window.PublicKeyCredential && PublicKeyCredential.getClientCapabilities) {
			PublicKeyCredential.getClientCapabilities().then((capabilities) => {
				if (capabilities.conditionalGet === true && capabilities.passkeyPlatformAuthenticator === true) {
					resolve(true);
				}
			}).catch(() => {
				resolve(false);
			});
		} else {
			resolve(false);
		}
	});
};

export const verifyPasskey = () => {
	return new Promise((resolve, reject) => {
		BeaconWebRequest.get('/account/auth/passkeyOptions').then((initResponse) => {
			if (!initResponse.success) {
				reject({message: initResponse.message});
				return;
			}

			const rawOptions = JSON.parse(initResponse.body);
			const options = recursiveBase64StrToArrayBuffer(rawOptions);
			navigator.credentials.get(options).then((passkey) => {
				const authenticatorAttestationResponse = {
					id: passkey.rawId ? arrayBufferToBase64(passkey.rawId) : null,
					clientDataJSON: passkey.response.clientDataJSON  ? arrayBufferToBase64(passkey.response.clientDataJSON) : null,
					authenticatorData: passkey.response.authenticatorData ? arrayBufferToBase64(passkey.response.authenticatorData) : null,
					signature: passkey.response.signature ? arrayBufferToBase64(passkey.response.signature) : null,
					userHandle: passkey.response.userHandle ? arrayBufferToBase64(passkey.response.userHandle) : null
				}

				BeaconWebRequest.post('/account/auth/passkeyVerify', authenticatorAttestationResponse).then((verifyResponse) => {
					if (!verifyResponse.success) {
						if (PublicKeyCredential.signalUnknownCredential) {
							PublicKeyCredential.signalUnknownCredential({
								rpId: rawOptions.rp.id,
								credentialId: passkey.id,
							}).then(() => {
								resolve({verified: false});
							});
						} else {
							resolve({verified: false});
							return;
						}
						return;
					}

					const session = JSON.parse(verifyResponse.body);
					resolve({verified: true, session: session});
				}).catch((err) => {
					reject(err);
				});
			}).catch((err) => {
				reject(err);
			});
		}).catch((err) => {
			reject(err);
		});
	});
};

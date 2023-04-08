"use strict";

document.addEventListener('GlobalizeLoaded', () => {
	const pageLanding = document.getElementById('page_landing');
	const pageCart = document.getElementById('page_cart');
	const stwQuantityField = document.getElementById('stw_quantity_field');
	const arkGiftQuantityField = document.getElementById('ark_gift_quantity_field');
	const arkCheckbox = document.getElementById('ark_checkbox');
	const arkCheckboxFrame = document.getElementById('ark_checkbox_frame');
	const arkOwnedCaption = document.getElementById('ark_owned_caption');
	const ark2GiftQuantityField = document.getElementById('ark2_gift_quantity_field');
	const ark2Checkbox = document.getElementById('ark2_checkbox');
	const ark2ActiveLicenseCaption = document.getElementById('ark2-activelicense');
	const arkSAGiftQuantityField = document.getElementById('arksa_gift_quantity_field');
	const arkSAQuantityField = document.getElementById('arksa_quantity_field');
	const arkSAActiveLicenseCaption = document.getElementById('arksa-activelicense');
	const arkSAUpgradeCaption = document.getElementById('arksa-upgrade');
	const buyButton = document.getElementById('buy-button');
	const cartBackButton = document.getElementById('cart_back_button');
	const stripeCheckoutButton = document.getElementById('stripe_checkout_button');
	const emailField = document.getElementById('checkout_email_field');
	const totalField = document.getElementById('total_field');
	const currencyMenu = document.getElementById('currency-menu');
	const requiredPageElements = [pageLanding, pageCart, stwQuantityField, arkGiftQuantityField, arkCheckbox, arkCheckboxFrame, arkOwnedCaption, buyButton, cartBackButton, stripeCheckoutButton, emailField, totalField, currencyMenu];
	if (requiredPageElements.includes(null)) {
		console.log('Missing page elements');
		return false;
	}
	
	const setViewMode = () => {
		window.scrollTo(window.scrollX, 0);
		if (window.location.hash === '#checkout') {
			pageLanding.classList.add('hidden');
			pageCart.classList.remove('hidden');
		} else {
			pageLanding.classList.remove('hidden');
			pageCart.classList.add('hidden');
		}
	};
	
	const globalize = Globalize('en');
	const currencyFormatter = globalize.currencyFormatter(currencyCode);
	
	const status = {
		checkingEmail: false,
		ownsArk: false,
		ownsArk2: false,
		ownsArkSA: false
	}
	
	const updateTotal = () => {
		const includeArk = status.ownsArk === false && arkCheckbox.checked;
		const stwQuantity = Math.max(Math.min(stwQuantityField.value, 10), 0);
		const arkGiftQuantity = Math.max(Math.min(arkGiftQuantityField.value, 10), 0);
		
		if (stwQuantityField.value != stwQuantity) {
			stwQuantityField.value = stwQuantity;
		}
		if (arkGiftQuantityField.value != arkGiftQuantity) {
			arkGiftQuantityField.value = arkGiftQuantity;
		}
		
		let total = (stwPrice * stwQuantity) + (arkGiftPrice * arkGiftQuantity);
		if (includeArk) {
			total += arkPrice;
		}
		
		if (ark2GiftQuantityField && ark2Checkbox && ark2ActiveLicenseCaption) {
			const includeArk2 = ark2Checkbox.checked;
			const ark2GiftQuantity = Math.max(Math.min(ark2GiftQuantityField.value, 10), 0);
			
			if (ark2GiftQuantityField.value != ark2GiftQuantity) {
				ark2GiftQuantityField.value = ark2GiftQuantity;
			}
			
			total += (ark2GiftPrice * ark2GiftQuantity);
			if (includeArk2) {
				total += ark2Price;
			}
		}
		
		if (arkSAQuantityField && arkSAGiftQuantityField && arkSAActiveLicenseCaption && arkSAUpgradeCaption) {
			const arkSAQuantity = Math.max(Math.min(arkSAQuantityField.value, 10), 0);
			const arkSAGiftQuantity = Math.max(Math.min(arkSAGiftQuantityField.value, 10), 0);
			
			if (arkSAQuantityField.value != arkSAQuantity) {
				arkSAQuantityField.value = arkSAQuantity;
			}
			if (arkSAGiftQuantityField.value != arkSAGiftQuantity) {
				arkSAGiftQuantityField.value = arkSAGiftQuantity;
			}
			
			const firstYearPrice = (status.ownsArk || status.ownsArkSA) ? (arkSAPrice / 2) : arkSAPrice;
			const additionalYearPrice = arkSAPrice / 2;
			const firstYear = Math.min(Math.max(arkSAQuantity, 0), 1);
			const additionalYears = Math.max(arkSAQuantity - 1, 0);
			
			total += (firstYearPrice * firstYear) + (additionalYearPrice * additionalYears) + (arkSAGiftQuantity * arkSAGiftPrice);
		}
		
		totalField.innerHTML = formatCurrency(total);
		stripeCheckoutButton.disabled = (total == 0) || status.checkingEmail || validateEmail(emailField.value) == false;
	};
	
	const formatCurrency = (amount) => {
		return currencyFormatter(amount);
	};
	
	const updateCheckoutComponents = () => {
		if (status.ownsArk) {
			arkCheckboxFrame.classList.add('hidden');
			arkOwnedCaption.classList.remove('hidden');
		} else {
			arkCheckboxFrame.classList.remove('hidden');
			arkOwnedCaption.classList.add('hidden');
		}
		if (ark2ActiveLicenseCaption) {
			if (status.ownsArk2) {
				ark2ActiveLicenseCaption.classList.remove('hidden');
			} else {
				ark2ActiveLicenseCaption.classList.add('hidden');
			}
		}
		updateTotal();
	};
	
	const validateEmail = (email) => {
		const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		return re.test(String(email).trim().toLowerCase());
	};
	
	const lookupEmail = (email) => {
		const processPurchases = (purchases) => {
			status.ownsArk = false;
			status.ownsArk2 = false;
			
			for (const purchase of purchases) {
				switch (purchase.product_id) {
				case arkProductId:
					status.ownsArk = true;
					break;
				case ark2ProductId:
					status.ownsArk2 = true;
					break;
				}
			}
			updateCheckoutComponents();
		};
		
		status.checkingEmail = true;
		updateCheckoutComponents();
		if (validateEmail(email)) {
			const params = new URLSearchParams();
			params.append('email', email);
			
			BeaconWebRequest.get(`/omni/lookup?${params.toString()}`).then((response) => {
				status.checkingEmail = false;
				try {
					const obj = JSON.parse(response.body);
					processPurchases(obj.purchases);
				} catch (e) {
					console.log(e);
					processPurchases([]);
				}
			}).catch((error) => {
				status.checkingEmail = false;
				processPurchases([]);
			}); 
		} else {
			status.checkingEmail = false;
			processPurchases([]);
		}
	};
	
	const formatPrices = () => {
		const prices = document.querySelectorAll('td.price_column');
		prices.forEach((cell) => {
			const price = parseFloat(cell.getAttribute('beacon-price'));
			cell.innerText = formatCurrency(price);
		});
	};
	
	formatPrices();
	updateCheckoutComponents();
	setViewMode();
	
	buyButton.addEventListener('click', (ev) => {
		history.pushState({}, '', '/omni/#checkout');
		dispatchEvent(new PopStateEvent('popstate', {}));
		ev.preventDefault();
	});
	
	cartBackButton.addEventListener('click', (ev) => {
		history.pushState({}, '', '/omni/');
		dispatchEvent(new PopStateEvent('popstate', {}));
		ev.preventDefault();
	});
	
	const quantityFields = [
		stwQuantityField,
		arkGiftQuantityField,
		ark2GiftQuantityField,
		arkSAQuantityField,
		arkSAGiftQuantityField
	];
	for (const quantityField of quantityFields) {
		if (quantityField) {
			quantityField.addEventListener('input', (ev) => {
				updateTotal();
			});
		}
	}
	
	arkCheckbox.addEventListener('change', (ev) => {
		updateTotal();
	});
	
	if (ark2Checkbox) {
		ark2Checkbox.addEventListener('change', (ev) => {
			updateTotal();
		});
	}
	
	stripeCheckoutButton.addEventListener('click', (ev) => {
		ev.target.disabled = true;
		
		const includeArk = status.ownsArk === false && arkCheckbox.checked;
		const stwQuantity = Math.max(Math.min(stwQuantityField.value, 10), 0);
		const arkGiftQuantity = Math.max(Math.min(arkGiftQuantityField.value, 10), 0);
		const includeArk2 = ark2Checkbox && ark2Checkbox.checked;
		const ark2GiftQuantity = ark2GiftQuantityField && Math.max(Math.min(ark2GiftQuantityField.value, 10), 0);
		
		const params = new URLSearchParams();
		params.append('email', emailField.value);
		params.append('ark', includeArk);
		params.append('ark2', includeArk2);
		params.append('ark_gift', arkGiftQuantity);
		params.append('ark2_gift', ark2GiftQuantity);
		params.append('stw', stwQuantity);
		
		BeaconWebRequest.post('/omni/begin', params).then((response) => {
			try {
				const obj = JSON.parse(response.body);
				if (sessionStorage) {
					sessionStorage.setItem('client_reference_id', obj.client_reference_id);
				}
				
				window.location.href = obj.url;
			} catch (e) {
				console.log(e);
				BeaconDialog.Show('There was an error starting the checkout process.', e.message);
			}
		}).catch((error) => {
			let message = error.body;
			try {
				const obj = JSON.parse(message);
				if (obj.message) {
					message = obj.message;
				}
			} catch (e) {
				console.log(e);
			}
			BeaconDialog.show('There was an error starting the checkout process.', message);
			ev.target.disabled = false;
		});
	});
	
	emailField.addEventListener('input', (ev) => {
		if (emailField.timer) {
			clearTimeout(emailField.timer);
		}
		
		emailField.timer = setTimeout(() => {
			lookupEmail(emailField.value);
			updateTotal();
		}, 250);
	});
	
	const email = sessionStorage?.getItem('email') ?? localStorage?.getItem('email') ?? null;
	if (email) {
		emailField.value = email;
		lookupEmail(email);
	}
	
	currencyMenu.addEventListener('change', (ev) => {
		const params = new URLSearchParams();
		params.append('currency', ev.target.value);
		BeaconWebRequest.get(`/omni/currency?${params.toString()}`).then((response) => {
			location.reload();
		}).catch((error) => {
			BeaconDialog.show('Sorry, there was a problem setting the currency.', error.body);
		});
		
		return false;
	});
	
	const currencyLinks = document.querySelectorAll('.currency-button');
	for (const link of currencyLinks) {
		link.addEventListener('click', (ev) => {
			ev.preventDefault();
			
			const linkCurrency = ev.target.getAttribute('currency');
			const params = new URLSearchParams();
			params.append('currency', linkCurrency);
			BeaconWebRequest.get(`/omni/currency?${params.toString()}`).then((response) => {
				location.reload();
			}).catch((error) => {
				BeaconDialog.show('Sorry, there was a problem setting the currency.', error.body);
			});
			
			return false;
		});
	}
	
	window.addEventListener('popstate', (ev) => {
		setViewMode();
	});
});
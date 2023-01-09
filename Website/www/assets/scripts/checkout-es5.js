"use strict";

document.addEventListener('DOMContentLoaded', () => {
  var _ref, _sessionStorage$getIt, _sessionStorage, _localStorage;
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
  const buyButton = document.getElementById('buy-button');
  const cartBackButton = document.getElementById('cart_back_button');
  const stripeCheckoutButton = document.getElementById('stripe_checkout_button');
  const emailField = document.getElementById('checkout_email_field');
  const totalField = document.getElementById('total_field');
  const requiredPageElements = [pageLanding, pageCart, stwQuantityField, arkGiftQuantityField, arkCheckbox, arkCheckboxFrame, arkOwnedCaption, buyButton, cartBackButton, stripeCheckoutButton, emailField, totalField];
  if (requiredPageElements.includes(null)) {
	console.log('Missing page elements');
	return false;
  }
  const status = {
	checkingEmail: false,
	ownsArk: false,
	ownsArk2: false
  };
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
	let total = stwPrice * stwQuantity + arkGiftPrice * arkGiftQuantity;
	if (includeArk) {
	  total += arkPrice;
	}
	if (ark2GiftQuantityField && ark2Checkbox && ark2ActiveLicenseCaption) {
	  const includeArk2 = ark2Checkbox.checked;
	  const ark2GiftQuantity = Math.max(Math.min(ark2GiftQuantityField.value, 10), 0);
	  if (ark2GiftQuantityField.value != ark2GiftQuantity) {
		ark2GiftQuantityField.value = ark2GiftQuantity;
	  }
	  total += ark2GiftPrice * ark2GiftQuantity;
	  if (includeArk2) {
		total += ark2Price;
	  }
	}
	const formattedTotal = formatCurrency(total);
	totalField.innerHTML = `${currencySymbol}${formattedTotal} ${currencyCode}`;
	stripeCheckoutButton.disabled = total == 0 || status.checkingEmail || validateEmail(emailField.value) == false;
  };
  const formatCurrency = amount => {
	let adjustedAmount = Math.round(amount * 100).toString();
	if (adjustedAmount.length < 3) {
	  adjustedAmount = '000'.substr(adjustedAmount.length) + adjustedAmount;
	}
	const decimals = adjustedAmount.substr(adjustedAmount.length - 2, 2);
	const whole = adjustedAmount.substr(0, adjustedAmount.length - 2);
	return whole + decimalCharacter + decimals;
  };
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
  const validateEmail = email => {
	const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	return re.test(String(email).trim().toLowerCase());
  };
  const lookupEmail = email => {
	const processPurchases = purchases => {
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
	  BeaconWebRequest.get(`/omni/lookup?${params.toString()}`).then(response => {
		status.checkingEmail = false;
		try {
		  const obj = JSON.parse(response.body);
		  processPurchases(obj.purchases);
		} catch (e) {
		  console.log(e);
		  processPurchases([]);
		}
	  }).catch(error => {
		status.checkingEmail = false;
		processPurchases([]);
	  });
	} else {
	  status.checkingEmail = false;
	  processPurchases([]);
	}
  };
  updateCheckoutComponents();
  setViewMode();
  buyButton.addEventListener('click', ev => {
	history.pushState({}, '', '/omni/#checkout');
	dispatchEvent(new PopStateEvent('popstate', {}));
	ev.preventDefault();
  });
  cartBackButton.addEventListener('click', ev => {
	history.pushState({}, '', '/omni/');
	dispatchEvent(new PopStateEvent('popstate', {}));
	ev.preventDefault();
  });
  stwQuantityField.addEventListener('input', ev => {
	updateTotal();
  });
  arkGiftQuantityField.addEventListener('input', ev => {
	updateTotal();
  });
  arkCheckbox.addEventListener('change', ev => {
	updateTotal();
  });
  if (ark2GiftQuantityField) {
	ark2GiftQuantityField.addEventListener('input', ev => {
	  updateTotal();
	});
  }
  if (ark2Checkbox) {
	ark2Checkbox.addEventListener('change', ev => {
	  updateTotal();
	});
  }
  stripeCheckoutButton.addEventListener('click', ev => {
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
	BeaconWebRequest.post('/omni/begin', params).then(response => {
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
	}).catch(error => {
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
  emailField.addEventListener('input', ev => {
	if (emailField.timer) {
	  clearTimeout(emailField.timer);
	}
	emailField.timer = setTimeout(() => {
	  lookupEmail(emailField.value);
	  updateTotal();
	}, 250);
  });
  const email = (_ref = (_sessionStorage$getIt = (_sessionStorage = sessionStorage) === null || _sessionStorage === void 0 ? void 0 : _sessionStorage.getItem('email')) !== null && _sessionStorage$getIt !== void 0 ? _sessionStorage$getIt : (_localStorage = localStorage) === null || _localStorage === void 0 ? void 0 : _localStorage.getItem('email')) !== null && _ref !== void 0 ? _ref : null;
  if (email) {
	emailField.value = email;
	lookupEmail(email);
  }
  const currencyLinks = document.querySelectorAll('.currency-button');
  for (const link of currencyLinks) {
	link.addEventListener('click', ev => {
	  ev.preventDefault();
	  const linkCurrency = ev.target.getAttribute('currency');
	  const params = new URLSearchParams();
	  params.append('currency', linkCurrency);
	  BeaconWebRequest.get(`/omni/currency?${params.toString()}`).then(response => {
		location.reload();
	  }).catch(error => {
		BeaconDialog.show('Sorry, there was a problem setting the currency.', error.body);
	  });
	  return false;
	});
  }
  window.addEventListener('popstate', ev => {
	setViewMode();
  });
});
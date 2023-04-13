"use strict";

const StatusOwns = 'owns'; // User has a license for the item
const StatusBuying = 'buying'; // The user is buying it in this cart item
const StatusInCart = 'in-cart'; // The user has it in their cart elsewhere
const StatusNone = 'none';

const validateEmail = (email) => {
	const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	return re.test(String(email).trim().toLowerCase());
};

class BeaconCartItem {
	#id = null;
	#products = {};
	#isGift = false;
	
	constructor(config) {
		if (config) {
			this.#id = config.id;
			this.#products = config.products;
			this.#isGift = config.isGift;
		} else {
			this.#id = crypto.randomUUID();
		}
	}
	
	get id() {
		return this.#id;
	}
	
	get isGift() {
		return this.#isGift;
	}
	
	set isGift(newValue) {
		this.#isGift = newValue;
	}
	
	get productIds() {
		return Object.keys(this.#products);
	}
	
	get count() {
		return Object.keys(this.#products).length;
	}
	
	reset() {
		this.#products = {};
	}
	
	add(productId, quantity) {
		this.setQuantity(productId, this.getQuantity(productId) + quantity);
	}
	
	remove(productId, quantity) {
		this.setQuantity(productId, this.getQuantity(productId) - quantity);
	}
	
	getQuantity(productId) {
		return this.#products[productId] ?? 0;
	}
	
	setQuantity(productId, quantity) {
		if (quantity <= 0) {
			if (this.#products.hasOwnProperty(productId)) {
				delete this.#products[productId];
			}
		} else {
			this.#products[productId] = quantity;
		}
	}
	
	toJSON() {
		return {
			id: this.#id,
			products: this.#products,
			isGift: this.#isGift
		};
	}
	
	get hasArk() {
		return this.getQuantity(Products?.Ark?.Base?.ProductId) > 0;
	}
	
	get hasArkSA() {
		return this.getQuantity(Products?.ArkSA?.Base?.ProductId) > 0 || this.getQuantity(Products?.ArkSA?.Upgrade?.ProductId) > 0;
	}
}

class BeaconCart {
	#items = [];
	#email = null;
	#emailVerified = false;
	#licenses = [];
	
	emailChanged = (email) => {};
	
	constructor(saved = null) {
		if (saved) {
			try {
				const parsed = JSON.parse(saved);
				this.#email = parsed.email;
				this.#items = parsed.items.reduce((items, savedItem) => {
					const cartItem = new BeaconCartItem(savedItem);
					if (cartItem.count > 0) {
						items.push(cartItem);
					}
					return items;
				}, []);
				this.#licenses = parsed.licenses;
			} catch (e) {
				console.log('Failed to load saved cart');
			}
		}
	}
	
	reset() {
		this.#items = [];
		this.#email = null;
		this.#emailVerified = false;
		this.#licenses = [];
		this.save();
	}
	
	toJSON() {
		return {
			email: this.#email,
			items: this.#items.reduce((items, cartItem) => {
				if (cartItem.count > 0) {
					items.push(cartItem);
				}
				return items
			}, []),
			licenses: this.#licenses
		};
	}
	
	save() {
		localStorage.setItem('beacon-cart', JSON.stringify(this));
	}
	
	static load() {
		return new this(localStorage.getItem('beacon-cart'));
	}
	
	add(item) {
		this.#items.push(item);
		this.save();
	}
	
	remove(item) {
		this.#items = this.#items.filter((cartItem) => cartItem.id !== item.id);
		this.save();
	}
	
	hasProduct(productId, isGift = false) {
		for (const lineItem of this.#items) {
			if (lineItem.getQuantity(productId) > 0 && lineItem.isGift === isGift) {
				return true;
			}
		}
		return false;
	}
	
	get email() {
		return this.#email;
	}
	
	setEmail(newEmail) {
		return new Promise((resolve, reject) => {
			if (newEmail === this.#email) {
				resolve(newEmail);
				return;
			}
			
			if (!validateEmail(newEmail)) {
				reject('Address is not valid');
				return;
			}
			
			const params = new URLSearchParams();
			params.append('email', newEmail);
			
			BeaconWebRequest.get(`/omni/lookup?${params.toString()}`).then((response) => {
				const info = JSON.parse(response.body);
				this.#email = info.email;
				this.#emailVerified = info.verified;
				this.#licenses = info.purchases;
				this.save();
				resolve(newEmail);
			}).catch((error) => {
				this.#email = null;
				this.#emailVerified = false;
				this.#licenses = [];
				this.save();
				reject(error.statusText);
			});
		});
	}
	
	get emailVerified() {
		return this.#emailVerified;
	}
	
	get checkingEmail() {
		return false;
	}
	
	get items() {
		return [...this.#items];
	}
	
	get count() {
		return this.#items.reduce((bundles, cartItem) => {
			if (cartItem.count > 0) {
				bundles++;
			}
			return bundles;
		}, 0);
	}
	
	findLicense(productId) {
		for (const license of this.#licenses) {
			if (license.product_id === productId) {
				return license;
			}
		}
		return null;
	}
	
	get arkLicense() {
		return this.findLicense(Products.Ark.Base.ProductId);
	}
	
	get arkSALicense() {
		return this.findLicense(Products.ArkSA.Base.ProductId);
	}
	
	get ark2License() {
		return null;
	}
	
	get personalCartItem() {
		for (const cartItem of this.#items) {
			if (cartItem.isGift === false) {
				return cartItem;
			}
		}
		return null;
	}
}
const cart = BeaconCart.load();

class ViewManager {
	#history = [];
	#timeout = null;
	
	constructor(initialView) {
		this.#history.push(initialView);
	}
	
	get currentView() {
		return this.#history.slice(-1);
	}
	
	back(animated = true) {
		if (this.#history.length <= 1) {
			return false;
		}
		
		this.switchView(this.#history[this.#history.length - 2], animated);
		this.#history = this.#history.slice(0, this.#history.length - 2);
		return true;
	}
	
	clearHistory() {
		if (this.#history.length <= 1) {
			return;
		}
		
		this.#history = this.#history.slice(-1);
	}
	
	switchView(newView, animated = true) {
		if (this.currentView == newView) {
			return;
		}
		
		if (this.#timeout) {
			clearTimeout(this.#timeout);
			this.#timeout = null;
		}
		
		const currentElement = document.getElementById(this.currentView);
		const newElement = document.getElementById(newView);
		this.#history.push(newView);
		
		if (animated) {
			currentElement.classList.add('invisible');
			this.#timeout = setTimeout(() => {
				currentElement.classList.add('hidden');
				newElement.classList.remove('hidden');
				this.#timeout = setTimeout(() => {
					newElement.classList.remove('invisible');
					this.#timeout = null;
				}, 150);
			}, 150);
		} else {
			currentElement.classList.add('hidden');
			currentElement.classList.add('invisible');
			newElement.classList.remove('invisible');
			newElement.classList.remove('hidden');
		}
	}
}
const wizardViewManager = new ViewManager('checkout-wizard-start');
const storeViewManager = new ViewManager('page-landing');

const formatCurrency = (amount) => {
	const formatter = BeaconCurrency.defaultFormatter;
	if (formatter) {
		return formatter(amount);
	} else {
		return amount;
	}
};

let updateCart = () => {};

document.addEventListener('DOMContentLoaded', () => {
	const buyButton = document.getElementById('buy-button');
	const landingButton = document.getElementById('cart-back-button');
	const cartContainer = document.getElementById('storefront-cart');
	const wizard = {
		editCartItem: null,
		start: {
			cancelButton: document.getElementById('checkout-wizard-start-cancel'),
			actionButton: document.getElementById('checkout-wizard-start-action')
		},
		email: {
			cancelButton: document.getElementById('checkout-wizard-email-cancel'),
			actionButton: document.getElementById('checkout-wizard-email-action'),
			emailField: document.getElementById('checkout-wizard-email-field'),
			errorField: document.getElementById('checkout-wizard-email-error')
		},
		game: {
			cancelButton: document.getElementById('checkout-wizard-game-cancel'),
			actionButton: document.getElementById('checkout-wizard-game-action'),
			giftCheck: document.getElementById('checkout-wizard-game-gift-check'),
			arkSACheck: document.getElementById('checkout-wizard-game-arksa-check'),
			arkCheck: document.getElementById('checkout-wizard-game-ark-check'),
			arkPriceField: document.getElementById('checkout-wizard-game-ark-price'),
			arkSAPriceField: document.getElementById('checkout-wizard-game-arksa-full-price'),
			arkSAUpgradePriceField: document.getElementById('checkout-wizard-game-arksa-discount-price'),
			arkSAStatusField: document.getElementById('checkout-wizard-game-status-arksa'),
			arkStatusField: document.getElementById('checkout-wizard-game-status-ark'),
			arkSADurationField: document.getElementById('checkout-wizard-game-arksa-duration-field'),
			arkSADurationSuffixField: document.getElementById('checkout-wizard-game-arksa-duration-suffix-field')
		}
	};
	const cartElements = {
		emailField: document.getElementById('storefront-cart-header-email-field'),
		changeEmailButton: document.getElementById('storefront-cart-header-email-button')
	};
	
	const getGameStatus = () => {
		const gameStatus = {
			Ark: StatusNone,
			ArkSA: StatusNone
		};
		
		const personalCartItem = cart.personalCartItem;
		const isEditing = Boolean(wizard.editCartItem);
		const isGift = wizard.game.giftCheck.checked;
		if (isGift) {
			gameStatus.Ark = wizard.game.arkCheck.disabled == false && wizard.game.arkCheck.checked ? StatusBuying : StatusNone;
			gameStatus.ArkSA = wizard.game.arkSACheck.disabled == false && wizard.game.arkSACheck.checked ? StatusBuying : StatusNone;
		} else {
			if (cart.arkLicense) {
				gameStatus.Ark = StatusOwns;
			} else if (wizard.game.arkCheck.disabled == false && wizard.game.arkCheck.checked) {
				gameStatus.Ark = StatusBuying;
			} else if (personalCartItem && (isEditing === false || personalCartItem.id !== wizard.editCartItem.id) && personalCartItem.hasArk) {
				gameStatus.Ark = StatusInCart;
			} else {
				gameStatus.Ark = StatusNone;
			}
			
			if (cart.arkSALicense) {
				gameStatus.ArkSA = StatusOwns;
			} else if (wizard.game.arkSACheck.disabled == false && wizard.game.arkSACheck.checked) {
				gameStatus.ArkSA = StatusBuying;
			} else if (personalCartItem && (isEditing === false || personalCartItem.id !== wizard.editCartItem.id) && personalCartItem.hasArkSA) {
				gameStatus.ArkSA = StatusInCart;
			} else {
				gameStatus.ArkSA = StatusNone;
			}
		}
		
		return gameStatus;
	};
	
	const updateGamesList = () => {
		const gameStatus = getGameStatus();
		
		let arkSAFullPrice = Products.ArkSA.Base.Price;
		let arkSAEffectivePrice = Products.ArkSA.Base.Price;
		
		const arkSAYears = Math.min(Math.max(parseInt(wizard.game.arkSADurationField.value) || 1, 1), 10);
		wizard.game.arkSADurationSuffixField.innerText = arkSAYears === 1 ? 'Year' : 'Years';
		if (parseInt(wizard.game.arkSADurationField.value) !== arkSAYears) {
			wizard.game.arkSADurationField.value = arkSAYears;
		}
		const arkSAAdditionalYears = Math.max(arkSAYears - 1, 0);
		
		if (gameStatus.ArkSA === StatusOwns) {
			// Show as renewal
			const license = ark.arkSALicense;
			
			arkSAFullPrice = Products.ArkSA.Renewal.Price * arkSAYears;
			arkSAEffectivePrice = arkSAFullPrice;
		} else if (gameStatus.ArkSA === StatusInCart) {
			// Show as renewal
			arkSAFullPrice = Products.ArkSA.Renewal.Price * arkSAYears;
			arkSAEffectivePrice = arkSAFullPrice;
			wizard.game.arkSAStatusField.innerText = `Additional renewal years for ${Products.ArkSA.Base.Name} in your cart.`;
		} else if (gameStatus.Ark !== StatusNone) {
			// Show as upgrade
			const discount = Math.round(((Products.ArkSA.Base.Price - Products.ArkSA.Upgrade.Price) / Products.ArkSA.Base.Price) * 100);
			const discountLanguage = gameStatus.Ark === StatusOwns ? 'because you own' : 'when bundled with';
			
			arkSAFullPrice = Products.ArkSA.Base.Price + (Products.ArkSA.Renewal.Price * arkSAAdditionalYears);
			arkSAEffectivePrice = Products.ArkSA.Upgrade.Price + (Products.ArkSA.Renewal.Price * arkSAAdditionalYears);
			
			wizard.game.arkSAStatusField.innerText = `${discount}% off first year ${discountLanguage} ${Products.Ark.Base.Name}. Additional years cost ${formatCurrency(Products.ArkSA.Renewal.Price)} each.`;
		} else {
			// Show normal
			wizard.game.arkSAStatusField.innerText = `Includes first year of app updates. Additional years cost ${formatCurrency(arkSARenewPrice)} each.`;
			
			arkSAFullPrice = Products.ArkSA.Base.Price + (Products.ArkSA.Renewal.Price * arkSAAdditionalYears);
			arkSAEffectivePrice = arkSAFullPrice;
		}
		
		if (arkSAFullPrice !== arkSAEffectivePrice) {
			wizard.game.arkSAPriceField.classList.add('checkout-wizard-discounted');
			wizard.game.arkSAUpgradePriceField.classList.remove('hidden');
		} else {
			wizard.game.arkSAPriceField.classList.remove('checkout-wizard-discounted');
			wizard.game.arkSAUpgradePriceField.classList.add('hidden');
		}
		
		wizard.game.arkSAPriceField.innerText = formatCurrency(arkSAFullPrice);
		wizard.game.arkSAUpgradePriceField.innerText = formatCurrency(arkSAEffectivePrice);
		
		if (gameStatus.Ark === StatusOwns) {
			wizard.game.arkStatusField.innerText = `You already own ${Products.Ark.Base.Name}.`;
			wizard.game.arkCheck.disabled = true;
			wizard.game.arkCheck.checked = false;
			wizard.game.arkPriceField.classList.add('hidden');
		} else if (gameStatus.Ark === StatusInCart) {
			wizard.game.arkStatusField.innerText = `${Products.Ark.Base.Name} is already in your cart.`;
			wizard.game.arkCheck.disabled = true;
			wizard.game.arkCheck.checked = false;
			wizard.game.arkPriceField.classList.add('hidden');
		} else {
			wizard.game.arkStatusField.innerText = 'Includes lifetime app updates.';
			wizard.game.arkCheck.disabled = false;
			wizard.game.arkPriceField.classList.remove('hidden');
		}
		
		let total = 0;
		if (wizard.game.arkCheck.disabled === false && wizard.game.arkCheck.checked === true) {
			total = total + Products.Ark.Base.Price;
		}
		if (wizard.game.arkSACheck.disabled === false && wizard.game.arkSACheck.checked === true) {
			total = total + arkSAEffectivePrice;
		}
		
		const addToCart = (wizard.editCartItem) ? 'Edit' : 'Add to Cart';
		if (total > 0) {
			wizard.game.actionButton.disabled = false;
			wizard.game.actionButton.innerText = `${addToCart}: ${formatCurrency(total)}`;
		} else {
			wizard.game.actionButton.disabled = true;
			wizard.game.actionButton.innerText = addToCart;
		}
	};
	
	const goToCart = () => {
		history.pushState({}, '', '/omni/#checkout');
		dispatchEvent(new PopStateEvent('popstate', {}));
	};
	
	const goToLanding = () => {
		history.pushState({}, '', '/omni/');
		dispatchEvent(new PopStateEvent('popstate', {}));
	}
	
	const createProductRow = (cartItem, productId) => {
		const quantity = cartItem.getQuantity(productId);
		if (quantity <= 0) {
			return null;
		}
		
		const name = ProductIds[productId].Name;
		const price = ProductIds[productId].Price;
		
		const nameCell = document.createElement('div');
		nameCell.appendChild(document.createTextNode(`${quantity} x ${name}`));
		
		const priceCell = document.createElement('div');
		priceCell.classList.add('formatted-price');
		priceCell.appendChild(document.createTextNode(price * quantity));
		
		const row = document.createElement('div');
		row.classList.add('bundle-product');
		row.appendChild(nameCell);
		row.appendChild(priceCell);
		
		return row;
	};
	
	const createCartItemRow = (cartItem) => {
		const productIds = cartItem.productIds;
		if (productIds.length <= 0) {
			return null;
		}
		
		const row = document.createElement('div');
		row.classList.add('bundle');
		productIds.forEach((productId) => {
			const productRow = createProductRow(cartItem, productId);
			if (productRow) {
				row.appendChild(productRow);
			}
		});
		
		const giftCell = document.createElement('div');
		if (cartItem.isGift) {
			row.classList.add('gift');
			
			giftCell.classList.add('gift');
			if (productIds.length > 1) {
				giftCell.appendChild(document.createTextNode('These products are a gift. You will receive a gift code for them.'));
			} else {
				giftCell.appendChild(document.createTextNode('This product is a gift. You will receive a gift code for it.'));
			}
		}
		
		const editButton = document.createElement('button');
		editButton.appendChild(document.createTextNode('Edit'));
		editButton.classList.add('small');
		editButton.addEventListener('click', (ev) => {
			ev.preventDefault();
			showWizard(cartItem);
		});
		
		const removeButton = document.createElement('button');
		removeButton.appendChild(document.createTextNode('Remove'));
		removeButton.classList.add('red');
		removeButton.classList.add('small');
		removeButton.addEventListener('click', (ev) => {
			ev.preventDefault();
			cart.remove(cartItem);
			updateCart();
		});
		
		const actionButtons = document.createElement('div');
		actionButtons.classList.add('button-group');
		actionButtons.appendChild(editButton);
		actionButtons.appendChild(removeButton);
		
		const actionsCell = document.createElement('div');
		actionsCell.appendChild(actionButtons);
		
		const actionsRow = document.createElement('div');
		actionsRow.classList.add('actions');
		actionsRow.classList.add('double-group');
		actionsRow.appendChild(giftCell);
		actionsRow.appendChild(actionsCell);
		
		row.appendChild(actionsRow);
		
		return row;
	};
	
	updateCart = () => {
		if (cart.count > 0) {
			cartElements.emailField.innerText = cart.email;
			cartElements.changeEmailButton.classList.remove('hidden');
			cartContainer.innerText = '';
			cartContainer.classList.remove('empty');
			
			const items = cart.items;
			items.forEach((cartItem) => {
				const bundleRow = createCartItemRow(cartItem);
				if (bundleRow) {
					cartContainer.appendChild(bundleRow);
				}
			});
			
			const buttonGroup = document.createElement('div');
			buttonGroup.classList.add('button-group');
			
			cartElements.buyMoreButton = document.createElement('button');
			cartElements.buyMoreButton.addEventListener('click', (ev) => {
				showWizard();
			});
			cartElements.buyMoreButton.appendChild(document.createTextNode('Add More'));
			
			cartElements.checkoutButton = document.createElement('button');
			cartElements.checkoutButton.addEventListener('click', (ev) => {
				console.log('Checkout');
			});
			cartElements.checkoutButton.classList.add('default');
			cartElements.checkoutButton.appendChild(document.createTextNode('Checkout'));
			
			buttonGroup.appendChild(cartElements.buyMoreButton);
			buttonGroup.appendChild(cartElements.checkoutButton);
			
			const currencyCell = document.createElement('div');
			currencyCell.appendChild(document.createTextNode('Currency Menu'));
			
			const buttonsCell = document.createElement('div');
			buttonsCell.appendChild(buttonGroup);
			
			const footer = document.createElement('div');
			footer.classList.add('storefront-cart-footer');
			footer.classList.add('double-group');
			footer.appendChild(currencyCell);
			footer.appendChild(buttonsCell);
			
			cartContainer.appendChild(footer);
		} else {
			cartElements.emailField.innerText = '';
			cartElements.changeEmailButton.classList.add('hidden');
			cartElements.checkoutButton = null;
			cartContainer.innerText = '';
			cartContainer.classList.add('empty');
			
			cartContainer.appendChild(document.createElement('div'));
			
			const middleCell = document.createElement('div');
			const firstParagraph = document.createElement('p');
			firstParagraph.appendChild(document.createTextNode('Your cart is empty.'));
			middleCell.appendChild(firstParagraph);
			
			cartElements.buyMoreButton = document.createElement('button');
			cartElements.buyMoreButton.addEventListener('click', (ev) => {
				showWizard();
			});
			cartElements.buyMoreButton.classList.add('default');
			cartElements.buyMoreButton.appendChild(document.createTextNode('Buy Omni'));
			const secondParagraph = document.createElement('p');
			secondParagraph.appendChild(cartElements.buyMoreButton);
			middleCell.appendChild(secondParagraph);
			
			cartContainer.appendChild(middleCell);
			
			cartContainer.appendChild(document.createElement("div"));
		}
		
		BeaconCurrency.formatPrices();
	};
	updateCart();
	
	const setViewMode = (animated = true) => {
		window.scrollTo(window.scrollX, 0);
		if (window.location.hash === '#checkout') {
			storeViewManager.switchView('page-cart', animated);
		} else {
			storeViewManager.back(animated);
		}
	};
	
	if (cart.count > 0) {
		buyButton.innerText = 'Go to Cart';
	}
	
	const showWizard = (editCartItem = null) => {
		wizard.editCartItem = editCartItem;
		wizard.game.arkCheck.checked = editCartItem?.getQuantity(Products.Ark.Base.ProductId) > 0 || false;
		wizard.game.arkSACheck.checked = editCartItem?.getQuantity(Products.ArkSA.Base.ProductId) > 0 || editCartItem?.getQuantity(Products.ArkSA.Upgrade.ProductId) > 0 || false;
		
		if (editCartItem) {
			wizard.game.giftCheck.checked = editCartItem.isGift;
			wizard.game.giftCheck.disabled = true;
		} else {
			wizard.game.giftCheck.checked = false;
			wizard.game.giftCheck.disabled = false;
		}
		
		if (editCartItem) {
			wizard.game.arkSADurationField.value = editCartItem.getQuantity(Products.ArkSA.Base.ProductId) + editCartItem.getQuantity(Products.ArkSA.Upgrade.ProductId) + editCartItem.getQuantity(Products.ArkSA.Renewal.ProductId);
		} else {
			wizard.game.arkSADurationField.value = '1';
		}
		
		if (cart.count > 0) {
			wizard.game.cancelButton.innerText = 'Cancel';
			updateGamesList();
			wizardViewManager.switchView('checkout-wizard-game', false);
			wizardViewManager.clearHistory();
		} else {
			wizard.game.cancelButton.innerText = 'Back';
			wizardViewManager.switchView('checkout-wizard-start', false);
			wizardViewManager.clearHistory();
		}
		
		if (cart.email) {
			wizard.email.emailField.value = cart.email;
		} else {
			wizard.email.emailField.value = sessionStorage?.getItem('email') ?? localStorage?.getItem('email') ?? '';
		}
		
		BeaconDialog.showModal('checkout-wizard');
	};
	
	buyButton.addEventListener('click', (ev) => {
		ev.preventDefault();
		
		if (cart.count > 0) {
			goToCart();
			return;
		}
		
		showWizard();
	});
	
	landingButton.addEventListener('click', (ev) => {
		goToLanding();
	});
	
	cartElements.changeEmailButton.addEventListener('click', (ev) => {
		BeaconDialog.confirm('Changing the email address will clear your cart.', 'Just a heads up, because the contents of your cart rely on your email address, changing the address will start a new cart.', 'Ok', 'Nevermind').then(() => {
			cart.reset();
			updateCart();
			showWizard();
		});
	});
	
	wizard.start.cancelButton.addEventListener('click', (ev) => {
		BeaconDialog.hideModal();
		ev.preventDefault();
	});
	
	wizard.start.actionButton.addEventListener('click', (ev) => {
		wizardViewManager.switchView('checkout-wizard-email');
		ev.preventDefault();
	});
	
	wizard.email.cancelButton.addEventListener('click', (ev) => {
		wizardViewManager.back();
		ev.preventDefault();
	});
	
	wizard.email.actionButton.addEventListener('click', (ev) => {
		ev.target.disabled = true;
		wizard.email.errorField.classList.add('hidden');
		
		cart.setEmail(wizard.email.emailField.value).then((email) => {
			updateGamesList();
			wizardViewManager.switchView('checkout-wizard-game');
		}).catch((reason) => {
			wizard.email.errorField.innerText = reason;
			wizard.email.errorField.classList.remove('hidden');
		}).finally(() => {
			ev.target.disabled = false;
		});
		ev.preventDefault();
	});
	
	wizard.game.cancelButton.addEventListener('click', (ev) => {
		ev.preventDefault();
		wizardViewManager.back() || BeaconDialog.hideModal();
	});
	
	wizard.game.actionButton.addEventListener('click', (ev) => {
		ev.preventDefault();
		
		const isGift = wizard.game.giftCheck.checked;
		const gameStatus = getGameStatus();
		
		if (gameStatus.Ark !== StatusBuying && gameStatus.ArkSA !== StatusBuying) {
			return;
		}
		
		let arkSAYears = parseInt(wizard.game.arkSADurationField.value) || 1;
		
		let lineItem;
		if (wizard.editCartItem) {
			lineItem = wizard.editCartItem;
		} else if (!isGift && cart.personalCartItem) {
			lineItem = cart.personalCartItem;
			arkSAYears += lineItem.getQuantity(Products.ArkSA.Base.ProductId) + lineItem.getQuantity(Products.ArkSA.Upgrade.ProductId) + lineItem.getQuantity(Products.ArkSA.Renewal.ProductId);
		}
		if (!lineItem) {
			lineItem = new BeaconCartItem();
			lineItem.isGift = isGift;
			cart.add(lineItem);
		}
		lineItem.reset();
		
		arkSAYears = Math.min(Math.max(arkSAYears, 1), 10);
		const arkSAAdditionalYears = Math.max(arkSAYears - 1, 0);
		
		if (gameStatus.Ark === StatusBuying || gameStatus.Ark === StatusInCart) {
			lineItem.setQuantity(Products.Ark.Base.ProductId, 1);
		}
		
		if (gameStatus.ArkSA !== StatusNone) {
			if (gameStatus.ArkSA === StatusOwns) {
				lineItem.setQuantity(Products.ArkSA.Renewal.ProductId, 1);
			} else if (gameStatus.Ark !== StatusNone) {
				lineItem.setQuantity(Products.ArkSA.Upgrade.ProductId, 1);
			} else {
				lineItem.setQuantity(Products.ArkSA.Base.ProductId, 1);
			}
			if (arkSAAdditionalYears > 0) {
				lineItem.setQuantity(Products.ArkSA.Renewal.ProductId, arkSAAdditionalYears);
			}
		}
		
		cart.save();
		updateCart();
		
		BeaconDialog.hideModal();
		goToCart();
	});
	
	wizard.game.giftCheck.addEventListener('change', (ev) => {
		updateGamesList();
	});
	
	wizard.game.arkCheck.addEventListener('change', (ev) => {
		updateGamesList();
	});
	
	wizard.game.arkSACheck.addEventListener('change', (ev) => {
		updateGamesList();
	});
	
	wizard.game.arkSADurationField.addEventListener('input', (ev) => {
		updateGamesList();
	});
	
	window.addEventListener('popstate', (ev) => {
		setViewMode(true);
	});
	setViewMode(false);
});

document.addEventListener('GlobalizeLoaded', () => {
	updateCart();
	
	/*const pageLanding = document.getElementById('page-landing');
	const pageCart = document.getElementById('page-cart');
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
	const cartBackButton = document.getElementById('cart_back_button');
	const stripeCheckoutButton = document.getElementById('stripe_checkout_button');
	const emailField = document.getElementById('checkout_email_field');
	const totalField = document.getElementById('total_field');
	const currencyMenu = document.getElementById('currency-menu');
	const requiredPageElements = [pageLanding, pageCart, stwQuantityField, arkGiftQuantityField, arkCheckbox, arkCheckboxFrame, arkOwnedCaption, cartBackButton, stripeCheckoutButton, emailField, totalField, currencyMenu];
	if (requiredPageElements.includes(null)) {
		console.log('Missing page elements');
		return false;
	}
	
	const status = {
		checkingEmail: false,
		ownsArk: false,
		ownsArk2: false,
		ownsArkSA: false
	}
	
	const updateTotal = () => {
		const includeArk = cart.arkLicense !== null && arkCheckbox.checked;
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
			
			const firstYearPrice = (cart.arkLicense || cart.arkSALicense) ? (arkSAPrice / 2) : arkSAPrice;
			const additionalYearPrice = arkSAPrice / 2;
			const firstYear = Math.min(Math.max(arkSAQuantity, 0), 1);
			const additionalYears = Math.max(arkSAQuantity - 1, 0);
			
			total += (firstYearPrice * firstYear) + (additionalYearPrice * additionalYears) + (arkSAGiftQuantity * arkSAGiftPrice);
		}
		
		totalField.innerHTML = formatCurrency(total);
		stripeCheckoutButton.disabled = (total == 0) || cart.checkingEmail || validateEmail(emailField.value) == false;
	};
	
	const updateCheckoutComponents = () => {
		if (cart.arkLicense) {
			arkCheckboxFrame.classList.add('hidden');
			arkOwnedCaption.classList.remove('hidden');
		} else {
			arkCheckboxFrame.classList.remove('hidden');
			arkOwnedCaption.classList.add('hidden');
		}
		if (ark2ActiveLicenseCaption) {
			if (cart.ark2License) {
				ark2ActiveLicenseCaption.classList.remove('hidden');
			} else {
				ark2ActiveLicenseCaption.classList.add('hidden');
			}
		}
		updateTotal();
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
	setViewMode(false);
	
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
		
		const includeArk = cart.arkLicense !== null && arkCheckbox.checked;
		const stwQuantity = Math.max(Math.min(stwQuantityField.value, 10), 0);
		const arkGiftQuantity = Math.max(Math.min(arkGiftQuantityField.value, 10), 0);
		const includeArk2 = ark2Checkbox && ark2Checkbox.checked;
		const ark2GiftQuantity = ark2GiftQuantityField && Math.max(Math.min(ark2GiftQuantityField.value, 10), 0);
		
		const params = new URLSearchParams();
		params.append('email', cart.email);
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
			updateCheckoutComponents();
		}, 250);
	});
	
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
	}*/
});
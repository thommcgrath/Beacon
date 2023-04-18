"use strict";

const StatusOwns = 'owns'; // User has a license for the item
const StatusBuying = 'buying'; // The user is buying it in this cart item
const StatusInCart = 'in-cart'; // The user has it in their cart elsewhere
const StatusNone = 'none';

const MaxRenewalCount = 5;

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
	
	get arkSAYears() {
		return Math.min(this.getQuantity(Products?.ArkSA?.Base?.ProductId) + this.getQuantity(Products?.ArkSA?.Upgrade?.ProductId) + this.getQuantity(Products?.ArkSA?.Renewal?.ProductId), 10);
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
			
			let buyArk = false;
			let buyArkSAYears = 0;
			const cartItem = this.personalCartItem;
			if (cartItem) {
				buyArk = cartItem.hasArk;
				buyArkSAYears = cartItem.arkSAYears;
			}
			
			const params = new URLSearchParams();
			params.append('email', newEmail);
			
			BeaconWebRequest.get(`/omni/lookup?${params.toString()}`).then((response) => {
				const info = JSON.parse(response.body);
				this.#email = info.email;
				this.#emailVerified = info.verified;
				this.#licenses = info.purchases;
				
				if (cartItem) {
					cartItem.reset();
					cartItem.isGift = false; // Just to be sure
					
					if (buyArk && this.arkLicense !== null) {
						cartItem.setQuantity(Products?.Ark?.Base?.ProductId, 1);
					}
					
					if (buyArkSAYears > 0) {
						if (this.arkSALicense !== null) {
							// Renew
							cartItem.setQuantity(Products?.ArkSA?.Renewal?.ProductId, buyArkSAYears);
						} else if (buyArk) {
							// Upgrade
							cartItem.setQuantity(Products?.ArkSA?.Upgrade?.ProductId, 1);
							if (buyArkSAYears > 1) {
								cartItem.setQuantity(Products?.ArkSA?.Renewal?.ProductId, buyArkSAYears - 1);
							}
						} else {
							// New
							cartItem.setQuantity(Products?.ArkSA?.Base?.ProductId, 1);
							if (buyArkSAYears > 1) {
								cartItem.setQuantity(Products?.ArkSA?.Renewal?.ProductId, buyArkSAYears - 1);
							}
						}
					}
				}
				
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
		return this.findLicense(Products?.Ark?.Base?.ProductId);
	}
	
	get arkSALicense() {
		return this.findLicense(Products?.ArkSA?.Base?.ProductId);
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
	
	const emailDialog = {
		cancelButton: document.getElementById('checkout-email-cancel'),
		actionButton: document.getElementById('checkout-email-action'),
		emailField: document.getElementById('checkout-email-field'),
		errorField: document.getElementById('checkout-email-error'),
		allowsSkipping: false,
		successFunction: function() {},
		init: function() {
			this.actionButton.addEventListener('click', (ev) => {
				ev.preventDefault();
				ev.target.disabled = true;
				this.errorField.classList.add('hidden');
				
				cart.setEmail(this.emailField.value).then((email) => {
					BeaconDialog.hideModal();
					setTimeout(() => {
						this.successFunction();
					}, 310);
				}).catch((reason) => {
					this.errorField.innerText = reason;
					this.errorField.classList.remove('hidden');
				}).finally(() => {
					ev.target.disabled = false;
				});
			});
			
			this.cancelButton.addEventListener('click', (ev) => {
				ev.preventDefault();
				
				BeaconDialog.hideModal();
				if (this.allowsSkipping) {
					setTimeout(() => {
						this.successFunction();
					}, 310);
				}
			});
		},
		present: function(allowSkipping, successFunction) {
			this.allowsSkipping = allowSkipping;
			this.successFunction = successFunction;
			
			if (cart.email) {
				this.emailField.value = cart.email;
			} else {
				this.emailField.value = sessionStorage.getItem('email') || localStorage.getItem('email') || '';
			}
			
			if (allowSkipping) {
				this.cancelButton.innerText = 'Skip For Now';
			} else {
				this.cancelButton.innerText = 'Cancel';
			}
			
			BeaconDialog.showModal('checkout-email');
		}
	};
	emailDialog.init();
	
	const wizard = {
		editCartItem: null,
		cancelButton: document.getElementById('checkout-wizard-cancel'),
		actionButton: document.getElementById('checkout-wizard-action'),
		giftCheck: document.getElementById('checkout-wizard-gift-check'),
		arkSACheck: document.getElementById('checkout-wizard-arksa-check'),
		arkCheck: document.getElementById('checkout-wizard-ark-check'),
		arkPriceField: document.getElementById('checkout-wizard-ark-price'),
		arkSAPriceField: document.getElementById('checkout-wizard-arksa-full-price'),
		arkSAUpgradePriceField: document.getElementById('checkout-wizard-arksa-discount-price'),
		arkSAStatusField: document.getElementById('checkout-wizard-status-arksa'),
		arkStatusField: document.getElementById('checkout-wizard-status-ark'),
		arkSADurationGroup: document.getElementById('checkout-wizard-arksa-duration-group'),
		arkSADurationField: document.getElementById('checkout-wizard-arksa-duration-field'),
		arkSADurationUpButton: document.getElementById('checkout-wizard-arksa-yearup-button'),
		arkSADurationDownButton: document.getElementById('checkout-wizard-arksa-yeardown-button'),
		init: function() {
			this.cancelButton.addEventListener('click', (ev) => {
				ev.preventDefault();
				BeaconDialog.hideModal();
			});
			
			this.actionButton.addEventListener('click', (ev) => {
				ev.preventDefault();
				
				const isGift = this.giftCheck.checked;
				const gameStatus = this.getGameStatus();
				
				if (gameStatus.Ark !== StatusBuying && gameStatus.ArkSA !== StatusBuying) {
					return;
				}
				
				let arkSAYears = parseInt(this.arkSADurationField.value) || 1;
				
				let lineItem;
				if (this.editCartItem) {
					lineItem = this.editCartItem;
				} else if (!isGift && cart.personalCartItem) {
					lineItem = cart.personalCartItem;
					arkSAYears += lineItem.arkSAYears;
				}
				if (!lineItem) {
					lineItem = new BeaconCartItem();
					lineItem.isGift = isGift;
					cart.add(lineItem);
				}
				lineItem.reset();
				
				arkSAYears = Math.min(Math.max(arkSAYears, 1), MaxRenewalCount);
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
				goToCart();
				
				BeaconDialog.hideModal();
			});
			
			this.giftCheck.addEventListener('change', (ev) => {
				this.update();
			});
			
			this.arkCheck.addEventListener('change', (ev) => {
				this.update();
			});
			
			this.arkSACheck.addEventListener('change', (ev) => {
				this.update();
			});
			
			this.arkSADurationField.addEventListener('input', (ev) => {
				this.update();
			});
			
			const nudgeArkSADuration = (amount) => {
				const originalValue = parseInt(this.arkSADurationField.value);
				let newValue = originalValue + amount;
				if (newValue > MaxRenewalCount || newValue < 1) {
					this.arkSADurationGroup.classList.add('shake');
					setTimeout(() => {
						this.arkSADurationGroup.classList.remove('shake');
					}, 400);
					newValue = Math.max(Math.min(newValue, MaxRenewalCount), 1);
				}
				if (originalValue !== newValue) {
					this.arkSADurationField.value = newValue;
					this.arkSACheck.checked = true;
					this.update();
				}
			}
			
			this.arkSADurationUpButton.addEventListener('click', (ev) => {
				ev.preventDefault();
				nudgeArkSADuration(1);
			});
			
			this.arkSADurationDownButton.addEventListener('click', (ev) => {
				ev.preventDefault();
				nudgeArkSADuration(-1);
			});
		},
		present: function(editCartItem = null) {
			this.editCartItem = editCartItem;
			this.arkCheck.checked = editCartItem?.hasArk || false;
			this.arkSACheck.checked = editCartItem?.hasArkSA || false;
			
			if (editCartItem) {
				this.giftCheck.checked = editCartItem.isGift;
				this.giftCheck.disabled = true;
			} else {
				this.giftCheck.checked = false;
				this.giftCheck.disabled = false;
			}
			
			if (editCartItem) {
				this.arkSADurationField.value = editCartItem.getQuantity(Products.ArkSA.Base.ProductId) + editCartItem.getQuantity(Products.ArkSA.Upgrade.ProductId) + editCartItem.getQuantity(Products.ArkSA.Renewal.ProductId);
			} else {
				this.arkSADurationField.value = '1';
			}
			
			this.cancelButton.innerText = 'Cancel';
			this.update();
			
			BeaconDialog.showModal('checkout-wizard');
		},
		getGameStatus: function() {
			const gameStatus = {
				Ark: StatusNone,
				ArkSA: StatusNone
			};
			
			const personalCartItem = cart.personalCartItem;
			const isEditing = Boolean(this.editCartItem);
			const isGift = this.giftCheck.checked;
			if (isGift) {
				gameStatus.Ark = this.arkCheck.disabled == false && this.arkCheck.checked ? StatusBuying : StatusNone;
				gameStatus.ArkSA = this.arkSACheck.disabled == false && this.arkSACheck.checked ? StatusBuying : StatusNone;
			} else {
				if (cart.arkLicense) {
					gameStatus.Ark = StatusOwns;
				} else if (this.arkCheck.disabled == false && this.arkCheck.checked) {
					gameStatus.Ark = StatusBuying;
				} else if (personalCartItem && (isEditing === false || personalCartItem.id !== this.editCartItem.id) && personalCartItem.hasArk) {
					gameStatus.Ark = StatusInCart;
				} else {
					gameStatus.Ark = StatusNone;
				}
				
				if (cart.arkSALicense) {
					gameStatus.ArkSA = StatusOwns;
				} else if (this.arkSACheck.disabled == false && this.arkSACheck.checked) {
					gameStatus.ArkSA = StatusBuying;
				} else if (personalCartItem && (isEditing === false || personalCartItem.id !== this.editCartItem.id) && personalCartItem.hasArkSA) {
					gameStatus.ArkSA = StatusInCart;
				} else {
					gameStatus.ArkSA = StatusNone;
				}
			}
			
			return gameStatus;
		},
		update: function() {
			const gameStatus = this.getGameStatus();
			
			let arkSAFullPrice = Products.ArkSA.Base.Price;
			let arkSAEffectivePrice = Products.ArkSA.Base.Price;
			
			const arkSAYears = Math.min(Math.max(parseInt(this.arkSADurationField.value) || 1, 1), MaxRenewalCount);
			if (parseInt(this.arkSADurationField.value) !== arkSAYears && document.activeElement !== this.arkSADurationField) {
				this.arkSADurationField.value = arkSAYears;
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
				this.arkSAStatusField.innerText = `Additional renewal years for ${Products.ArkSA.Base.Name} in your cart.`;
			} else if (gameStatus.Ark !== StatusNone) {
				// Show as upgrade
				const discount = Math.round(((Products.ArkSA.Base.Price - Products.ArkSA.Upgrade.Price) / Products.ArkSA.Base.Price) * 100);
				const discountLanguage = gameStatus.Ark === StatusOwns ? 'because you own' : 'when bundled with';
				
				arkSAFullPrice = Products.ArkSA.Base.Price + (Products.ArkSA.Renewal.Price * arkSAAdditionalYears);
				arkSAEffectivePrice = Products.ArkSA.Upgrade.Price + (Products.ArkSA.Renewal.Price * arkSAAdditionalYears);
				
				this.arkSAStatusField.innerText = `${discount}% off first year ${discountLanguage} ${Products.Ark.Base.Name}. Additional years cost ${formatCurrency(Products.ArkSA.Renewal.Price)} each.`;
			} else {
				// Show normal
				this.arkSAStatusField.innerText = `Includes first year of app updates. Additional years cost ${formatCurrency(arkSARenewPrice)} each.`;
				
				arkSAFullPrice = Products.ArkSA.Base.Price + (Products.ArkSA.Renewal.Price * arkSAAdditionalYears);
				arkSAEffectivePrice = arkSAFullPrice;
			}
			
			if (arkSAFullPrice !== arkSAEffectivePrice) {
				this.arkSAPriceField.classList.add('checkout-wizard-discounted');
				this.arkSAUpgradePriceField.classList.remove('hidden');
			} else {
				this.arkSAPriceField.classList.remove('checkout-wizard-discounted');
				this.arkSAUpgradePriceField.classList.add('hidden');
			}
			
			this.arkSAPriceField.innerText = formatCurrency(arkSAFullPrice);
			this.arkSAUpgradePriceField.innerText = formatCurrency(arkSAEffectivePrice);
			
			if (gameStatus.Ark === StatusOwns) {
				this.arkStatusField.innerText = `You already own ${Products.Ark.Base.Name}.`;
				this.arkCheck.disabled = true;
				this.arkCheck.checked = false;
				this.arkPriceField.classList.add('hidden');
			} else if (gameStatus.Ark === StatusInCart) {
				this.arkStatusField.innerText = `${Products.Ark.Base.Name} is already in your cart.`;
				this.arkCheck.disabled = true;
				this.arkCheck.checked = false;
				this.arkPriceField.classList.add('hidden');
			} else {
				this.arkStatusField.innerText = 'Includes lifetime app updates.';
				this.arkCheck.disabled = false;
				this.arkPriceField.classList.remove('hidden');
			}
			
			let total = 0;
			if (this.arkCheck.disabled === false && this.arkCheck.checked === true) {
				total = total + Products.Ark.Base.Price;
			}
			if (this.arkSACheck.disabled === false && this.arkSACheck.checked === true) {
				total = total + arkSAEffectivePrice;
			}
			
			const addToCart = (this.editCartItem) ? 'Edit' : 'Add to Cart';
			if (total > 0) {
				this.actionButton.disabled = false;
				this.actionButton.innerText = `${addToCart}: ${formatCurrency(total)}`;
			} else {
				this.actionButton.disabled = true;
				this.actionButton.innerText = addToCart;
			}
		}
	};
	wizard.init();
	
	const cartElements = {
		emailField: document.getElementById('storefront-cart-header-email-field'),
		changeEmailButton: document.getElementById('storefront-cart-header-email-button')
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
		
		const quantityCell = document.createElement('div');
		quantityCell.appendChild(document.createTextNode(quantity));
		
		const nameCell = document.createElement('div');
		nameCell.appendChild(document.createTextNode(name));
		
		const priceCell = document.createElement('div');
		priceCell.classList.add('formatted-price');
		priceCell.appendChild(document.createTextNode(price * quantity));
		
		const row = document.createElement('div');
		row.classList.add('bundle-product');
		row.appendChild(quantityCell);
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
			wizard.present(cartItem);
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
				wizard.present();
			});
			cartElements.buyMoreButton.appendChild(document.createTextNode('Add More'));
			
			cartElements.checkoutButton = document.createElement('button');
			cartElements.checkoutButton.addEventListener('click', (ev) => {
				const checkoutFunction = () => {
					console.log('Checkout');
				};
				if (!cart.email) {
					emailDialog.present(false, checkoutFunction);
				} else {
					checkoutFunction();
				}
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
				wizard.present();
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
	
	buyButton.addEventListener('click', (ev) => {
		ev.preventDefault();
		
		if (cart.count > 0) {
			goToCart();
			return;
		}
		
		emailDialog.present(true, () => {
			wizard.present();
		});
	});
	
	landingButton.addEventListener('click', (ev) => {
		goToLanding();
	});
	
	cartElements.changeEmailButton.addEventListener('click', (ev) => {
		emailDialog.present(true, () => {
			updateCart();
		});
	});
	
	window.addEventListener('popstate', (ev) => {
		setViewMode(true);
	});
	setViewMode(false);
});

document.addEventListener('GlobalizeLoaded', () => {
	updateCart();
});
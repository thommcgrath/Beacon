"use strict";

function _defineProperty(obj, key, value) { key = _toPropertyKey(key); if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }
function _toPropertyKey(arg) { var key = _toPrimitive(arg, "string"); return typeof key === "symbol" ? key : String(key); }
function _toPrimitive(input, hint) { if (typeof input !== "object" || input === null) return input; var prim = input[Symbol.toPrimitive]; if (prim !== undefined) { var res = prim.call(input, hint || "default"); if (typeof res !== "object") return res; throw new TypeError("@@toPrimitive must return a primitive value."); } return (hint === "string" ? String : Number)(input); }
function _classPrivateFieldInitSpec(obj, privateMap, value) { _checkPrivateRedeclaration(obj, privateMap); privateMap.set(obj, value); }
function _checkPrivateRedeclaration(obj, privateCollection) { if (privateCollection.has(obj)) { throw new TypeError("Cannot initialize the same private elements twice on an object"); } }
function _classPrivateFieldGet(receiver, privateMap) { var descriptor = _classExtractFieldDescriptor(receiver, privateMap, "get"); return _classApplyDescriptorGet(receiver, descriptor); }
function _classApplyDescriptorGet(receiver, descriptor) { if (descriptor.get) { return descriptor.get.call(receiver); } return descriptor.value; }
function _classPrivateFieldSet(receiver, privateMap, value) { var descriptor = _classExtractFieldDescriptor(receiver, privateMap, "set"); _classApplyDescriptorSet(receiver, descriptor, value); return value; }
function _classExtractFieldDescriptor(receiver, privateMap, action) { if (!privateMap.has(receiver)) { throw new TypeError("attempted to " + action + " private field on non-instance"); } return privateMap.get(receiver); }
function _classApplyDescriptorSet(receiver, descriptor, value) { if (descriptor.set) { descriptor.set.call(receiver, value); } else { if (!descriptor.writable) { throw new TypeError("attempted to set read only private field"); } descriptor.value = value; } }
var validateEmail = email => {
  var re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return re.test(String(email).trim().toLowerCase());
};
var _id = /*#__PURE__*/new WeakMap();
var _products = /*#__PURE__*/new WeakMap();
var _isGift = /*#__PURE__*/new WeakMap();
class BeaconCartItem {
  constructor(config) {
    _classPrivateFieldInitSpec(this, _id, {
      writable: true,
      value: null
    });
    _classPrivateFieldInitSpec(this, _products, {
      writable: true,
      value: {}
    });
    _classPrivateFieldInitSpec(this, _isGift, {
      writable: true,
      value: false
    });
    if (config) {
      _classPrivateFieldSet(this, _id, config.id);
      _classPrivateFieldSet(this, _products, config.products);
      _classPrivateFieldSet(this, _isGift, config.isGift);
    } else {
      _classPrivateFieldSet(this, _id, crypto.randomUUID());
    }
  }
  get id() {
    return _classPrivateFieldGet(this, _id);
  }
  get isGift() {
    return _classPrivateFieldGet(this, _isGift);
  }
  set isGift(newValue) {
    _classPrivateFieldSet(this, _isGift, newValue);
  }
  add(productId, quantity) {
    this.setQuantity(productId, this.getQuantity(productId) + quantity);
  }
  remove(productId, quantity) {
    this.setQuantity(productId, this.getQuantity(productId) - quantity);
  }
  getQuantity(productId) {
    var _classPrivateFieldGet2;
    return (_classPrivateFieldGet2 = _classPrivateFieldGet(this, _products)[productId]) !== null && _classPrivateFieldGet2 !== void 0 ? _classPrivateFieldGet2 : 0;
  }
  setQuantity(productId, quantity) {
    if (quantity <= 0) {
      if (_classPrivateFieldGet(this, _products).hasOwnProperty(productId)) {
        _classPrivateFieldSet(this, _products, _classPrivateFieldGet(this, _products).filter(_ref => {
          var [key, value] = _ref;
          return key !== productId;
        }));
      }
    } else {
      _classPrivateFieldGet(this, _products)[productId] = quantity;
    }
  }
  toJSON() {
    return {
      id: _classPrivateFieldGet(this, _id),
      products: _classPrivateFieldGet(this, _products),
      isGift: _classPrivateFieldGet(this, _isGift)
    };
  }
}
var _items = /*#__PURE__*/new WeakMap();
var _email = /*#__PURE__*/new WeakMap();
var _emailVerified = /*#__PURE__*/new WeakMap();
var _licenses = /*#__PURE__*/new WeakMap();
class BeaconCart {
  constructor() {
    var saved = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : null;
    _classPrivateFieldInitSpec(this, _items, {
      writable: true,
      value: []
    });
    _classPrivateFieldInitSpec(this, _email, {
      writable: true,
      value: null
    });
    _classPrivateFieldInitSpec(this, _emailVerified, {
      writable: true,
      value: false
    });
    _classPrivateFieldInitSpec(this, _licenses, {
      writable: true,
      value: []
    });
    _defineProperty(this, "emailChanged", email => {});
    if (saved) {
      try {
        var parsed = JSON.parse(saved);
        _classPrivateFieldSet(this, _email, parsed.email);
        _classPrivateFieldSet(this, _items, parsed.items.map(savedItem => new BeaconCartItem(savedItem)));
        _classPrivateFieldSet(this, _licenses, parsed.licenses);
      } catch (e) {
        console.log('Failed to load saved cart');
      }
    }
  }
  toJSON() {
    return {
      email: _classPrivateFieldGet(this, _email),
      items: _classPrivateFieldGet(this, _items),
      licenses: _classPrivateFieldGet(this, _licenses)
    };
  }
  save() {
    localStorage.setItem('beacon-cart', JSON.stringify(this));
  }
  static load() {
    return new this(localStorage.getItem('beacon-cart'));
  }
  add(item) {
    _classPrivateFieldGet(this, _items).push(item);
    this.save();
  }
  remove(item) {
    _classPrivateFieldSet(this, _items, _classPrivateFieldGet(this, _items).filter(cartItem => cartItem.id !== item.id));
    this.save();
  }
  hasProduct(productId) {
    var isGift = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : false;
    for (var lineItem of _classPrivateFieldGet(this, _items)) {
      if (lineItem.getQuantity(productId) > 0 && lineItem.isGift === isGift) {
        return true;
      }
    }
    return false;
  }
  get email() {
    return _classPrivateFieldGet(this, _email);
  }
  setEmail(newEmail) {
    return new Promise((resolve, reject) => {
      if (newEmail === _classPrivateFieldGet(this, _email)) {
        resolve(newEmail);
        return;
      }
      if (!validateEmail(newEmail)) {
        reject('Address is not valid');
        return;
      }
      var params = new URLSearchParams();
      params.append('email', newEmail);
      BeaconWebRequest.get("/omni/lookup?".concat(params.toString())).then(response => {
        var info = JSON.parse(response.body);
        _classPrivateFieldSet(this, _email, info.email);
        _classPrivateFieldSet(this, _emailVerified, info.verified);
        _classPrivateFieldSet(this, _licenses, info.purchases);
        this.save();
        resolve(newEmail);
      }).catch(error => {
        _classPrivateFieldSet(this, _email, null);
        _classPrivateFieldSet(this, _emailVerified, false);
        _classPrivateFieldSet(this, _licenses, []);
        this.save();
        reject(error.statusText);
      });
    });
  }
  get emailVerified() {
    return _classPrivateFieldGet(this, _emailVerified);
  }
  get checkingEmail() {
    return false;
  }
  get items() {
    return [..._classPrivateFieldGet(this, _items)];
  }
  get count() {
    return _classPrivateFieldGet(this, _items).length;
  }
  findLicense(productId) {
    for (var license of _classPrivateFieldGet(this, _licenses)) {
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
}
var cart = BeaconCart.load();
var _history = /*#__PURE__*/new WeakMap();
var _timeout = /*#__PURE__*/new WeakMap();
class ViewManager {
  constructor(initialView) {
    _classPrivateFieldInitSpec(this, _history, {
      writable: true,
      value: []
    });
    _classPrivateFieldInitSpec(this, _timeout, {
      writable: true,
      value: null
    });
    _classPrivateFieldGet(this, _history).push(initialView);
  }
  get currentView() {
    return _classPrivateFieldGet(this, _history).slice(-1);
  }
  back() {
    if (_classPrivateFieldGet(this, _history).length <= 1) {
      return false;
    }
    this.switchView(_classPrivateFieldGet(this, _history)[_classPrivateFieldGet(this, _history).length - 2]);
    _classPrivateFieldSet(this, _history, _classPrivateFieldGet(this, _history).slice(0, _classPrivateFieldGet(this, _history).length - 2));
    return true;
  }
  clearHistory() {
    if (_classPrivateFieldGet(this, _history).length <= 1) {
      return;
    }
    _classPrivateFieldSet(this, _history, _classPrivateFieldGet(this, _history).slice(-1));
  }
  switchView(newView) {
    var animated = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : true;
    if (this.currentView === newView) {
      return;
    }
    if (_classPrivateFieldGet(this, _timeout)) {
      clearTimeout(_classPrivateFieldGet(this, _timeout));
      _classPrivateFieldSet(this, _timeout, null);
    }
    var currentElement = document.getElementById(this.currentView);
    var newElement = document.getElementById(newView);
    _classPrivateFieldGet(this, _history).push(newView);
    if (animated) {
      currentElement.classList.add('invisible');
      _classPrivateFieldSet(this, _timeout, setTimeout(() => {
        currentElement.classList.add('hidden');
        newElement.classList.remove('hidden');
        _classPrivateFieldSet(this, _timeout, setTimeout(() => {
          newElement.classList.remove('invisible');
          _classPrivateFieldSet(this, _timeout, null);
        }, 150));
      }, 150));
    } else {
      currentElement.classList.add('hidden');
      newElement.classList.remove('invisible');
      newElement.classList.remove('hidden');
    }
  }
}
var viewManager = new ViewManager('checkout-wizard-start');
var formatCurrency = amount => {
  var formatter = BeaconCurrency.defaultFormatter;
  if (formatter) {
    return formatter(amount);
  } else {
    return amount;
  }
};
document.addEventListener('DOMContentLoaded', () => {
  var buyButton = document.getElementById('buy-button');
  var wizard = {
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
  var updateGamesList = () => {
    var isGift = wizard.game.giftCheck.checked;
    var ownsArk = isGift === false && cart.arkLicense;
    var ownsArkSA = isGift === false && cart.arkSALicense;
    var buyingArk = cart.hasProduct(Products.Ark.Base.ProductId, false);
    var arkSAFullPrice = Products.ArkSA.Base.Price;
    var arkSAEffectivePrice = Products.ArkSA.Base.Price;
    var arkSAYears = Math.min(Math.max(parseInt(wizard.game.arkSADurationField.value) || 1, 1), 10);
    wizard.game.arkSADurationSuffixField.innerText = arkSAYears === 1 ? 'year' : 'years';
    if (parseInt(wizard.game.arkSADurationField.value) !== arkSAYears) {
      wizard.game.arkSADurationField.value = arkSAYears;
    }
    var arkSAAdditionalYears = Math.max(arkSAYears - 1, 0);
    if (ownsArkSA) {
      // Show as renewal
      var license = ark.arkSALicense;
      arkSAFullPrice = Products.ArkSA.Renewal.Price * arkSAYears;
      arkSAEffectivePrice = arkSAFullPrice;
    } else if (ownsArk || buyingArk || wizard.game.arkCheck.checked) {
      // Show as upgrade
      var discount = Math.round((Products.ArkSA.Base.Price - Products.ArkSA.Upgrade.Price) / Products.ArkSA.Base.Price * 100);
      var discountLanguage = ownsArk ? 'because you own' : 'when bundled with';
      arkSAFullPrice = Products.ArkSA.Base.Price + Products.ArkSA.Renewal.Price * arkSAAdditionalYears;
      arkSAEffectivePrice = Products.ArkSA.Upgrade.Price + Products.ArkSA.Renewal.Price * arkSAAdditionalYears;
      wizard.game.arkSAStatusField.innerText = "".concat(discount, "% off first year ").concat(discountLanguage, " ").concat(Products.Ark.Base.Name, ". Additional years cost ").concat(formatCurrency(Products.ArkSA.Renewal.Price), " each.");
    } else {
      // Show normal
      wizard.game.arkSAStatusField.innerText = "Includes first year of app updates. Additional years cost ".concat(formatCurrency(arkSARenewPrice), " each.");
      arkSAFullPrice = Products.ArkSA.Base.Price + Products.ArkSA.Renewal.Price * arkSAAdditionalYears;
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
    if (ownsArk) {
      wizard.game.arkStatusField.innerText = "You already own ".concat(Products.Ark.Base.Name, ".");
      wizard.game.arkCheck.disabled = true;
      wizard.game.arkCheck.checked = false;
      wizard.game.arkPriceField.classList.add('hidden');
    } else if (buyingArk) {
      wizard.game.arkStatusField.innerText = "".concat(Products.Ark.Base.Name, " is already in your cart.");
      wizard.game.arkCheck.disabled = true;
      wizard.game.arkCheck.checked = false;
      wizard.game.arkPriceField.classList.add('hidden');
    } else {
      wizard.game.arkStatusField.innerText = 'Includes lifetime app updates.';
      wizard.game.arkCheck.disabled = false;
      wizard.game.arkPriceField.classList.remove('hidden');
    }
    var total = 0;
    if (wizard.game.arkCheck.disabled === false && wizard.game.arkCheck.checked === true) {
      total = total + Products.Ark.Base.Price;
    }
    if (wizard.game.arkSACheck.disabled === false && wizard.game.arkSACheck.checked === true) {
      total = total + arkSAEffectivePrice;
    }
    if (total > 0) {
      wizard.game.actionButton.disabled = false;
      wizard.game.actionButton.innerText = "Add to Cart: ".concat(formatCurrency(total));
    } else {
      wizard.game.actionButton.disabled = true;
      wizard.game.actionButton.innerText = 'Add to Cart';
    }
  };
  buyButton.addEventListener('click', ev => {
    if (cart.count > 0) {
      wizard.game.cancelButton.innerText = 'Cancel';
      updateGamesList();
      viewManager.switchView('checkout-wizard-game', false);
      viewManager.clearHistory();
    }
    BeaconDialog.showModal('checkout-wizard');
    ev.preventDefault();
  });
  wizard.start.cancelButton.addEventListener('click', ev => {
    BeaconDialog.hideModal();
    ev.preventDefault();
  });
  wizard.start.actionButton.addEventListener('click', ev => {
    viewManager.switchView('checkout-wizard-email');
    ev.preventDefault();
  });
  wizard.email.cancelButton.addEventListener('click', ev => {
    viewManager.back();
    ev.preventDefault();
  });
  wizard.email.actionButton.addEventListener('click', ev => {
    ev.target.disabled = true;
    wizard.email.errorField.classList.add('hidden');
    cart.setEmail(wizard.email.emailField.value).then(email => {
      updateGamesList();
      viewManager.switchView('checkout-wizard-game');
    }).catch(reason => {
      wizard.email.errorField.innerText = reason;
      wizard.email.errorField.classList.remove('hidden');
    }).finally(() => {
      ev.target.disabled = false;
    });
    ev.preventDefault();
  });
  wizard.game.cancelButton.addEventListener('click', ev => {
    ev.preventDefault();
    viewManager.back() || BeaconDialog.hideModal();
  });
  wizard.game.actionButton.addEventListener('click', ev => {
    ev.preventDefault();
    var isGift = wizard.game.giftCheck.checked;
    var includeArk = wizard.game.arkCheck.disabled === false && wizard.game.arkCheck.checked;
    var includeArkSA = wizard.game.arkSACheck.disabled === false && wizard.game.arkSACheck.checked;
    var ownsArk = isGift === false && cart.arkLicense;
    var ownsArkSA = isGift === false && cart.arkSALicense;
    if (includeArk === false && includeArkSA === false) {
      return;
    }
    var lineItem = new BeaconCartItem();
    lineItem.isGift = isGift;
    if (includeArk) {
      lineItem.add(Products.Ark.Base.ProductId, 1);
    }
    if (includeArkSA) {
      var arkSAYears = Math.min(Math.max(parseInt(wizard.game.arkSADurationField.value) || 1, 1), 10);
      var arkSAAdditionalYears = Math.max(arkSAYears - 1, 0);
      if (ownsArkSA) {
        lineItem.add(Products.ArkSA.Renewal.ProductId, 1);
      } else if (ownsArk) {
        lineItem.add(Products.ArkSA.Upgrade.ProductId, 1);
      } else {
        lineItem.add(Products.ArkSA.Base.ProductId, 1);
      }
      if (arkSAAdditionalYears > 0) {
        lineItem.add(Products.ArkSA.Renewal.ProductId, arkSAAdditionalYears);
      }
    }
    cart.add(lineItem);
    BeaconDialog.hideModal();
    history.pushState({}, '', '/omni/#cart');
    dispatchEvent(new PopStateEvent('popstate', {}));
  });
  wizard.game.giftCheck.addEventListener('change', ev => {
    updateGamesList();
  });
  wizard.game.arkCheck.addEventListener('change', ev => {
    updateGamesList();
  });
  wizard.game.arkSACheck.addEventListener('change', ev => {
    updateGamesList();
  });
  wizard.game.arkSADurationField.addEventListener('input', ev => {
    updateGamesList();
  });
  if (cart.email) {
    wizard.email.emailField.value = cart.email;
  } else {
    var _ref2, _sessionStorage$getIt, _sessionStorage, _localStorage;
    wizard.email.emailField.value = (_ref2 = (_sessionStorage$getIt = (_sessionStorage = sessionStorage) === null || _sessionStorage === void 0 ? void 0 : _sessionStorage.getItem('email')) !== null && _sessionStorage$getIt !== void 0 ? _sessionStorage$getIt : (_localStorage = localStorage) === null || _localStorage === void 0 ? void 0 : _localStorage.getItem('email')) !== null && _ref2 !== void 0 ? _ref2 : '';
  }
});
document.addEventListener('GlobalizeLoaded', () => {
  var pageLanding = document.getElementById('page_landing');
  var pageCart = document.getElementById('page_cart');
  var stwQuantityField = document.getElementById('stw_quantity_field');
  var arkGiftQuantityField = document.getElementById('ark_gift_quantity_field');
  var arkCheckbox = document.getElementById('ark_checkbox');
  var arkCheckboxFrame = document.getElementById('ark_checkbox_frame');
  var arkOwnedCaption = document.getElementById('ark_owned_caption');
  var ark2GiftQuantityField = document.getElementById('ark2_gift_quantity_field');
  var ark2Checkbox = document.getElementById('ark2_checkbox');
  var ark2ActiveLicenseCaption = document.getElementById('ark2-activelicense');
  var arkSAGiftQuantityField = document.getElementById('arksa_gift_quantity_field');
  var arkSAQuantityField = document.getElementById('arksa_quantity_field');
  var arkSAActiveLicenseCaption = document.getElementById('arksa-activelicense');
  var arkSAUpgradeCaption = document.getElementById('arksa-upgrade');
  var cartBackButton = document.getElementById('cart_back_button');
  var stripeCheckoutButton = document.getElementById('stripe_checkout_button');
  var emailField = document.getElementById('checkout_email_field');
  var totalField = document.getElementById('total_field');
  var currencyMenu = document.getElementById('currency-menu');
  var requiredPageElements = [pageLanding, pageCart, stwQuantityField, arkGiftQuantityField, arkCheckbox, arkCheckboxFrame, arkOwnedCaption, cartBackButton, stripeCheckoutButton, emailField, totalField, currencyMenu];
  if (requiredPageElements.includes(null)) {
    console.log('Missing page elements');
    return false;
  }
  var setViewMode = () => {
    window.scrollTo(window.scrollX, 0);
    if (window.location.hash === '#checkout') {
      pageLanding.classList.add('hidden');
      pageCart.classList.remove('hidden');
    } else {
      pageLanding.classList.remove('hidden');
      pageCart.classList.add('hidden');
    }
  };
  var status = {
    checkingEmail: false,
    ownsArk: false,
    ownsArk2: false,
    ownsArkSA: false
  };
  var updateTotal = () => {
    var includeArk = cart.arkLicense !== null && arkCheckbox.checked;
    var stwQuantity = Math.max(Math.min(stwQuantityField.value, 10), 0);
    var arkGiftQuantity = Math.max(Math.min(arkGiftQuantityField.value, 10), 0);
    if (stwQuantityField.value != stwQuantity) {
      stwQuantityField.value = stwQuantity;
    }
    if (arkGiftQuantityField.value != arkGiftQuantity) {
      arkGiftQuantityField.value = arkGiftQuantity;
    }
    var total = stwPrice * stwQuantity + arkGiftPrice * arkGiftQuantity;
    if (includeArk) {
      total += arkPrice;
    }
    if (ark2GiftQuantityField && ark2Checkbox && ark2ActiveLicenseCaption) {
      var includeArk2 = ark2Checkbox.checked;
      var ark2GiftQuantity = Math.max(Math.min(ark2GiftQuantityField.value, 10), 0);
      if (ark2GiftQuantityField.value != ark2GiftQuantity) {
        ark2GiftQuantityField.value = ark2GiftQuantity;
      }
      total += ark2GiftPrice * ark2GiftQuantity;
      if (includeArk2) {
        total += ark2Price;
      }
    }
    if (arkSAQuantityField && arkSAGiftQuantityField && arkSAActiveLicenseCaption && arkSAUpgradeCaption) {
      var arkSAQuantity = Math.max(Math.min(arkSAQuantityField.value, 10), 0);
      var arkSAGiftQuantity = Math.max(Math.min(arkSAGiftQuantityField.value, 10), 0);
      if (arkSAQuantityField.value != arkSAQuantity) {
        arkSAQuantityField.value = arkSAQuantity;
      }
      if (arkSAGiftQuantityField.value != arkSAGiftQuantity) {
        arkSAGiftQuantityField.value = arkSAGiftQuantity;
      }
      var firstYearPrice = cart.arkLicense || cart.arkSALicense ? arkSAPrice / 2 : arkSAPrice;
      var additionalYearPrice = arkSAPrice / 2;
      var firstYear = Math.min(Math.max(arkSAQuantity, 0), 1);
      var additionalYears = Math.max(arkSAQuantity - 1, 0);
      total += firstYearPrice * firstYear + additionalYearPrice * additionalYears + arkSAGiftQuantity * arkSAGiftPrice;
    }
    totalField.innerHTML = formatCurrency(total);
    stripeCheckoutButton.disabled = total == 0 || cart.checkingEmail || validateEmail(emailField.value) == false;
  };
  var updateCheckoutComponents = () => {
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

  /*const lookupEmail = (email) => {
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
  };*/

  var formatPrices = () => {
    var prices = document.querySelectorAll('td.price_column');
    prices.forEach(cell => {
      var price = parseFloat(cell.getAttribute('beacon-price'));
      cell.innerText = formatCurrency(price);
    });
  };
  formatPrices();
  updateCheckoutComponents();
  setViewMode();
  cartBackButton.addEventListener('click', ev => {
    history.pushState({}, '', '/omni/');
    dispatchEvent(new PopStateEvent('popstate', {}));
    ev.preventDefault();
  });
  var quantityFields = [stwQuantityField, arkGiftQuantityField, ark2GiftQuantityField, arkSAQuantityField, arkSAGiftQuantityField];
  for (var quantityField of quantityFields) {
    if (quantityField) {
      quantityField.addEventListener('input', ev => {
        updateTotal();
      });
    }
  }
  arkCheckbox.addEventListener('change', ev => {
    updateTotal();
  });
  if (ark2Checkbox) {
    ark2Checkbox.addEventListener('change', ev => {
      updateTotal();
    });
  }
  stripeCheckoutButton.addEventListener('click', ev => {
    ev.target.disabled = true;
    var includeArk = cart.arkLicense !== null && arkCheckbox.checked;
    var stwQuantity = Math.max(Math.min(stwQuantityField.value, 10), 0);
    var arkGiftQuantity = Math.max(Math.min(arkGiftQuantityField.value, 10), 0);
    var includeArk2 = ark2Checkbox && ark2Checkbox.checked;
    var ark2GiftQuantity = ark2GiftQuantityField && Math.max(Math.min(ark2GiftQuantityField.value, 10), 0);
    var params = new URLSearchParams();
    params.append('email', cart.email);
    params.append('ark', includeArk);
    params.append('ark2', includeArk2);
    params.append('ark_gift', arkGiftQuantity);
    params.append('ark2_gift', ark2GiftQuantity);
    params.append('stw', stwQuantity);
    BeaconWebRequest.post('/omni/begin', params).then(response => {
      try {
        var obj = JSON.parse(response.body);
        if (sessionStorage) {
          sessionStorage.setItem('client_reference_id', obj.client_reference_id);
        }
        window.location.href = obj.url;
      } catch (e) {
        console.log(e);
        BeaconDialog.Show('There was an error starting the checkout process.', e.message);
      }
    }).catch(error => {
      var message = error.body;
      try {
        var obj = JSON.parse(message);
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
      updateCheckoutComponents();
    }, 250);
  });
  currencyMenu.addEventListener('change', ev => {
    var params = new URLSearchParams();
    params.append('currency', ev.target.value);
    BeaconWebRequest.get("/omni/currency?".concat(params.toString())).then(response => {
      location.reload();
    }).catch(error => {
      BeaconDialog.show('Sorry, there was a problem setting the currency.', error.body);
    });
    return false;
  });
  var currencyLinks = document.querySelectorAll('.currency-button');
  for (var link of currencyLinks) {
    link.addEventListener('click', ev => {
      ev.preventDefault();
      var linkCurrency = ev.target.getAttribute('currency');
      var params = new URLSearchParams();
      params.append('currency', linkCurrency);
      BeaconWebRequest.get("/omni/currency?".concat(params.toString())).then(response => {
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
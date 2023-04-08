"use strict";

document.addEventListener('GlobalizeLoaded', () => {
  var _ref, _sessionStorage$getIt, _sessionStorage, _localStorage;
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
  var buyButton = document.getElementById('buy-button');
  var cartBackButton = document.getElementById('cart_back_button');
  var stripeCheckoutButton = document.getElementById('stripe_checkout_button');
  var emailField = document.getElementById('checkout_email_field');
  var totalField = document.getElementById('total_field');
  var currencyMenu = document.getElementById('currency-menu');
  var requiredPageElements = [pageLanding, pageCart, stwQuantityField, arkGiftQuantityField, arkCheckbox, arkCheckboxFrame, arkOwnedCaption, buyButton, cartBackButton, stripeCheckoutButton, emailField, totalField, currencyMenu];
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
  var globalize = Globalize('en');
  var currencyFormatter = globalize.currencyFormatter(currencyCode);
  var status = {
    checkingEmail: false,
    ownsArk: false,
    ownsArk2: false,
    ownsArkSA: false
  };
  var updateTotal = () => {
    var includeArk = status.ownsArk === false && arkCheckbox.checked;
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
      var firstYearPrice = status.ownsArk || status.ownsArkSA ? arkSAPrice / 2 : arkSAPrice;
      var additionalYearPrice = arkSAPrice / 2;
      var firstYear = Math.min(Math.max(arkSAQuantity, 0), 1);
      var additionalYears = Math.max(arkSAQuantity - 1, 0);
      total += firstYearPrice * firstYear + additionalYearPrice * additionalYears + arkSAGiftQuantity * arkSAGiftPrice;
    }
    totalField.innerHTML = formatCurrency(total);
    stripeCheckoutButton.disabled = total == 0 || status.checkingEmail || validateEmail(emailField.value) == false;
  };
  var formatCurrency = amount => {
    return currencyFormatter(amount);
  };
  var updateCheckoutComponents = () => {
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
  var validateEmail = email => {
    var re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).trim().toLowerCase());
  };
  var lookupEmail = email => {
    var processPurchases = purchases => {
      status.ownsArk = false;
      status.ownsArk2 = false;
      for (var purchase of purchases) {
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
      var params = new URLSearchParams();
      params.append('email', email);
      BeaconWebRequest.get("/omni/lookup?".concat(params.toString())).then(response => {
        status.checkingEmail = false;
        try {
          var obj = JSON.parse(response.body);
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
    var includeArk = status.ownsArk === false && arkCheckbox.checked;
    var stwQuantity = Math.max(Math.min(stwQuantityField.value, 10), 0);
    var arkGiftQuantity = Math.max(Math.min(arkGiftQuantityField.value, 10), 0);
    var includeArk2 = ark2Checkbox && ark2Checkbox.checked;
    var ark2GiftQuantity = ark2GiftQuantityField && Math.max(Math.min(ark2GiftQuantityField.value, 10), 0);
    var params = new URLSearchParams();
    params.append('email', emailField.value);
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
      lookupEmail(emailField.value);
      updateTotal();
    }, 250);
  });
  var email = (_ref = (_sessionStorage$getIt = (_sessionStorage = sessionStorage) === null || _sessionStorage === void 0 ? void 0 : _sessionStorage.getItem('email')) !== null && _sessionStorage$getIt !== void 0 ? _sessionStorage$getIt : (_localStorage = localStorage) === null || _localStorage === void 0 ? void 0 : _localStorage.getItem('email')) !== null && _ref !== void 0 ? _ref : null;
  if (email) {
    emailField.value = email;
    lookupEmail(email);
  }
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
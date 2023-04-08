"use strict";

function _classStaticPrivateFieldSpecSet(receiver, classConstructor, descriptor, value) { _classCheckPrivateStaticAccess(receiver, classConstructor); _classCheckPrivateStaticFieldDescriptor(descriptor, "set"); _classApplyDescriptorSet(receiver, descriptor, value); return value; }
function _classApplyDescriptorSet(receiver, descriptor, value) { if (descriptor.set) { descriptor.set.call(receiver, value); } else { if (!descriptor.writable) { throw new TypeError("attempted to set read only private field"); } descriptor.value = value; } }
function _classStaticPrivateFieldSpecGet(receiver, classConstructor, descriptor) { _classCheckPrivateStaticAccess(receiver, classConstructor); _classCheckPrivateStaticFieldDescriptor(descriptor, "get"); return _classApplyDescriptorGet(receiver, descriptor); }
function _classCheckPrivateStaticFieldDescriptor(descriptor, action) { if (descriptor === undefined) { throw new TypeError("attempted to " + action + " private static field before its declaration"); } }
function _classCheckPrivateStaticAccess(receiver, classConstructor) { if (receiver !== classConstructor) { throw new TypeError("Private static access of wrong provenance"); } }
function _classApplyDescriptorGet(receiver, descriptor) { if (descriptor.get) { return descriptor.get.call(receiver); } return descriptor.value; }
class BeaconCurrency {
  static get currencyCode() {
    return _classStaticPrivateFieldSpecGet(this, BeaconCurrency, _currencyCode);
  }
  static set currencyCode(newCurrencyCode) {
    _classStaticPrivateFieldSpecSet(this, BeaconCurrency, _currencyCode, newCurrencyCode);
    _classStaticPrivateFieldSpecSet(this, BeaconCurrency, _defaultFormatter, this.getFormatter(newCurrencyCode));
  }
  static getFormatter(currencyCode) {
    if (!_classStaticPrivateFieldSpecGet(this, BeaconCurrency, _formatters)[currencyCode] && _classStaticPrivateFieldSpecGet(this, BeaconCurrency, _globalize)) {
      _classStaticPrivateFieldSpecGet(this, BeaconCurrency, _formatters)[currencyCode] = _classStaticPrivateFieldSpecGet(this, BeaconCurrency, _globalize).currencyFormatter(currencyCode);
    }
    return _classStaticPrivateFieldSpecGet(this, BeaconCurrency, _formatters)[currencyCode];
  }
  static get defaultFormatter() {
    return _classStaticPrivateFieldSpecGet(this, BeaconCurrency, _defaultFormatter);
  }
  static load() {
    var dataFiles = ['supplemental/likelySubtags.json', 'main/en/numbers.json', 'supplemental/numberingSystems.json', 'supplemental/plurals.json', 'supplemental/ordinals.json', 'main/en/currencies.json', 'supplemental/currencyData.json'];
    var dataPromises = [];
    for (var dataFile of dataFiles) {
      dataPromises.push(BeaconWebRequest.get("/assets/scripts/thirdparty/cldr/".concat(dataFile)).then(response => {
        try {
          Globalize.load(JSON.parse(response.body));
        } catch (loadErr) {
          console.log(loadErr);
        }
      }).catch(err => {
        console.log("Error: ".concat(err.statusText));
      }));
    }
    Promise.all(dataPromises).then(() => {
      _classStaticPrivateFieldSpecSet(this, BeaconCurrency, _globalize, Globalize('en'));
      if (_classStaticPrivateFieldSpecGet(this, BeaconCurrency, _currencyCode) && !_classStaticPrivateFieldSpecGet(this, BeaconCurrency, _defaultFormatter)) {
        _classStaticPrivateFieldSpecSet(this, BeaconCurrency, _defaultFormatter, this.getFormatter(_classStaticPrivateFieldSpecGet(this, BeaconCurrency, _currencyCode)));
      }
      var prices = document.querySelectorAll('.formatted-price');
      prices.forEach(elem => {
        var _elem$getAttribute;
        var price = parseFloat((_elem$getAttribute = elem.getAttribute('beacon-price')) !== null && _elem$getAttribute !== void 0 ? _elem$getAttribute : elem.innerText);
        var currency = elem.getAttribute('beacon-currency');
        if (currency) {
          elem.innerText = BeaconCurrency.getFormatter(currency)(price);
        } else {
          elem.innerText = BeaconCurrency.defaultFormatter(price);
        }
      });
      document.dispatchEvent(new Event('GlobalizeLoaded'));
    });
  }
}
var _globalize = {
  writable: true,
  value: null
};
var _formatters = {
  writable: true,
  value: {}
};
var _currencyCode = {
  writable: true,
  value: null
};
var _defaultFormatter = {
  writable: true,
  value: null
};
document.addEventListener('DOMContentLoaded', () => {
  BeaconCurrency.load();
});
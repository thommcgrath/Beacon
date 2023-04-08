"use strict";

document.addEventListener('DOMContentLoaded', () => {
  var stwForm = document.getElementById('stw_form');
  var emailField = document.getElementById('stw_email_field');
  var joinButton = document.getElementById('stw_join_button');
  var arkRadio = document.getElementById('ark_radio');
  var arkSARadio = document.getElementById('arksa_radio');
  var ark2Radio = document.getElementById('ark2_radio');
  var radios = [arkRadio, arkSARadio, ark2Radio];
  var stwContainer = document.getElementById('stw_container');
  if (!(stwForm && emailField && joinButton && arkRadio && stwContainer)) {
    console.log('Missing page elements');
    return;
  }
  stwForm.addEventListener('submit', ev => {
    var encrypt = new JSEncrypt();
    encrypt.setPublicKey(stwPublicKey);
    var encrypted = encrypt.encrypt(emailField.value);
    joinButton.disabled = true;
    var productId = radios.filter(radio => radio && radio.checked)[0].value;
    var fields = new URLSearchParams();
    fields.append('email', encrypted);
    fields.append('product_id', productId);
    BeaconWebRequest.post('submit', fields).then(response => {
      try {
        var obj = JSON.parse(response.body);
        stwContainer.innerText = "Ok, ".concat(obj.email, " is now on the list! If selected, you will receive an email with instructions.");
      } catch (e) {
        console.log(e);
      }
    }).catch(error => {
      switch (error.status) {
        case 404:
          BeaconDialog.show('Unable to submit the email address', 'The receiver script was not found.');
          break;
        case 400:
          try {
            var obj = JSON.parse(error.body);
            BeaconDialog.show('Sorry, that didn\'t work.', obj.error);
          } catch (e) {
            console.log(e);
            BeaconDialog.show('Sorry, that didn\'t work.', 'There was a javascript error.');
          }
          break;
        default:
          BeaconDialog.show('Unable to submit the email address', "Sorry, there was a ".concat(error.status, " error: ").concat(error.body));
          break;
      }
      joinButton.disabled = false;
    });
    ev.preventDefault();
    return true;
  });
});
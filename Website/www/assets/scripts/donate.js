window.addEventListener('load', function(event) {
	console.log('Hello World');
	
	var stripe_amount_field = document.getElementById('stripe_amount_field');
	var stripe_donate_button = document.getElementById('stripe_donate_button');
	
	stripe_amount_field.last_amount = 0;
	
	var change_function = function(event) {
		var amount = event.target.value;
		if (amount.substring(0, 1) == '$') {
			amount = amount.substring(1);
		}
		amount = parseFloat(amount);
		
		if (isNaN(amount)) {
			amount = 0;
		}
		
		if (amount == stripe_amount_field.last_amount) {
			return;
		}
		
		stripe_amount_field.last_amount = amount;
		
		if (amount == 0) {
			stripe_donate_button.textContent = 'Make a Donation';
		} else {
			stripe_donate_button.textContent = 'Donate $' + amount.toFixed(2);
		}
	};
	
	stripe_amount_field.addEventListener('change', change_function);
	stripe_amount_field.addEventListener('input', change_function);
	stripe_amount_field.addEventListener('propertychange', change_function);
	stripe_amount_field.addEventListener('keypress', change_function);
	
	var stripe_handler = StripeCheckout.configure({
		key: document.getElementById('stripe_public_key').value,
		locale: 'auto',
		zipCode: true,
		panelLabel: 'Donate {{amount}}',
		image: '/assets/images/beacon-stripe-icon.png',
		token: function(token) {
			document.getElementById('stripe_token_field').value = token.id;
			document.getElementById('stripe_email_field').value = token.email;
			document.getElementById("stripe_checkout_form").submit();
		}
	});
	
	stripe_donate_button.addEventListener('click', function(event) {
		var amount = stripe_amount_field.last_amount * 100;
		if (amount == 0) {
			alert('You should enter a donation amount first.');
			return;
		} else if (amount > 100000) {
			alert('While the generosity is appreciated, maybe keep the amount more reasonable?');
			return;
		}
		
		document.getElementById('stripe_confirmed_amount_field').value = amount;
		
		stripe_handler.open({
			name: 'Beacon',
			description: 'Loot editor for Ark: Survival Evolved',
			amount: amount
		});
		event.preventDefault();
	});
});
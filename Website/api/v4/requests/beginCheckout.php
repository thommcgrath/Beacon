<?php

use BeaconAPI\v4\{CartBundle, Core, License, Response, User};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes = [];
	$authScheme = Core::kAuthSchemeNone;
}

function handleRequest(array $context): Response {
	if (!Core::IsJsonContentType()) {
		return Response::NewJsonError(message: 'This endpoint expects a JSON body.', code: 'incorrectContentType', httpStatus: 400);
	}

	$cart = Core::BodyAsJson();
	$email = strtolower(trim($cart['email'] ?? ''));
	if (BeaconEmail::IsEmailValid($email) === false) {
		return Response::NewJsonError(message: 'Email is not valid.', code: 'invalidEmail', httpStatus: 400);
	}
	$refundAgreed = filter_var($cart['refundPolicyAgreed'] ?? false, FILTER_VALIDATE_BOOLEAN);
	$bundles = $cart['items'] ?? [];
	$currency = strtoupper($cart['currencyCode'] ?? 'USD');
	$subscriptionMode = filter_var($cart['subscriptionMode'] ?? false, FILTER_VALIDATE_BOOLEAN);
	$trialDays = min(filter_var($cart['trialDays'] ?? 1, FILTER_VALIDATE_INT), 30);
	$cancelUrl = $cart['cancelUrl'] ?? '';
	$hostOverride = $cart['host'] ?? 'https://' . BeaconCommon::Domain();

	if (count($bundles) === 0) {
		return Response::NewJsonError(message: 'The cart is empty.', code: 'emptyCart', httpStatus: 400);
	} elseif ($refundAgreed === false) {
		return Response::NewJsonError(message: 'The refund policy was not agreed to.', code: 'declinedRefundPolicy', httpStatus: 400);
	}

	$database = BeaconCommon::Database();
	$clientReferenceId = null;
	if (isset($cart['affiliateId'])) {
		$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM public.affiliate_tracking WHERE client_reference_id = $1) AS valid;', $cart['affiliateId']);
		if ($rows->RecordCount() === 1 && $rows->Field('valid') == true) {
			$clientReferenceId = $cart['affiliateId'];
		}
	}

	$userIsSuspect = false;
	$user = null;
	$licenses = [];
	try {
		$rows = $database->Query('SELECT uuid_for_email($1) AS email_id;', $email);
		$emailId = $rows->Field('email_id');
		$licenses = License::Search(['emailId' => $emailId], true);

		$user = User::Fetch($email);
		if (is_null($user) === false) {
			if ($user->IsBanned()) {
				return Response::NewJsonError(message: 'Stripe was unable to start the checkout session.', code: 'checkoutSessionFailed', httpStatus: 400);
			}
		}
	} catch (Exception $err) {
	}

	try {
		if (is_null($user)) {
			$url = 'https://api.cleantalk.org/?method_name=email_check&auth_key=' . urlencode(BeaconCommon::GetGlobal('CleanTalk Email Check Key')) . '&email=' . urlencode($email);
			$curl = curl_init($url);
			curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
			$body = curl_exec($curl);
			$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
			if ($status === 200) {
				$parsed = json_decode($body, TRUE);
				$data = $parsed['data'];
				$result = $data[$email]['result'];
				switch ($result) {
				case 'NOT_EXISTS':
				case 'MX_FAIL':
				case 'MX_FAIL':
					// Confirmed failure
					return Response::NewJsonError(message: 'We were unable to verify that your email address exists. This is probably due to a typo, but if we are wrong, create an account to skip this check.', code: 'invalidEmail', httpStatus: 400);
				}
			}
		}
	} catch (Exception $err) {
	}

	$api = new BeaconStripeAPI(BeaconCommon::GetGlobal('Stripe_Secret_Key'));
	if ($userIsSuspect === false) {
		$valueLists = $api->GetValueLists([$email, BeaconCommon::RemoteAddr(false)]);
		$userIsSuspect = is_null($valueLists) || count($valueLists) > 0;
	}

	$paymentMethodRows = $database->Query('SELECT code FROM public.find_payment_methods($1, $2, $3);', $currency, $userIsSuspect, $subscriptionMode);
	$paymentMethods = [];
	while (!$paymentMethodRows->EOF()) {
		$paymentMethods[] = $paymentMethodRows->Field('code');
		$paymentMethodRows->MoveNext();
	}

	if (BeaconCommon::IsOriginBeacon($cancelUrl) === false) {
		return Response::NewJsonError(message: 'Cancel URL is not a Beacon-hosted URL.', code: 'invalidUrl', httpStatus: 400);
	}
	$successUrl = "{$hostOverride}/omni/welcome/?session={CHECKOUT_SESSION_ID}";
	if (BeaconCommon::IsOriginBeacon($successUrl) === false) {
		return Response::NewJsonError(message: 'Host override is not a Beacon-hosted domain.', code: 'invalidUrl', httpStatus: 400);
	}

	$payment = [
		'client_reference_id' => $clientReferenceId,
		'customer_email' => $email,
		'payment_method_types' => $paymentMethods,
		'currency' => $currency,
		'mode' => 'payment',
		'success_url' => $successUrl,
		'cancel_url' => $cancelUrl,
		'billing_address_collection' => 'required',
		'automatic_tax' => ['enabled' => 'true'],
		'line_items' => [],
	];
	if (is_null($user) === false) {
		$payment['metadata']['Beacon User UUID'] = $user->UserId();
	}

	try {
		$customers = $api->GetCustomersByEmail($email);
		if (is_null($customers) === false && is_array($customers) && array_key_exists('data', $customers) && count($customers['data']) >= 1) {
			$customer = $customers['data'][0];
			$payment['customer'] = $customer['id'];
			$payment['customer_update'] = ['address' => 'auto', 'name' => 'auto'];
			unset($payment['customer_email']);

			if ($userIsSuspect === false) {
				$failures = $api->GetFailuresByCustomer($customer['id']);
				$userIsSuspect = is_null($failures) || count($failures) >= 3;
			}
		}
	} catch (Exception $err) {
	}

	$lines = [];
	if ($subscriptionMode) {
		// Load subscriptions
		$results = $database->Query('SELECT products.game_id, products.product_id, products.product_type, products.monthly_price_id, products.yearly_price_id FROM public.products WHERE products.active = TRUE AND products.product_type = $1;', 'Subscription');
		while (!$results->EOF()) {
			$productId = $results->Field('product_id');
			$gameId = $results->Field('game_id');
			$productType = $results->Field('product_type');
			$monthlyPriceId = $results->Field('monthly_price_id');
			$yearlyPriceId = $results->Field('yearly_price_id');

			$products[$gameId] = [
				'ProductId' => $productId,
				'Monthly' => [
					'PriceId' => $monthlyPriceId,
				],
				'Yearly' => [
					'PriceId' => $yearlyPriceId,
				],
			];

			$results->MoveNext();
		}

		foreach ($bundles as $bundle) {
			$bundle = new CartBundle($bundle);
			$productIds = $bundle->ProductIds();
			$multipleProducts = count($productIds) > 1;
			foreach ($productIds as $productId) {
				$rows = $database->Query('SELECT stripe_id FROM public.user_subscriptions WHERE email_id = $1 AND product_id = $2 AND date_expires > CURRENT_TIMESTAMP;', $emailId, $productId);
				if ($rows->RecordCount() > 0) {
					if ($multipleProducts === false) {
						// Forward to the success page
						$checkoutSession = $api->FindCheckoutSession($rows->Field('stripe_id'));
						if (is_null($checkoutSession) === false) {
							return Response::NewJson(obj: [
								'error' => false,
								'client_reference_id' => $clientReferenceId,
								'url' => str_replace('{CHECKOUT_SESSION_ID}', $checkoutSession['id'], $successUrl),
							], code: 201);
						}
					}

					// Nothing logical to do here, so throw an error
					return Response::NewJsonError(message: 'User already has an active subscription.', code: 'duplicateSubscription', httpStatus: 400, details: $rows->Field('stripe_id'));
				}

				// Verify that the user is eligible for a trial.
				if (isset($payment['subscription_data']['trial_period_days'])) {
					$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM public.subscriptions INNER JOIN public.purchases ON (subscriptions.last_purchase_id = purchases.purchase_id) WHERE subscriptions.product_id = $1 AND purchases.purchaser_email = $2) AS subscription_exists;', $productId, $emailId);
					if ($rows->Field('subscription_exists')) {
						$trialDays = 1;
					}
				}
			}

			if ($bundle->isGift()) {
				return Response::NewJsonError(message: 'Cannot gift subscriptions.', code: 'subscriptionIsGift', httpStatus: 400);
			}

			if ($bundle->getQuantity($products['Sentinel']['ProductId']) > 0) {
				$payment['metadata']['beacon-has-sentinel'] = 'true';
				if ($bundle->isAnnual()) {
					$lines[$products['Sentinel']['Yearly']['PriceId']] = $bundle->getQuantity($products['Sentinel']['ProductId']);
				} else {
					$lines[$products['Sentinel']['Monthly']['PriceId']] = $bundle->getQuantity($products['Sentinel']['ProductId']);
				}
			}
		}
	} else {
		// Load one time products
		$results = $database->Query('SELECT products.game_id, products.tag, products.product_id, product_prices.price_id, products.product_type FROM public.products INNER JOIN public.product_prices ON (product_prices.product_id = products.product_id) WHERE product_prices.currency = $1 AND products.active = TRUE AND products.product_type = $2;', $currency, 'One-Time');
		$products = [];
		while (!$results->EOF()) {
			$productId = $results->Field('product_id');
			$priceId = $results->Field('price_id');
			$gameId = $results->Field('game_id');
			$tag = $results->Field('tag');
			$productType = $results->Field('product_type');

			$products[$gameId][$tag] = [
				'ProductId' => $productId,
				'PriceId' => $priceId,
			];

			$results->MoveNext();
		}

		$includeArk = isset($products['Ark']['Base']);
		$includeArkSA = isset($products['ArkSA']['Base']);

		$gameIds = [];
		$gameRows = $database->Query('SELECT game_id FROM public.games WHERE public = TRUE AND game_id NOT IN ($1, $2) ORDER BY game_id;', 'Ark', 'ArkSA');
		while (!$gameRows->EOF()) {
			$gameIds[] = $gameRows->Field('game_id');
			$gameRows->MoveNext();
		}

		foreach ($bundles as $bundle) {
			$bundle = new CartBundle($bundle);

			$wantsArk = $includeArk ? $bundle->getQuantity($products['Ark']['Base']['ProductId']) > 0 : false;
			$wantsArkSAYears = $includeArkSA ? $bundle->getQuantity($products['ArkSA']['Base']['ProductId']) + $bundle->getQuantity($products['ArkSA']['Upgrade']['ProductId']) + $bundle->getQuantity($products['ArkSA']['Renewal']['ProductId']) : 0;

			if ($bundle->isGift()) {
				if ($wantsArk) {
					$payment['metadata']['beacon-has-omni'] = 'true';
					$lines[$products['Ark']['Base']['PriceId']] = ($lines[$products['Ark']['Base']['PriceId']] ?? 0) + 1;
				}

				if ($wantsArkSAYears > 0) {
					$payment['metadata']['beacon-has-omni'] = 'true';
					if ($wantsArk) {
						$lines[$products['ArkSA']['Upgrade']['PriceId']] = ($lines[$products['ArkSA']['Upgrade']['PriceId']] ?? 0) + 1;
					} else {
						$lines[$products['ArkSA']['Base']['PriceId']] = ($lines[$products['ArkSA']['Base']['PriceId']] ?? 0) + 1;
					}
					if ($wantsArkSAYears > 1) {
						$lines[$products['ArkSA']['Renewal']['PriceId']] = ($lines[$products['ArkSA']['Renewal']['PriceId']] ?? 0) + ($wantsArkSAYears - 1);
					}
				}

				foreach ($gameIds as $gameId) {
					if (isset($products[$gameId]['Base']) === false) {
						continue;
					}

					$payment['metadata']['beacon-has-omni'] = 'true';
					$renewable = isset($products[$gameId]['Renewal']);
					$baseProduct = $products[$gameId]['Base'];

					if ($renewable) {
						$renewalProduct = $products[$gameId]['Renewal'];
						$years = $bundle->getQuantity($baseProduct['ProductId']) + $bundle->getQuantity($renewalProduct['ProductId']);
						if ($years < 1) {
							continue;
						}
						$lines[$baseProduct['PriceId']] = ($lines[$baseProduct['PriceId']] ?? 0) + 1;
						if ($years > 1) {
							$lines[$renewalProduct['PriceId']] = ($lines[$renewalProduct['PriceId']] ?? 0) + ($years - 1);
						}
					} else {
						if ($bundle->getQuantity($baseProduct['ProductId']) > 0) {
							$lines[$baseProduct['PriceId']] = 1;
						}
					}
				}
			} else {
				$ownsArk = $includeArk && findLicense($licenses, $products['Ark']['Base']['ProductId']) !== null;
				$ownsArkSA = $includeArkSA && findLicense($licenses, $products['ArkSA']['Base']['ProductId']) !== null;

				if ($wantsArk && !$ownsArk) {
					$lines[$products['Ark']['Base']['PriceId']] = ($lines[$products['Ark']['Base']['PriceId']] ?? 0) + 1;
				}

				if ($wantsArkSAYears > 0) {
					if ($ownsArkSA) {
						$lines[$products['ArkSA']['Renewal']['PriceId']] = ($lines[$products['ArkSA']['Renewal']['PriceId']] ?? 0) + $wantsArkSAYears;
					} else {
						if ($wantsArk || $ownsArk) {
							$lines[$products['ArkSA']['Upgrade']['PriceId']] = ($lines[$products['ArkSA']['Upgrade']['PriceId']] ?? 0) + 1;
						} else {
							$lines[$products['ArkSA']['Base']['PriceId']] = ($lines[$products['ArkSA']['Base']['PriceId']] ?? 0) + 1;
						}
						if ($wantsArkSAYears > 1) {
							$lines[$products['ArkSA']['Renewal']['PriceId']] = ($lines[$products['ArkSA']['Renewal']['PriceId']] ?? 0) + ($wantsArkSAYears - 1);
						}
					}
				}

				foreach ($gameIds as $gameId) {
					if (isset($products[$gameId]['Base']) === false) {
						continue;
					}

					$renewable = isset($products[$gameId]['Renewal']);
					$baseProduct = $products[$gameId]['Base'];

					if ($renewable) {
						$renewalProduct = $products[$gameId]['Renewal'];
						$years = $bundle->getQuantity($baseProduct['ProductId']) + $bundle->getQuantity($renewalProduct['ProductId']);
						if ($years < 1) {
							continue;
						}
						$isOwned = findLicense($licenses, $baseProduct['ProductId']) !== null;
						if ($isOwned) {
							$lines[$renewalProduct['PriceId']] = ($lines[$renewalProduct['PriceId']] ?? 0) + $years;
						} else {
							$lines[$baseProduct['PriceId']] = ($lines[$baseProduct['PriceId']] ?? 0) + 1;
							if ($years > 1) {
								$lines[$renewalProduct['PriceId']] = ($lines[$renewalProduct['PriceId']] ?? 0) + ($years - 1);
							}
						}
					} else {
						if ($bundle->getQuantity($baseProduct['ProductId']) > 0 && findLicense($licenses, $baseProduct['ProductId']) === null) {
							$lines[$baseProduct['PriceId']] = 1;
						}
					}
				}
			}
		}
	}

	foreach ($lines as $priceId => $quantity) {
		$payment['line_items'][] = [
			'price' => $priceId,
			'quantity' => $quantity
		];
	}
	if (count($payment['line_items']) === 0) {
		return Response::NewJsonError(message: 'The cart does not contain any products that are valid for email ' . $email . '.', code: 'emptyCart', httpStatus: 400);
	}

	if ($subscriptionMode) {
		$payment['mode'] = 'subscription';
		$payment['payment_method_collection'] = 'always';
		if ($trialDays > 1) {
			$payment['subscription_data'] = [
				'trial_period_days' => $trialDays,
				'trial_settings' => [
					'end_behavior' => [
						'missing_payment_method' => 'create_invoice',
					],
				],
			];
		}
	}

	$encodedCart = BeaconCommon::Base64UrlEncode(gzencode(json_encode($bundles)));
	if (strlen($encodedCart) > 500) {
		return Response::NewJsonError(message: 'Cart is too large.', code: 'cartTooLarge', httpStatus: 400);
	}
	$payment['metadata']['Beacon Cart'] = $encodedCart;

	$session = $api->CreateCheckoutSession($payment);
	if (is_null($session)) {
		$attachments = [
			[
				'title' => 'Cart Details',
				'fields' => [
					[
						'title' => 'Currency',
						'value' => $currency,
						'short' => true
					],
					[
						'title' => 'Bundles',
						'value' => '```' . json_encode($bundles, JSON_PRETTY_PRINT) . '```'
					]
				],
				'ts' => time()
			]
		];

		BeaconCommon::PostSlackRaw(json_encode(['text' => 'There was an error starting a checkout session.', 'attachments' => $attachments]));
		return Response::NewJsonError(message: 'There was an error starting a checkout session.', code: 'checkoutSessionFailed', httpStatus: 500);
	}

	if ($trialDays > 3) {
		BeaconCommon::PostSlackMessage('A trial of ' . $trialDays . ' was just started for ' . $email . '.');
	}

	return Response::NewJson(obj: [
		'error' => false,
		'client_reference_id' => $clientReferenceId,
		'url' => $session['url'],
	], code: 201);
}

function findLicense(array $licenses, string $productId): array|License|null {
	foreach ($licenses as $license) {
		if ((is_array($license) && $license['product_id'] === $productId) || ($license instanceof License && $license->ProductId() === $productId)) {
			return $license;
		}
	}
	return null;
}

?>

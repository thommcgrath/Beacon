"use strict";

import { formatPrices } from "./common.js";

document.addEventListener('beaconViewPurchase', ({currencyCode}) => {
	formatPrices(currencyCode);
});

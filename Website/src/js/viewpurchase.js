"use strict";

import { formatPrices, formatDates } from "./common.js";

document.addEventListener('beaconViewPurchase', ({currencyCode}) => {
	formatPrices(currencyCode);
	formatDates(true, true);
});

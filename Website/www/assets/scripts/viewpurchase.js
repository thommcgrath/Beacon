(()=>{"use strict";document.addEventListener("beaconViewPurchase",(function(e){var t,n=e.currencyCode;t=n,document.querySelectorAll(".formatted-price").forEach((function(e){var n,r,o=parseFloat(null!==(n=e.getAttribute("beacon-price"))&&void 0!==n?n:e.innerText),c=e.getAttribute("beacon-currency"),a=(r=null!=c?c:t,Intl.NumberFormat("en-US",{style:"currency",currency:r}).format);a&&(e.innerText=a(o))})),function(){var e=arguments.length>0&&void 0!==arguments[0]&&arguments[0],t=arguments.length>1&&void 0!==arguments[1]&&arguments[1];document.querySelectorAll("time").forEach((function(n){var r=new Date(n.getAttribute("datetime"));n.innerText=function(e){var t=arguments.length>1&&void 0!==arguments[1]&&arguments[1],n=arguments.length>2&&void 0!==arguments[2]&&arguments[2],r=Intl.DateTimeFormat().resolvedOptions(),o={dateStyle:"medium"};t&&(o.timeStyle="short");var c=Intl.DateTimeFormat(r.locale,o).format(e);return n&&(c="".concat(c," ").concat(r.timeZone)),c}(r,e,t)}))}(!0,!0)}))})();
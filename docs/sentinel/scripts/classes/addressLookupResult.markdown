---
title: AddressLookupResult
parent: Classes
grand_parent: Scripts
properties:
  - key: success
    type: Boolean
    notes: True if address lookup was successful. Lookup will fail for LAN addresses.
  - key: countryCode
    type: String
    notes: The 2 character ISO country code of the IP address. Only included on success.
  - key: continentCode
    type: String
    notes: The 2 character continent code of the IP address. One of `AF`, `AN`, `AS`, `EU`, `NA`, `OC`, or `SA`. Only included on success.
  - key: timezone
    type: String
    notes: The IANA timezone of the IP address. Only included on success.
  - key: vpn
    type: Boolean
    notes: True if the address is a known VPN address. Only included on success.
---
# {{page.title}}

{% capture sample_object %}
{
  "success": true,
  "countryCode": "AQ",
  "continentCode": "AN",
  "timezone": "Antarctica/Syowa",
  "vpn": false
}
{% endcapture %}
{% include sentinelclass.markdown sample=sample_object %}

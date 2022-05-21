---
title: Beacon Privacy and Security
parent: User Accounts
nav_order: 4
---
# Beacon Privacy and Security

## Basic Summary

- All user data is anonymous, even email addresses.
- Encryption is handled with 2048-bit RSA Public Key Cryptography.
- Beacon and its website are fully open source.

## More Details

### User Anonymity

Beacon stores only a single piece of identifiable information on each user: their username. Which of course, could be anything the user desires. User email addresses are stored as salted bcrypt hashes with k-anonymity. This allows email addresses to be confirmed during login, but cannot be reversed.

Beacon's payment processor, Stripe, does store some personally identifiable information. Stripe's privacy policy can be found at [https://stripe.com/us/privacy](https://stripe.com/us/privacy).

### User Security

Upon first launch, Beacon generates a cryptographically secure 128-bit random number to use as the user's UUID. This number is not based on any user or hardware information. Beacon also generates a 2048-bit RSA private key to use as proof of identity.

Unless the user chooses to disable community features when prompted at launch, Beacon will send the user's UUID and public key to the Beacon server. This grants the user access to community features, such as the ability to publish documents to the community library. This user is fully anonymous.

If the user decides to create a login with Beacon, some additional data is shared with Beacon's server. The user's password is run through the PBKDF2 algorithm to generate a key to encrypt the user's RSA _private_ key with 256-bit AES CBC. Beacon's database stores these encrypted private keys so they can be transported to other computers the user signs into. When signing into Beacon, the private key is delivered to the computer encrypted and decrypted on the computer, not on Beacon's server.

### Project Encryption

Some parts of a Beacon project are encrypted using the user's private key, such as server information and user-defined parts of the _Custom Config_ editor. If the user's private key cannot decrypt information from a project, that information is simply not loaded by Beacon.

### Analytics

There aren't any. Beacon does not utilize analytics of any kind, even on the website.

## Partner Privacy Policies

- [Stripe](https://stripe.com/us/privacy): Handles Beacon payments.
- [ZenDesk](https://www.zendesk.com/company/agreements-and-terms/privacy-policy/): Used for web and in-app support tickets. Files submitted to from inside Beacon are end-to-end encrypted and cannot be viewed by ZenDesk employees.
- [Bunny.net](https://bunny.net/privacy): Used for download hosting. Three days of anonymous download logs are stored.
- [Have I Been Pwned](https://haveibeenpwned.com/privacy): During signup, passwords are anonymously checked against the world's largest database of leaked passwords.
- [Postmark](https://postmarkapp.com/privacy-policy): Emails sent by Beacon are routed through Postmark to reduce the chances of messages going to spam boxes.
- [Wasabi](https://wasabi.com/legal/privacy-policy/): Used for long-term storage of user cloud files. Projects use their standard encryption techniques, everything else is end-to-end encrypted.
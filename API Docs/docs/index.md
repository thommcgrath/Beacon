# Welcome to the Beacon API

All of Beacon's online functionality is available in an open REST API. You can get engram lists, share documents, publish mod updates, and more.

## Requirements

Most lookup operations do not require authentication, but all operations which make changes do require authentication. Requests which require authentication must use RSA signatures to authenticate.

The API itself is open to all users. Every Beacon user has an identity file on their computer which contains the RSA key pair necessary to authenticate with the API.

JSON is used heavily in the API, so implementors should be able to parse and generate JSON payloads.

## Getting Started

There are four object types available by the API: [Document](document.md)s, [Engram](engram.md)s, [Mod](mod.md)s, and [User](user.md)s.

The easiest request to make is to get a list of all engrams. This is a GET request to https://thezaz.com/beacon/api/engram.php, which returns an array of JSON structures.

Dig into each of the objects listed above. If you need to make [authenticated requests](authenticating.md) then you should read up on how to do that too.
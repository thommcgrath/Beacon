## Content Verification Headers

Content verification is **optional** but is strongly recommended for uploading and downloading files.

Every request that Beacon makes will include a [Want-Content-Digest](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Want-Content-Digest) header. Currently, the value of this header is `sha-512=10,sha-256=9,md5=0,sha=0,unixsum=0,unixcksum=0,adler=0,crc32c=0` but check the actual header in case the value changes. For brevity, most example requests in this documentation omit this header.

If the server includes a `Content-Digest` response header with a compatible hash, Beacon will verify the response body and retry the request if the hash does not match. Beacon will attempt two retries (for a total of three attempts) before displaying an error to the user.

All Beacon requests that include a body also include a `Content-Digest` request header. At the time of this writing, Beacon requests contain both SHA-512 and SHA-256 hashes. If it cannot verify the request, the server should reply with a 406 status.
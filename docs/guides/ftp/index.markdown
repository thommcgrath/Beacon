---
title: Beacon FTP Support
parent: Other Guides
---
# {{page.title}}

Beacon supports importing and deploying to most FTP servers. This guide will help get you connected to your server.

To begin, open the Import window by clicking the **Import**{:.ui-keyword} button at the top of your project. Choose **Server With FTP Access**{:.ui-keyword} and you will be presented with a group of fields.

First, choose the connection mode using the **Mode**{:.ui-keyword} menu. There are four options: **FTP with Required TLS**{:.ui-keyword}, **SFTP**{:.ui-keyword}, **FTP with Implicit TLS**{:.ui-keyword}, and **FTP with Optional TLS**{:.ui-keyword}. The connection mode is the most important and will determine which of the other options will be active.

## Picking The Correct Mode

The correct mode depends heavily on what the server supports. The good news is most servers support TLS, so Beacon defaults to using that.

### FTP with TLS

You may have heard of SSL, which stands for Secure Socket Layer. You can sometimes see "SSL secured" on credit card pages. TLS, which stands for Transport Layer Security, is a newer version of SSL. In fact, SSL these almost always means TLS, because SSL has been insecure for a very long time.

Beacon defaults to **FTP with Required TLS**{:.ui-keyword} with the **Verify Server Certificate**{:.ui-keyword} option turned on. This means Beacon will need a secure connection to the server, and will verify the server's identity. This is the same level of security used when making purchases online.

If this fails to connect, try turning off the **Verify Server Certificate**{:.ui-keyword} option. Beacon will still require a secure connection, but will not verify the server's identity. It is not uncommon for hosts to use self-signed certificates, which will fail the identity verification process.

The **FTP with Optional TLS**{:.ui-keyword} option allows an insecure connection and should only be used if the server truly does not support TLS. However, Beacon will still try a TLS connection, just in case.

### Implicit TLS

Normally, TLS is enabled after the initial connection. With implicit TLS, Beacon will connect assuming that TLS is supported. Because this requires a different server behavior, FTP servers will usually run implicit TLS on a different port. Port 990 is the most common.

### SFTP

SFTP is FTP that runs over an SSH (Secure Socket Shell) connection. SSH supports a wide range of authentication schemes, of which Beacon supports password and public key authentication.

Password authentication is the most familiar, but most SSH servers do not allow password authentication.

Public key authentication requires a public and private key pair. The public key gets whitelisted on the server, while the private key remains on your computer. If your private key is encrypted, Beacon has a **Key Password**{:.ui-keyword} field to provide the key's password.

> Beacon uses libssh2 1.10.0 which does not support rsa-sha2-256 and rsa-sha2-256 keys. Most servers will (and should) reject RSA keys due to this.

#### Generate SSH Keys

Replace `Example` in the following examples with something to help you identify the public key later. This is often an email address.

| Key Type | Command |
| -- | -- |
| Ed25519 | `ssh-keygen -t ed25519 -C "Example"` |
| ECDSA | `ssh-keygen -t ecdsa -b 521 -C "Example"` |
| RSA | `ssh-keygen -t rsa -b 4096 -C "Example"` |

More details can be found at [ssh.com](https://www.ssh.com/academy/ssh/keygen#creating-an-ssh-key-pair-for-user-authentication).

#### Private Key Storage

Beacon can store the private key inside the project, which improves portability. If your project needs to be used on multiple devices or by multiple users, choosing to store the key inside the project will be much easier. The private key will be stored inside the encrypted portion of the project, which can only be decrypted by your Beacon account and any Beacon accounts the project has shared write access with.

Of course, even with Beacon's security, the most secure option is to not store the private key in the project. If the project needs to be used on multiple devices, every device will need to have the private key in the exact same path. On macOS, due to app sandboxing, the stored path may not be compatible with other devices. Keeping the key out of the project is only really viable for projects that are only used on a single device.
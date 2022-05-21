---
title: Solving Connection Problems to Beacon or Nitrado
parent: Troubleshooting
nav_order: 2
---
# Solving Connection Problems to Beacon or Nitrado

## Windows

### Solution 1: Run Windows Update

Both Beacon and Nitrado's servers require TLS 1.2 at the time of this writing. In some versions of Windows, these security protocols are disabled by default. [Windows Update KB3140245](https://support.microsoft.com/en-us/help/3140245/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-wi) enables support for these protocols. Follow the instructions in the linked article to either run Windows Update or install the update directly. If installing the update manually, make sure to choose the version appropriate for your computer. Most users are running a 64-bit version of Windows, so should choose an option for x64-based systems.

Even though the linked support article is specific to Windows 7, try Windows Update anyway. The KB3140245 update will not apply to Windows 8 systems, but Windows Update often fixes the issue anyway.

### Solution 2: Check Antivirus

Some Antivirus software can be particularly aggressive and block Beacon's connection to servers outside the user's country. Check your antivirus software for notices. Try whitelisting Beacon so your antivirus software will not interfere. For instructions, do a web search for "whitelist _name of your antivirus_" and it will hopefully be the top result.

### Solution 3: Install for All Users

Admin permission is required to install for all users, and that admin permission will allow Beacon's installer to run more tasks. In this mode, the installer will attempt to install the KB3140245 update, change the registry keys required to enable TLS 1.2 support, and install the Visual C++ runtime. If the previous steps didn't help, reinstalling for all users might solve the problem.

First uninstall Beacon. Your data will be safe. Then run the installer again. When asked wether to install for just you or all users, make sure to choose all users. If Beacon is already installed, the installer will not ask about installing for all users, so it is important to uninstall Beacon first.

## macOS

As of September 30th 2021, Beacon's online features can no longer function on macOS 10.11 El Capitan. Apple no longer issues security updates for the system, so when Let's Encrypt's root certificate expired, any application that relies on the system's built-in networking (like Beacon and Safari) can no longer connect to servers secured by Let's Encrypt.

Unfortunately this means options are extremely limited. The best option is to update macOS, which also supports Beacon 1.5 and all of its new features. If updating macOS is not an option, see the instructions under "Method 2: Use an activation file for a computer without internet" of [your account control panel](https://usebeacon.app/account/#omni). Online services still won't work, but you will have access to your Omni license at least.
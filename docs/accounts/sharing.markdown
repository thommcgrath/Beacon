---
title: Sharing Beacon Projects With Other Users
parent: User Accounts
nav_order: 3
---
# Sharing Beacon Projects With Other Users

Open the sharing panel using the share button in the toolbar of an opened cloud project.

![The default sharing panel](dcfd4714-01df-4f61-bbce-7327d6d2ed9c)

## Sharing via Link

The top section labeled _Read-Only Access_ contains a link that can be shared however you feel like. Use the _Copy_ button to quickly copy the entire link. It can be posted to web forums, Discord, sent via email, or even text messages. It works like any other link.

The shared project will not contain any private data, such as anything in the [Servers config editor](/configs/deployments.markdown) and anything encrypted inside the [Custom Config editor](/customcontent.markdown). The project will be updated as you save your project.

## Sharing to the Community

The middle section is used for sharing the project with the _Community_ tab in Beacon's _Projects_ view and on the [Browse Community Projects](https://usebeacon.app/browse/) section of the website.

To request your project be shared to the community, just click the _Share_ button. Sharing requests require approval. To increase the chances of approval, make sure your project has a good description in your projects's [Project Settings editor](/configs/metadata.markdown). Duplicated (or very similar) descriptions will not be approved.

If your project is approved, you may stop sharing at any time using the same button, which will be labelled _Unshare_ instead.

Just like sharing via a link, private data will not be available to other users.

## Sharing Write Access

For teams of admins, sharing a single project can make life much easier. Projects shared in this manner contain all the encrypted data and linked servers. This means a head admin could share the project with sub-admins who would have the ability to restart the server without the head admin giving out their Nitrado account information.

> Only the project owner may change who has write access to the project.

There are three ways to add a user to a project.

### Add Via Email Address

Press the _Add User_ button and enter the email address of the user's Beacon account. This does not email the user a link and the user's account must already exist.

### Add Via User UUID

Adding a user by their UUID is accurate and does not require the user to have a Beacon account, though their _Cloud and Community_ features must be enabled.

First, the user must choose "User Info" from the user menu with icon in the top right corner of Beacon's window.

![The tools drawer with Identity selected.](a89a6f35-477a-4ffe-adf1-085928d6ea77)

Inside the _User Info_ panel is a _User ID_ field. The full value of that field is needed to add the user.

![The Identity tab.](22ddcc04-3161-4434-8b25-5d4e5e82dd45)

> The value in the _Private Key_ area should **never** be shared with anybody. Ever. Not even Beacon tech support. Seriously.

Once you have the UUID of the desired user, press _Add User_ and enter the UUID.

![Adding the user by UUID.](0fb81d47-4d68-4fa5-9e61-29688d47d615)

If there is an error, check the UUID. If the UUID is correct, that means the user has their _Cloud and Community_ features turned off. The user should open use that same user menu and choose the _Enable Cloud & Community_ option. Once that is done, try adding the user again.

### Add Via Username

Adding a user by their username must be done with the **full** username, which includes an 8-character identifier after their name. The easiest way to find the correct value to enter is on the [user's control panel](https://usebeacon.app/account/).

![A user control panel, showing the full username at the top.](86dcee5a-7918-4567-947b-74372fb91df0)

The username with identifier tag will be shown at the top of the user's control panel.

Press the _Add User_ button and enter the value to continue.

![Adding the user by username.](ddbc9650-67d2-4ddd-9dc6-f9141178f443)

### After Adding a User

![The sharing panel with a user added.](61027a26-4cb9-46c8-bbd2-424ecb30bdd0)

Once a user has been added to the project, press the _Done_ button. **You must save your project before the changes will take effect.** Beacon will remind you of this any time you make changes to the authorized users. This is because Beacon must add to your project an encrypted value for each authorized user. There's no way for that to happen until the project is saved.

Now that the project has been shared and saved, the project will appear in each user's _Projects_ view under the _Cloud_ tab. Each user may open, edit, and save the project as if it were their own.

> Be careful to avoid multiple users editing the project at once. If User A saves the project while User B is still working on it, when User B saves the project, User A's changes would be reset. Beacon is unable to merge changes made by users.
---
title: Accounts
parent: All Games
grand_parent: Config Editors
supportedgames:
  - "Ark: Survival Ascended"
  - "Ark: Survival Evolved"
  - "7 Days to Die"
redirect_from:
  - /configs/sdtd/accounts/
  - /configs/ark/accounts/
  - /configs/arksa/accounts/
---
{% include editortitle.markdown %}

The **Accounts**{:.ui-keyword} editor allows you to control which of your connected services are part of your project for use with import, deploying, and server control.

## Importing Into New Projects

Creating a new project and pressing the **Import**{:.ui-keyword} button in the project toolbar will automatically find servers on every connected service on your account. Choosing to import servers from a service will automatically add the service to your project.

## Connecting Your First Service

At the top of the **Accounts**{:.ui-keyword} editor is the **Add Service**{:.ui-keyword} button. When you click the button, Beacon will check with your account to see if there are any services connected to your account. If there is not, or all the services have already been added to your project, you'll be asked instructed to go to the website to connect an external service with your account.

{% include image.html file="no-connections.png" file2x="no-connections@2x.png" caption="Adding your first external account." %}

{:.tip .titled}
> Tip
> 
> While this feature does not require a Beacon account, having one is strongly recommended.

Press **Connect**{:.ui-keyword} to be taken to the Beacon website to begin connecting external services.

{% include image.html file="connections-page.png" file2x="connections-page@2x.png" caption="The connections page with no connected services." %}

Below each service provider logo will be **Connect**{:.ui-keyword} and **Add Token**{:.ui-keyword} buttons, depending on the features supported by the service provider. **You do not need to use both options even if a service provider offers both.** The **Connect**{:.ui-keyword} option is easier and should be used when available.

### Add Token

Clicking the **Add Token**{:.ui-keyword} will show a window to add a "long life token" to your Beacon account.

{% include image.html file="nitrado-long-life.png" file2x="nitrado-long-life@2x.png" caption="Adding a Nitrado long life token." %}

At the top of the window will be instructions. **Pay attention to these instrutions**, as failure to follow them may result in a token that is not usable. The **Token Name**{:.ui-keyword} field allows giving this token a name used for organization, but will have no impact on how the service is used. The **Generate Token**{:.ui-keyword} button will take you to the service provider's website where you can generate the token, but you will need to follow their instructions.

Once you have generated a token, paste it into the **Token**{:.ui-keyword} field and press the **Add**{:.ui-keyword} button.

### Your Connected Services

Now that a service has been connected, it will appear in the **Connected Services**{:.ui-keyword} section. A service can be removed using the **Disconnect**{:.ui-keyword} or **Discard**{:.ui-keyword} buttons, depending on how the service was added.

{% include image.html file="account-connected.png" file2x="account-connected@2x.png" caption="When a service has been added, it will show in the Connected Services section." %}

## Adding Your Service to Your Project

Now that you have a service connected to your account, you're ready to add it to your project. Return to Beacon and press the **Add Service**{:.ui-keyword} button again. This time, your service can be selected from a menu.

{% include image.html file="add-account.png" file2x="add-account@2x.png" caption="Adding the external service to your project." %}

Press the **Add**{:.ui-keyword} button, and the service will be available to your project to use for importing, deploying, and server control.

{% include image.html file="account-added.png" file2x="account-added@2x.png" caption="The account is ready to use." %}

{% include affectedkeys.html %}
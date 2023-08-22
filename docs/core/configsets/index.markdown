---
title: Using Config Sets
parent: Core Features
nav_order: 0
---
# Using Config Sets
Anyone who manages a cluster, or even a server with occasional special events, can benefit from using Config Sets.

The feature is designed to act as an override for other values in a project. To put things into perspective, it may be helpful to realize that every Beacon project already has a Config Set in place. Above the editor selection bar, there is a pulldown menu which by default will read "Config Set: Base".

Let's say that you are managing three servers right now. The first server is The Island, the second is Ragnarok and the third is Fjordur. It is likely that on these maps, you are using similar settings between them, so you may already have considered using one project for all three of them. However, you may be thinking that while you have some general similarities in configuration, perhaps The Island was seemingly a bit too easy. You may be hesitant to make any changes in fear of making the other maps too difficult, so instead you decide to split your maps between different projects.

This is where the Config Set comes into play. With this feature, you are able to adjust values in a separate "container" that will override whichever values you think are needed and only on the map you want to change them on.

To return to the example, one possible solution could be that you wanted to increase the resistance of wild carnivores so they are more difficult to kill.

Assuming the project already has all of the servers associated with it, the first step is to create a new Config Set. There are a couple of different ways to do this, but the simplest is to click the Config Set: Base pulldown menu mentioned above.

From there, press the "Create and switch to new config set" option. 

A pop-up will appear asking to name the new config set. Let's call it "The Island Difficulty Boost".

After you press OK, you'll notice that most of Beacon looks similar, but it doesn't seem to have any of the settings you had filled in anymore. In reality, the other settings are still in the project, it's just that the new Config Set is starting from a blank slate.

Use the Creature Adjustments editor to increase the resistance of all of the wild carnivores (Hint: you can easily duplicate one adjustment to additional creatures with the Duplicate button after doing the first one).

With this out of the way, the next step is to tell Beacon that we want to associate this Config Set with The Island server. You may be thinking to yourself, "Where did my servers tab go?" This is another sign that you are not on the Base config set.

Press the pulldown menu from before, now labeled, "Config Set: The Island Difficulty Boost" and re-select the Base config set.

Once finished, enter the Servers tab and select your server for "The Island". You'll notice one of the fields will read "Config Sets: Base" next to a button that reads "Choose..."

The new menu that appears shows all of the other Config Sets associated with the project. Enable the checkbox next to your new Config Set and press OK. You are now officially finished!

Looking back on the server's tab Config Set field, you'll notice it now says "Base" followed by "The Island Difficulty Boost". When deploying the project, The Island map will have everything in the Base config set, except for what is in "The Island Difficulty Boost".

Since the new config set is not applied to the other servers, they will only receive what is in the "Base" config set.

It is possible to also apply mutliple config sets to the same server. From the Servers tab, the order that the sets are listed are the order of lowest to highest priority. You can re-arrange the order from the "Choose..." button as well by dragging the config sets as desired.




---
title: Groups
parent: Sentinel
---
# {{page.title}}

Sentinel groups are a collection of servers, users, scripts, and buckets. They can be used to share access to these resources to additional users, as well as reuse resources on multiple servers. You may create as many groups as you need to achieve your organizational goals, and all resources can belong to multiple groups.

## Creating A Group

Most users running a cluster of servers will want to create a group for their cluster. So the first step is to use the **New Group**{:.ui-keyword} button on the **Groups**{:.ui-keyword} page to create a group. You can name it whatever you feel is appropriate. If you like, you can also assign a color to help organize.

Once the group has been created, use the **Add Server**{:.ui-keyword} to select 1 or more servers to add to the group.

## Permissions

Permissions in Sentinel use a "common value" system. What this means is resources added to a group have a set of permissions that users in the group are *allowed* to share, but are not explicitly granted. The purpose of this system is to allow resource owners to retain control without allowing other members in the group do to things they don't want.

For example, when adding a server to this group, if the **Control Servers**{:.ui-keyword} permission is checked, this means the permission **can** be granted for this server to users in the group. Users do not automatically get this permission for the server. When we add a user to the group, a full list of permissions is shown. A user who **also** has **Control Servers**{:.ui-keyword} in the group will be granted the permission on the server.

{:.tip .titled}
> Remember
> 
> Both the server and the user must have a permission, or the permission is not granted.

The only exception to this logic is group-level permissions, such as **Manage Servers**{:.ui-keyword}. These work much like the permissions you're used to in other systems. If a user has a group-specific permission, they are granted that permission automatically.

This grid may help demonstrate the effects:

| Permission | Server | User | Effect |
| - | - | - | - |
| Control Servers | Yes | Yes | **Yes**: User can issue bans and admin commands to the server. |
| Edit Servers | No | Yes | **No**: The user can not edit server details. |
| Share Servers | Yes | No | **No**: The user can not add the server to other groups. |
{:.classdefinition}

## Group Chat

In the **Settings**{:.ui-keyword} tab of a group page, look in the **Server Settings**{:.ui-keyword} group for the **Chat Forwarding**{:.ui-keyword} setting. Turn this on and save the changes to enable group chat. Chat messages are automatically forwarded between all servers in the group.

Servers have a **Chat Name**{:.ui-keyword} setting in their **Settings**{:.ui-keyword} tab. This is a very short tag that will be added to forwarded messages so players know which server or map the message has come from.

### Web-To-Group Chat

The **Chat**{:.ui-keyword} tab shows all chat messages for the group. Messages sent from the web interface will be sent to all servers in the group. Chat Forwarding does not need to be enabled for this to work.

## Bans

Bans created in a group will apply to all servers in the group. Sentinel will push a `BanPlayer` command to each server, as well as update the server's `banlist.txt` if the server's `BanListURL` is pointing to Sentinel's version of the file.

## Scripts

Scripts added to a group affect all servers in the group. Users in the group will have access to any manual scripts in the group. If both the user and the script have the **Edit Scripts**{:.ui-keyword} permission, the user may make changes to the script.

## Buckets

Buckets do not need to be added to a group to be usable by a script, but adding them to a group can allow other users to see and edit their contents.
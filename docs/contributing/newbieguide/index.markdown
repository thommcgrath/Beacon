---
title: Newbie Guide
parent: Contributing

---
# {{page.title}}

For those who are not familiar with GitHub, I wanted to provide some basic information on how to get started.
 
## Definitions and Explainations

### What is GitHub?

For those unfamiliar, GitHub is a versioning and history system used to track changes made in projects. Many developers use GitHub to not only track their own projects, but to provide the details for others to see (making it open source).

### What is a repository?

Repositories on GitHub are essentially the containers in which a project is managed. As opposed to letting anyone edit the project directly, repositories are also used to manage what changes are actually used.

### What is a fork?

In the context of working with Beacon's documentation, you'll need a fork of the repository. A fork is essentially your own copy of the project for making changes.

### What is a commit?

A commit is a batch of changes intended to be pushed to your fork.

### What is a push?

A push is the the release of the commits to your fork.

### What is a pull request?

A pull request is a submission to the author of the main project the pushed changes you made. These are used to allow the author to review and approve the changes before they become an official part of parent repository.

## Getting Situated

### GitHub Account & GitHub Desktop Client
The first requirement for contributing to Beacon is creating a GitHub account.

To make life easier, you should also consider downloading the [GitHub Desktop](https://desktop.github.com/) client. After doing so, log into your GitHub account from within the client.

### Ruby
In conjunction with the client, you will want to add Jekyll (which is a tool used to publish the content in your repository locally for viewing on a web browser). Jekyll is not difficult to set up, but requires Ruby. Ruby is a programming language which is also not particularly difficult to set up.

First, visit [https://rubyinstaller.org/](https://rubyinstaller.org/) to download the Ruby installer. When running the installer, a command prompt like interface will eventually open asking what parts of Ruby you would like to install.

Jekyll requires the third choice, **'MSYS2 and MINGW development tool chain'**{:.ui-keyword}, press 3 then enter.

### Beacon Fork

With Ruby installed, you will need to make a fork of the Beacon repository. Visit [https://github.com/thommcgrath/Beacon](https://github.com/thommcgrath/Beacon) and locate the button labeled Fork to the right of the Beacon header.

Press the pulldown on the Fork button and choose the **Create a new fork**{:.ui-keyword} option.

### Putting it Together

Open the GitHub Desktop client. On the right hand side of the **Let's Get Started** screen, you should find the fork you created. Click the fork and choose the option to **clone the repository**.

Once activated, a popup will appear to ask where to install the cloned repository. Install it wherever you like.

Once the repository finished cloning, another popup asking what you are planning to do with the fork will appear. Choose **contribute to the parent project**.

### Jekyll Installation

With the repository cloned in the desktop client, installing Jekyll is quite simple. 

Within GitHub Desktop, click on the "Repository" pulldown menu and choose "Open in Command Prompt".

Type 'CD Docs' to navigate to the Docs folder then type 'bundle install'.

Ruby will download and configure Jekyll and it's requirements on it's own from there.

Once completed, type 'bundle exec jekyll serve' and Jekyll will set up the local version of the GitHub Page. 

Check the output for a line labeled **Server address:** to find the hyperlink to view the local version. In my case, the address was http://127.0.0.1:4000//. From the command prompt, you can hold the Control button (on Windows) while clicking the address to open it in your default web browser.

## Editing Content
 
### Overview
 In terms of "preferred editing tactics", refer to the Contribution guide for best practices on forging the content. 
 
 To make actual changes, you will need to use a text or markdown editor. [Notepad++](https://notepad-plus-plus.org/) is a good application for this, but is not the only option.
 
 Using the GitHub Desktop client, find the button to "view files in explorer". Navigate to the content you want to modify, locate the index.markdown file and open it. Apply the changes you want and press Save.
 
### Tips & Tricks
 
 Something that threw me off was with the provided examples on the Contribution guide. You'll notice that they are surrounded by { %raw% }{ %endraw% }. These should be omitted from content you are adding, they are used to prevent the sample code from being formatted, hiding the example code from view.
 
 A good way of getting situated is to open other pre-existing topics. This can help give a feel for how the formatting works.
 
 If making a new topic, create an appropriately named folder. Copying an existing index.markdown file can act as a nice template to get started.
 
 **Do not** include spaces in file names or folder paths. They will not work correctly.
 


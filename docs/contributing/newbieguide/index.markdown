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
 
 The content from the help section is currently being pulled into the **Staging**{:.ui-keyword} branch on the Beacon GitHub. You are able to change the active branch on the GitHub Desktop client, which will re-build the folder and file structure to match.
 
 While reading the Contribution guide, be aware of the formatting examples shown. Some of the content is surrounded by { %raw% }{ %endraw% }, but this should be omitted from your own content. Their function is to force content in between them to render as text instead of executed code.
 
 Infact, a good way of getting accustomed to formatting techinique is to open the index.markdown file in other pre-existing topics. Seeing how other pages are set up can act as an example towards formatting new content.
 
 While creating a new topic, it may be helpful to copy one of these pre-made index.markdown files to use as a formatting template.
 
 **Do not** include spaces in file names or folder paths. They will not work correctly.
 
 Use the local GitHub Page Jekyll created to preview how the content will actually come out when live. Something that I have found helpful is to leave the index.markdown file open when commiting the changes. If you are not happy with the result, you can right click the most recent commit on GitHub Desktop's History tab to easily **revert changes from commit**{:.ui-keyword}. Just make sure to re-save the markdown file or other changes made may be lost.
 
 ### Submission of Content
When satisfied with the series of changes made, you will need to merge your fork of the **Staging**{:.ui-keyword} branch into your **Master**{:.ui-keyword} branch. 

This can be done by with the following steps:

Click the **Current Branch**{:.ui-keyword} pulldown menu and select **Master**{:.ui-keyword}.

Click the same current branch pulldown menu a second time and choose **Choose a branch to merge into Master**{:.ui-keyword}.

Navigate to the main GitHub Desktop screen and press the **Push Origin** button.

Navigate to Beacon's Github page and locate **Pull Request**{:.ui-keyword} button.

From there, press the **New Pull Request**{:.ui-keyword} button, and click on the **compare across forks** link, which will modify the menu a bit.

With the expanded menu, ensure the **Base Repository**{:.ui-keyword} is Beacon's and choose the Base Branch to be **Staging**{:.ui-keyword}.

For the **Head Repository**{:.ui-keyword}, change to the **Master**{:.ui-keyword} branch of your own repository.

Once everything is set, press the **Create Pull Request** button{:.ui-keyword}.

More details can be found [here](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests).
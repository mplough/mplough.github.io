---
layout: post
title:  "Browsing Jira tickets with Quicksilver"
---

![Quicksilver Jira search](/assets/Quicksilver Jira search.png)

Sean Walberg wrote [a post on how to set up Jira browsing with
Quicksilver](https://ertw.com/blog/2012/11/16/jira-shortcuts-with-quicksilver/)
back in 2012 but the images don't load anymore, making it hard to follow.

[Quicksilver](https://qsapp.com/) is an extensible application launcher that
runs on macOS.  These steps show how to set up a "jira" shortcut to load a
particular issue in Jira.  If you need to use multiple Jira sites, it's easy to
modify these instructions to create multiple shortcuts: "x-jira", "y-jira", and
"z-jira", for example.

1. Install the Web Search Plugin from the plugins tab in
   Quicksilver's configuration.
   ![Quicksilver Web Search Plugin](/assets/Quicksilver Web Search Plugin.png)
1. Quit and relaunch Quicksilver (version 1.6.1 (4026) doesn't remind you to do this).
   The catalog item type needed in the next step won't show up without a
   relaunch.
1. From the Catalog, create a custom Web Search list catalog item.  Create a
   new source, call it "jira", and set the URL to
   `https://[company-site].atlassian.net/browse/***`, substituting your Jira
   installation's subdomain for `[company-site]`.  Of course, you can also do
   this for on-prem Jira installations -- the URL format is
   `https://[site]/browse/***`.  Quicksilver will replace the three stars with
   your search term, which will be a Jira ticket ID such as `ISSUE-299`.
   ![Quicksilver Web Search List catalog item](/assets/Quicksilver Web Search List catalog item.png)
1. Click the circle arrow at the bottom of the screen to rescan the new source.

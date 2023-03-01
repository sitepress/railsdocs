---
title: About
layout: article
---

Greetings,

One morning I [tweeted about how Rails could be better for Jr developers](https://twitter.com/bradgessler/status/1630655606339289093). I hit on a lot of points, but the one I'm focusing on with this website is all the stuff that I think is missing from the [official Rails documentation](https://guides.rubyonrails.org).

## Editing docs needs to be much easier

This project, [available on Github](https://github.com/sitepress/railsdocs), uses the Rails docs from the [core Rails repo](https://github.com/rails/rails/tree/main/guides) and puts them into a separate Rails application that's [running Sitepress](https://sitepress.cc). This means anybody can clone `https://github.com/sitepress/railsdocs`, run `bundle && bin/rails server` and have a familiar Rails app they can use to modify the docs website.

For people who don't want to run Rails, maybe because they don't have time or need to make a quick edit, they can click ["Edit" link](https://github.com/sitepress/railsdocs/edit/main/app/content/pages/about.html.md) on any page and get taken to the Github editor where changes can be proposed and a PR opened. When the PR is merged, the documents will automatically update.

## Localize Rails Docs with Rails built-in localization features

Localized Rails docs are all managed in completely different repos because the docs themselves are not managed in Rails, thus they can't utilize Rails internationalization features for localized docs.

This project is a plain ol' Rails app, meaning localized content could be housed in one repo and managed under one Rails application.

## Make content more "bite-sized" and sharable

The current Rails guides use anchor tags to link to content deep within a page. Anchor tags are difficult to share for a whole host of reasons on large docs. This project would break apart the gigantic pages into many smaller pages that can flow seamlessly together via Hotwire.

## Get people excited about great documentation

Ideally this project gets people excited about Rails documentation! Not just writing and maintaining great documentation, but building features into the docs Rails app that makes it easy to search for content, view it in different formats, share it with others, more accessible designs, and more.

## The future of Rails docs

With the right curation, lowering the friction required for more people to contribute to Rails docs will only improve the quality and accuracy of the Rails documentation.

Cheers,

[Brad Gessler](https://bradgessler.com/)
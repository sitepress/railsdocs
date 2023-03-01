# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"
require "pathname"

Rails.application.load_tasks

def find_and_replace(match, with:, path:)
  puts "find_and_replace #{match} with #{with} in #{path}"
  # Read the contents of the file into a variable
  File.write path, File.read(path).gsub(match, with)
end

task :import do
  YAML.load_file("app/content/source/documents.yaml").each do |section|
    section_name = section["name"]
    section_dir_name = section_name.downcase.gsub(" ", "_")
    section_index_path = "app/content/pages/#{section_dir_name}/index.html.md"

    File.write section_index_path, """---
title: #{section_name}
layout: section
---

""" unless File.exist? section_index_path

    section["documents"].each do |doc|
      basename = File.basename doc["url"], ".html"
      source = File.join "app/content/source/#{basename}.md"
      target = File.join "app/content/pages/#{section_dir_name}/#{basename}.html.md"

      cp source, target

      asset = Sitepress::Asset.new(path: target)
      asset.data = {
        "title" => doc["name"],
        "description" => doc["description"],
        "redirect_from" => File.join("/", doc["url"])
      }
      asset.save

      # Get rid of this error ... it shouldn't be needed if content is managed well
      find_and_replace "**DO NOT READ THIS FILE ON GITHUB, GUIDES ARE PUBLISHED ON https://guides.rubyonrails.org.**", with: "<!-- Read guides at https://guides.rubyonrails.org -->", path: target

      # We don't need to preface assets with `images/` since Markdown
      # can tap into the Rails asset pipeline for us.
      find_and_replace "](images/", with: "](", path: target
    end
  end
end

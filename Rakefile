# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"
require "pathname"

Rails.application.load_tasks

class DocumentImporter
  def initialize(root_path:)
    @root_path = Pathname.new(root_path)
    @yaml ||= YAML.load_file @root_path.join("documents.yaml")
  end

  def documents
    Enumerator.new do |y|
      @yaml.each do |section|
        section["documents"].each do |document|
          path = @root_path.join("#{File.basename(document["url"], ".html")}.md")
          y << document.merge("section" => section["name"], "path" => path)
        end
      end
    end
  end
end

def find_and_replace(match, with:, path:)
  puts "find_and_replace #{match} with #{with} in #{path}"
  # Read the contents of the file into a variable
  File.write path, File.read(path).gsub(match, with)
end

namespace :guides do
  desc "Import Rails docs"
  task :import do
    importer = DocumentImporter.new(root_path: "app/content/source")
    importer.documents.each do |doc|
      source = doc["path"]
      target = "app/content/pages/#{source.basename(".md")}.html.md"
      cp source, target

      asset = Sitepress::Asset.new(path: target)
      asset.data = {
        "title" => doc["name"],
        "description" => doc["description"],
        "section" => doc["section"]
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

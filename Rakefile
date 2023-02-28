# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

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

desc "Import Rails docs"
task :import do
  DocumentImporter.new(root_path: "app/content/source").documents.each do |document|
    # pp document
    source = document["path"]
    target = "app/content/pages/#{document["path"].basename(".md")}.html.md"
    cp source, target
  end
end
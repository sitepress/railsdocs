class PagesController < Sitepress::SiteController
  def private

  attr_reader :current_page_rendition

  # This is to be used by end users if they need to do any post-processing on the rendering page.
  # For example, the user may use Nokogiri to parse static HTML pages and hook it into the asset pipeline.
  # They may also use tools like `HTMLPipeline` to process links from a markdown renderer.
  def process_rendition(rendition)
    @current_page_rendition = rendition
  end
end

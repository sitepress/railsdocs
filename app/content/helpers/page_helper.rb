module PageHelper
  # Creates a hyperlink to a page using the `title` key. Change the default in the args
  # below if you use a different key for page titles.
  def link_to_page(page, title_key: "title")
    link_to page.data.fetch(title_key, page.request_path), page.request_path
  end

  # Quick and easy way to change the class of a page if its current. Useful for
  # navigation menus.
  def link_to_if_current(text, page, active_class: "active")
    if page == current_page
      link_to text, page.request_path, class: active_class
    else
      link_to text, page.request_path
    end
  end

  # Conditionally renders the block if an arg is present. If all the args are nil,
  # the block is not rendered. Handy for laconic templating languages like slim, haml, etc.
  def with(*args, &block)
    block.call(*args) unless args.all?(&:nil?)
  end

  # Render a block within a layout. This is a useful, and prefered way, to handle
  # nesting layouts, within Sitepress.
  def render_layout(layout, **kwargs, &block)
    render html: capture(&block), layout: "layouts/#{layout}", **kwargs
  end

  def order(pages)
    pages.sort_by { |page| page.data.fetch("order", Float::INFINITY) }
  end

  def github_url(page)
    page.asset.path
  end

  def docs_edit_url(page=current_page, branch: "main")
    "https://github.com/sitepress/railsdocs/edit/#{branch}/#{page.asset.path.relative_path_from(Rails.root)}"
  end

  def docs_history_url(page=current_page, branch: "main")
    "https://github.com/sitepress/railsdocs/commits/#{branch}/#{page.asset.path.relative_path_from(Rails.root)}"
  end

  def remove_h1(&block)
    dom = Nokogiri::HTML5.fragment(capture(&block))
    dom.css("h1").remove
    dom.to_html.html_safe
  end

  class TableOfContents
    class Entry < Data.define(:text, :level, :children, :url)
      def initialize(children: [], **kwargs)
        super children: children, **kwargs
      end
    end

    def initialize(html)
      @html = html
    end

    def headers
      # Load the HTML document
      doc = Nokogiri::HTML5.fragment(@html)

      # Initialize an empty table of contents array
      toc = []

      # Select all h1..h6 tags in the document
      doc.css("h1[id], h2[id], h3[id], h4[id], h5[id], h6[id]").each do |header|
        # Get the text content and level of the header tag
        header_text = header.text.strip
        header_level = header.name[1].to_i
        header_url = "##{header.attr("id")}"

        # Add the header to the table of contents array
        toc << Entry.new(text: header_text, level: header_level, url: header_url)

        # Find the nearest parent header tag with a lower level
        parent = toc.slice(0..-2).reverse.find { |h| h.level < header_level }

        # Add the current header as a child of its parent, if it exists
        parent.children << toc.last if parent
      end

      toc
    end

    def tree
      headers.select { |h| h.level == 2 }
    end
  end

  def toc(page)
    TableOfContents.new(page_rendition(page).output).tree
  end
end

# You should read the docs at https://github.com/vmg/redcarpet and probably
# delete a bunch of stuff below if you don't need it.

class ApplicationMarkdown < MarkdownRails::Renderer::Rails
  # Reformats your boring punctation like " and " into “ and ” so you can look
  # and feel smarter. Read the docs at https://github.com/vmg/redcarpet#also-now-our-pants-are-much-smarter
  include Redcarpet::Render::SmartyPants

  # Uncomment and run `bundle add rouge` for syntax highlighting
  include MarkdownRails::Helper::Rouge

  # If you need access to ActionController::Base.helpers, you can delegate by uncommenting
  # and adding to the list below. Several are already included for you in the `MarkdownRails::Renderer::Rails`,
  # but you can add more here.
  #
  # To see a list of methods available run `bin/rails runner "puts ActionController::Base.helpers.public_methods.sort"`
  #
  # delegate \
  #   :request,
  #   :cache,
  #   :turbo_frame_tag,
  # to: :helpers

  # These flags control features in the Redcarpet renderer, which you can read
  # about at https://github.com/vmg/redcarpet#and-its-like-really-simple-to-use
  # Make sure you know what you're doing if you're using this to render user inputs.
  def enable
    [:fenced_code_blocks, :tables]
  end

  def header(text, header_level)
    header_id = text.downcase.gsub(/[^\w\d\s]/, "").gsub(" ", "-")
    content_tag "h#{header_level}", id: header_id do
      helpers.link_to text.html_safe, "##{header_id}"
    end
  end

end

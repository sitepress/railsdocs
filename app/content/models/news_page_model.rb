require "uri"
require "feedjira"
require "http"

class NewsPageModel < PageModel
  collection glob: "news/{[!index]*.html.*}"

  def rss_payload
    Rails.cache.fetch("#{request_path}/rss_payload", expires_in: 1.hour) do
      HTTP.follow.get(rss_url).body.to_s
    end
  end

  def rss
    @rss ||= Feedjira.parse rss_payload
  end

  def rss_url
    URI(data.fetch("rss_url"))
  end

  def self.rss_items
    Enumerator.new do |y|
      all.each do |page|
        page.rss.entries.each do |item|
          y << [ item, page ]
        end
      end
    end
  end
end

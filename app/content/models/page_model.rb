class PageModel < Sitepress::Model
  collection glob: "**/*.html*"
  data :title, :section, :description

  def self.section(name)
    all.select { |page| name == page.section }
  end
end

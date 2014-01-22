require 'open-uri'

class InfoCrawler
  attr_reader :page

  def self.fetch(url, *tags)
    page = Nokogiri::HTML(open(url))
    new(page).fetch(*tags)
  end

  def initialize(page)
    @page = page
  end

  def fetch(*tags)
    tags = default_tags if tags.blank?
    tags.each_with_object({}) do |tag, result|
      result[tag] = scan_for(tag)
    end
  end

  private

  def default_tags
    [:h1, :h2, :h3]
  end

  def scan_for(tag)
    page.css(tag.to_s).map do |node|
      node.text
    end.map(&:presence).compact.join(", ")
  end
end

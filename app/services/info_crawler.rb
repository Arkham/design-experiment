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
    tags.each_with_object({}) do |tag, result|
      result[tag] = scan_for(tag)
    end
  end

  private

  def scan_for(tag)
    page.css(tag.to_s).map do |node|
      node.text
    end.join(", ")
  end
end

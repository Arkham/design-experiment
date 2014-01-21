class InfoCrawler
  attr_reader :page

  def self.fetch(url)
    page = Nokogiri::HTML(open(url))
    new(page).fetch
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
      node.content
    end
  end
end

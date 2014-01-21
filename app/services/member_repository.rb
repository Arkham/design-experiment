class MemberRepository
  class << self
    def create(member)
      new.delay.create(member)
    end
  end

  def create(member)
    if member.website.present?
      update_website_info(member) 
      shorten_website(member)
    end
  end

  def update_website_info(member)
    member.update_attributes InfoCrawler.fetch(member.website)
  end

  def shorten_website(member)
    member.update_attributes(short_website: UrlShortener.shorten(member.website))
  end
end

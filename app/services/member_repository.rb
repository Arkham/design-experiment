class MemberRepository
  class << self
    def create(member)
      new.delay.create(member)
    end
  end

  def create(member)
    update_website_info(member) if member.website.present?
  end

  def update_website_info(member)
    member.update_attributes InfoCrawler.fetch(member.website)
  end
end

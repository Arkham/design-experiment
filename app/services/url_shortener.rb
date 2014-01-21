class UrlShortener
  def self.shorten(url)
    new.shorten(url)
  end

  def shorten(url)
    client.shorten(url)
  end

  def client
    @client ||= BitlyWrapper.new
  end

  class BitlyWrapper
    def client
      Bitly.client
    end

    def shorten(url)
      client.shorten(url).short_url
    rescue BitlyError
      ""
    end
  end
end

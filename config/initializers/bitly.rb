Bitly.configure do |config|
  config.api_version = 3
  config.login = ENV["BITLY_USER"]
  config.api_key = ENV["BITLY_API_KEY"]
end

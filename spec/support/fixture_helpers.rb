module FixtureHelpers
  def fixture_path_for(filename)
    File.join(File.dirname(__FILE__), '..', 'fixtures', filename)
  end
end

RSpec.configure do |config|
  config.include FixtureHelpers
end

FactoryGirl.define do
  factory :member do
    sequence(:name) {|n| "John Doe #{n}" }
    website "http://www.google.com"
  end
end

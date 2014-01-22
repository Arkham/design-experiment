FactoryGirl.define do
  factory :member do
    sequence(:name) {|n| "John Doe #{n}" }
    website "http://www.google.com"
    h1 ""
    h2 ""
    h3 ""
  end
end

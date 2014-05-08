FactoryGirl.define do  
  
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :chamber do
    sequence(:name) { |n| "Chamber #{n}" }
    description "Chamber Description"
  end

  factory :debate do
    sequence(:title) { |n| "Lorem ipsum #{n}" }
    content "Lorem ipsum"
    affirmative "Affirmative"
    negative "Negative"
    user
    chamber
  end

  factory :original_post do
    content "Lorem ipsum"
    user
    debate
    type "OriginalPost"
    position "affirmative"
  end
  
  
end
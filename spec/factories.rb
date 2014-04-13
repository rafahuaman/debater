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
    title "Lorem ipsum"
    content "Lorem ipsum"
    affirmative "Affirmative"
    negative "Negative"
    user
    chamber
  end
  
  
end
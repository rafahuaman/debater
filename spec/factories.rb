FactoryGirl.define do  
  
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :chamber do
    sequence(:name) { |n| "Chamber #{n}" }
    description "Chamber Description"
    user
  end

  factory :debate do
    sequence(:title) { |n| "Lorem ipsum #{n}" }
    content "Lorem ipsum"
    affirmative "Affirmative"
    negative "Negative"
    user
    chamber
  end

  factory :argument_post, class: ArgumentPost do
    content "Lorem ipsum"
    user
    debate
    position "affirmative"
  end

  factory :original_post, class: OriginalPost, parent: :argument_post do
    type "OriginalPost"
  end  

  factory :correction_post, class: CorrectionPost, parent: :argument_post do
    type "CorrectionPost"
  end  
  
  
end
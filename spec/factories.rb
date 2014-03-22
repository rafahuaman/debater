FactoryGirl.define do
  factory :user do
    name     "Dave"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :debate do
    title "Lorem ipsum"
    content "Lorem ipsum"
    affirmative "Affirmative"
    negative "Negative"
    user
  end
end
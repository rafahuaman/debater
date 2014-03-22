FactoryGirl.define do
  factory :user do
    name     "Dave"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :debate do
    title "Lorem ipsum"
    content "Lorem ipsum"
    affirmative "Lorem ipsum"
    negative "Lorem ipsum"
    user
  end
end
FactoryGirl.define do
  factory :user do
    name     "Dave"
    password "foobar"
    password_confirmation "foobar"
  end
end
# This will guess the User class
FactoryGirl.define do
  factory :user do
    sequence(:email) {|sn| "some-mail-#{sn}@gmail.com" }
    password  'Password1234'
    password_confirmation  'Password1234'
    remember_me false
  end
  
  factory :note do
    title "Some title"
    description "Some description"
    planned_time (Date.today - Random.rand(1000).days ).to_time + Random.rand(24).to_i.hours
    
    user
  end
end
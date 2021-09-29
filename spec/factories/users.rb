require 'faker'

FactoryBot.define do
  factory :program do
    configuration { { auto_resolve: false, auto_define: true } }
  end
  factory :user, aliases: %i[receiver] do
    email { Faker::Internet.email }
    first_name { Faker::Name.unique.name }
    last_name { Faker::Name.unique.name }
    password { 'Password1' }
    username { Faker::Name.unique.name }
    avatar { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/images/bubbles.jpg')), 'image/jpeg') }
  end
end

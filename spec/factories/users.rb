FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname { Faker::Name.initials(number: 2) }
    email { Faker::Internet.email }
    password {  "g9" + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    name_last { person.last.kanji }
    name_first { person.first.kanji } 
    katakana_last { person.last.katakana }
    katakana_first { person.first.katakana }
    birthday { Faker::Date.backward }
  end
end
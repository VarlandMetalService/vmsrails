FactoryBot.define do
  factory :user do
    username          { "richard" }
    employee_number   { "836" }
    first_name        { "Richard" }
    last_name         { "Legacy" }
    initials          { "RL" }
    nickname          { "Richard" }
    email             { "richard.legacy@varland.com" }
    avatar_bg_color   { "#F1FFFF" }
    avatar_text_color { "#010000" }
    phone_number      { "1231231234" }
  end
end
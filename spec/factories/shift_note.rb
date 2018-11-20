FactoryBot.define do
  factory :shift_note do 
    shift_time { 1              }
    dept       { 1              }  
    shift_type { 'IT'           }
    message    { 'Lorem Ipsum.' } 
    user
  end
end
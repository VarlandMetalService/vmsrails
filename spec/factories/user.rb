FactoryBot.define do
  factory :user do |u|
    _callback_canceller { true                       }
    u.employee_number   { 1234                       }
    u.username          { 'coffin'                   }
    u.first_name        { 'Peter'                    }
    u.middle_initial    { 'D'                        }
    u.last_name         { 'Coffin'                   }
    u.suffix            { 'I'                        }
    u.nickname          { 'Coffin'                   }
    u.initials          { 'PC'                       }
    u.email             { 'peter.coffin@varland.com' }
    u.avatar_bg_color   { '#000000'                  }
    u.avatar_text_color { '#ffffff'                  }
    u.is_admin          { true                       }
    u.is_disabled       { false                      }
    u.remember_digest   { nil                        }
    u.address           { '274 Senator'              }
    u.city              { 'Cincinnati'               }
    u.state             { 'OH'                       }
    u.zip_code          { '45220'                    }
    u.phone_number      { '1112223334'               }
    u.pin               { '1234'                     }
    u.is_clockedin      { true                       }
  end
end
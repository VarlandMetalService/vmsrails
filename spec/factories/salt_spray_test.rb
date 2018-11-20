FactoryBot.define do
  factory :salt_spray_test do
    so_num       { 1234      }
    load_num     { 1         }
    process_code { 'HN'      }
    process      { []        }
    load_weight  { 123       }
    customer     { 'DENSO'   }
    dept         { '3'       }
    part_tag     { 'wrt54gs' }
    sub_tag      { ''        }
    part_area    { 1         }
    part_density { 2         }
    white_spec   { 24        }
    red_spec     { 48        }
    is_sample    { false     }
    sample_code  { ''        }
    user
  end
end
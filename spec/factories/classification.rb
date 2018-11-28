FactoryBot.define do
  factory :classification do
    specification
    name {                  "Lorem ipsum." }
    description {           "Lorem ipsum." }
    vms_process_code {               "HLN" }
    color {                       "Orange" }
    minimum_alloy_percentage {         0.5 }
    maximum_alloy_percentage {         1.5 }
    minimum_thickness {                0.5 }
    maximum_thickness {                1.5 }
    thickness_unit {        "This is dumb" }
    salt_spray_white_spec {             24 }
    salt_spray_red_spec {               72 }
    bake_setpoint {                    123 }
    bake_variation_limit {             123 }
    bake_temperature_unit { "This is dumb" }
    bake_soak_length {                 123 }
    bake_within_limit {                123 }
    bake_requires_inert_atmosphere { false }
    notes {                 "Lorem ipsum." }
    not_capable {                    false }
  end
end
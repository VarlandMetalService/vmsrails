json.extract! specification, :id, :organization, :name, :description, :revision, :notes, :created_at, :updated_at
json.url specification_url(specification, format: :json)
json.classifications specification.classifications do |classification|
  json.extract! classification, :id,
                                :name,
                                :description,
                                :vms_process_code,
                                :color,
                                :minimum_alloy_percentage,
                                :maximum_alloy_percentage,
                                :minimum_thickness,
                                :maximum_thickness,
                                :thickness_unit,
                                :salt_spray_white_spec,
                                :salt_spray_red_spec,
                                :bake_setpoint,
                                :bake_variation_limit,
                                :bake_temperature_unit,
                                :bake_soak_length,
                                :bake_within_limit,
                                :bake_requires_inert_atmosphere,
                                :notes,
                                :not_capable,                                
                                :created_at,
                                :updated_at
end
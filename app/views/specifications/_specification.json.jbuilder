json.extract! specification, :id, :organization, :name, :description, :revision, :notes, :created_at, :updated_at
json.url specification_url(specification, format: :json)
json.classifications specification.classifications do |classification|
  json.extract! classification, :id, :name, :description, :vms_process_code, :color, :minimum_alloy_percentage, :maximum_alloy_percentage, :minimum_thickness, :maximum_thickness, :thickness_unit, :created_at, :updated_at
end
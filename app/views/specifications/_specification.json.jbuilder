json.extract! specification, :id, :organization, :name, :description, :revision, :notes, :created_at, :updated_at
json.url specification_url(specification, format: :json)
json.array! specification.classifications, partial: "classifications/classification", as: :classification
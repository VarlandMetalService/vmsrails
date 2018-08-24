json.extract! clock_edit, :id, :clock_record_id, :user_id, :ip_address, :reason_id, :deleted_at, :note, :created_at, :updated_at
json.url clock_edit_url(clock_edit, format: :json)

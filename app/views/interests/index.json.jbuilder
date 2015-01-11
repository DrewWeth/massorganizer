json.array!(@interests) do |interest|
  json.extract! interest, :id, :name, :organization_id, :desc, :main_email
  json.url interest_url(interest, format: :json)
end

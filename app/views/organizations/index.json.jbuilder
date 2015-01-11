json.array!(@organizations) do |organization|
  json.extract! organization, :id, :name, :desc, :phone_number, :owner_id
  json.url organization_url(organization, format: :json)
end

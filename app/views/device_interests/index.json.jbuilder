json.array!(@device_interests) do |device_interest|
  json.extract! device_interest, :id, :device_id, :interest_id
  json.url device_interest_url(device_interest, format: :json)
end

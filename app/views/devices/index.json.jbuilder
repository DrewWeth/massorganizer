json.array!(@devices) do |device|
  json.extract! device, :id, :tele, :pawprint
  json.url device_url(device, format: :json)
end

json.array!(@device_submissions) do |device_submission|
  json.extract! device_submission, :id, :device_id, :message
  json.url device_submission_url(device_submission, format: :json)
end

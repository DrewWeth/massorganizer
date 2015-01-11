class DeviceSubmission < ActiveRecord::Base
  validates :device_id, :presence => true
end

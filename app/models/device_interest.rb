class DeviceInterest < ActiveRecord::Base

  validates :device_id, :presence => true
  validates :interest_id, :presence => true

  belongs_to :interest
  belongs_to :device

end

class DeviceInterest < ActiveRecord::Base

  validates :device_id, :presence => true
  validates :interest_id, :presence => true

  validates_uniqueness_of :device_id, :scope => :interest_id


  belongs_to :interest
  belongs_to :device

end

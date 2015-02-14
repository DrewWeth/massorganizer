# == Schema Information
#
# Table name: device_interests
#
#  id              :integer          not null, primary key
#  device_id       :integer
#  interest_id     :integer
#  created_at      :datetime
#  updated_at      :datetime
#  organization_id :integer
#

class DeviceInterest < ActiveRecord::Base

  validates :device_id, :presence => true
  validates :interest_id, :presence => true


  validates_uniqueness_of :device_id, :scope => :interest_id


  belongs_to :interest
  belongs_to :device

end

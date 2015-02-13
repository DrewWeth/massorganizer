# == Schema Information
#
# Table name: device_submissions
#
#  id         :integer          not null, primary key
#  device_id  :integer
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#

class DeviceSubmission < ActiveRecord::Base
  validates :device_id, :presence => true
end

# == Schema Information
#
# Table name: device_logs
#
#  id         :integer          not null, primary key
#  device_id  :integer
#  message    :text
#  to         :string(255)
#  from       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class DeviceLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

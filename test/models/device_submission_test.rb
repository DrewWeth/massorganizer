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

require 'test_helper'

class DeviceSubmissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

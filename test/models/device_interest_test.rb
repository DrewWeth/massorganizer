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

require 'test_helper'

class DeviceInterestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

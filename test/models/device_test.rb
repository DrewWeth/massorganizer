# == Schema Information
#
# Table name: devices
#
#  id          :integer          not null, primary key
#  tele        :string(255)
#  name        :string(255)
#  pawprint    :string(255)
#  email       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  current_org :integer
#

require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

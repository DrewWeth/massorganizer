# == Schema Information
#
# Table name: device_memberships
#
#  id              :integer          not null, primary key
#  device_id       :integer
#  organization_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

require 'test_helper'

class DeviceMembershipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

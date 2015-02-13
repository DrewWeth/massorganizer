# == Schema Information
#
# Table name: organizations
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  desc           :text
#  phone_number   :string(255)
#  owner_id       :integer
#  created_at     :datetime
#  updated_at     :datetime
#  org_key        :string(255)
#  public         :boolean          default(FALSE)
#  interest_count :integer          default(0), not null
#

require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: interests
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  organization_id :integer
#  desc            :text
#  main_email      :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  rel_interest_id :integer
#

require 'test_helper'

class InterestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

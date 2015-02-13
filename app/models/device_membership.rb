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

class DeviceMembership < ActiveRecord::Base

  validates :device_id, :presence=>true
  validates :organization_id, :presence=>true

  validates_uniqueness_of :device_id, :scope => :organization_id


  belongs_to :organization
  belongs_to :device

end

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

class Interest < ActiveRecord::Base
  resourcify
  include Authority::Abilities
  
  belongs_to :organization

  has_many :device_interests, dependent: :destroy
  has_many :devices, :through => :device_interests

  validates :name, :presence => true
  validates :organization_id, :presence => true

end

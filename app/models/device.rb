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

class Device < ActiveRecord::Base

  resourcify
  include Authority::Abilities

  has_many :device_interests, dependent: :destroy
  has_many :interests, :through => :device_interests

  has_many :device_memberships, dependent: :destroy
  has_many :organizations, :through => :device_memberships

  validates_uniqueness_of :tele

  has_many :device_logs, dependent: :destroy

  validates :tele, :presence => true




end

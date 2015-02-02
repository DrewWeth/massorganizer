class Device < ActiveRecord::Base

  has_many :device_interests
  has_many :interests, :through => :device_interests

  validates :tele, :presence => true
end

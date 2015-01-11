class Interest < ActiveRecord::Base
  belongs_to :organization

  has_many :device_interests
  has_many :devices, :through => :device_interests

  validates :name, :presence => true
  validates :organization_id, :presence => true

end

class Organization < ActiveRecord::Base

  belongs_to :user
  has_many :interests

  validates :name,  :presence => true
  validates :owner_id, :presence => true


end

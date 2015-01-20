class Organization < ActiveRecord::Base

  belongs_to :user, :foreign_key => 'owner_id'
  has_many :interests

  validates :name,  :presence => true
  validates :owner_id, :presence => true


end

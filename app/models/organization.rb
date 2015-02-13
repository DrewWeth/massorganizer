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

class Organization < ActiveRecord::Base

  resourcify
  include Authority::Abilities

  belongs_to :user, :foreign_key => 'owner_id'
  has_many :interests, dependent: :destroy

  validates :name,  :presence => true
  validates :owner_id, :presence => true

  after_save :generate_key

  def generate_key
    if self.org_key == nil
      self.org_key = self.id.to_s + "-" + (0...4).map { (65 + rand(26)).chr }.join
      self.save
    end
  end

end

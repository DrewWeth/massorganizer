# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :integer          default(0)
#

class User < ActiveRecord::Base
  rolify
  include Authority::UserAbilities

  has_many :organizations, :foreign_key => 'owner_id'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def can_see?(resource)
    self.has_role? :moderator, resource or self.has_role? :admin
  end

  def has_power?
    if self.roles > 0
      return true
    else
      return false
    end
  end

  def set_mod(resource)
    self.has_role :moderator, resource
  end

  def set_admin(resource)
    self.has_role :admin
  end

end

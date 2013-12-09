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
#  username               :string(255)
#  avatar                 :string(255)
#  realname               :string(255)
#

class User < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader

	has_and_belongs_to_many :roles
	has_many :stat_entries
  has_many :decks

	validates :username, presence: true
	validates :username, uniqueness: true, if: -> { self.username.present? }

	after_create :default_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	def role?(role)
		!!self.roles.find_by_name(role.to_s)
	end

	private
	def default_role
		if self.role_ids.empty?
			self.role_ids = [1] #default role is user
		end
	end
end

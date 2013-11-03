class User < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader

	has_and_belongs_to_many :roles
	has_many :stat_entries

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

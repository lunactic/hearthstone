class User < ActiveRecord::Base
	has_and_belongs_to_many :roles

	validates_presence_of :username
	validates_uniqueness_of :username

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

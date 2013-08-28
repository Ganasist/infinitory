class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :lab

  before_validation :admin_cascade

  protected
  	def admin_cascade
  		if self.super_admin?
  			self.group_leader = true
  			self.admin 				= true
  		elsif self.group_leader?
  			self.admin = true
  		end
  	end
end

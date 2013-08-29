class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable

  belongs_to :lab

  before_validation :admin_cascade

  protected

  	def admin_cascade
  		if self.super_admin?
        self.admin        = true
  		elsif self.group_leader?
  			self.admin 				= true
  		end
  	end
end

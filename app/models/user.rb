class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  belongs_to :lab
  validates_associated :lab

  # validates_presence_of :lab, message: "Your group leader must create an account first"

  ROLES = %w[group_leader lab_manager lab_member]

  def role_symbols
	  [role.to_sym]
	end
end

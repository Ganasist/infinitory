require 'role_model'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockaboe, and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  belongs_to :lab

  validates_presence_of :lab, message: "Your group leader must create an account first"

  include RoleModel
  # optionally set the integer attribute to store the roles in,
  # :roles_mask is the default
  roles_attribute :roles_mask
 
  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :guest, :lab_member, :lab_manager, :superadmin

  def lab
    lab.try(:email)
  end
  
  def lab=(email)
    self.lab = Lab.find_or_create_by(email) if email.present?
  end


  protected
    ROLES = %w[lab_manager lab_member]
    def role?(base_role)
      ROLES.index(base_role.to_s) <= ROLES.index(role)
    end
end

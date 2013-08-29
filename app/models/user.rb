require 'role_model'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable

  belongs_to :lab

  before_validation :admin_cascade


  include RoleModel
  # optionally set the integer attribute to store the roles in,
  # :roles_mask is the default
  roles_attribute :roles_mask
 
  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :guest, :lab_member, :lab_manager, :group_leader, :superadmin


  protected
    ROLES = %w[group_leader lab_manager lab_member]
    def role?(base_role)
      ROLES.index(base_role.to_s) <= ROLES.index(role)
    end
end

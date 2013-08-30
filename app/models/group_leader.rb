class GroupLeader < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
  			 :trackable, :validatable, :lockable, :timeoutable

  belongs_to :lab
  belongs_to :department
  belongs_to :institute


end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockaboe, and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  belongs_to :lab

  validates_presence_of :lab, message: "Your group leader must create an account first"

  def lab
    lab.try(:email)
  end
  
  def lab=(email)
    self.lab = Lab.find_or_create_by(email) if email.present?
  end

  protected

end

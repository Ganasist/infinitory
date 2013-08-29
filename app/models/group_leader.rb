class GroupLeader < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable

  belongs_to :lab

  before_validation :admin_cascade

  validates :email, uniqueness: true, presence: true,
   					format: { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
                      :message => 'Invalid e-mail! Please provide a valid e-mail address'}

  protected

  	def admin_cascade
  		self.admin = true
  	end
end

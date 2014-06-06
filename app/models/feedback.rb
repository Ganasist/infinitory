class Feedback
	include ActiveAttr::Model

  attribute :email
  attribute :comment
  attribute :user

  attr_accessor :comment
  
  validates_presence_of :email
  validates_presence_of :comment, message: "Feedback can't be blank"
  validates_presence_of :user
  
  validates_format_of :email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  validates_length_of :comment, maximum: 223
end
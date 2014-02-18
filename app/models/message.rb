class Message
	include ActiveAttr::Model

  attribute :email
  attribute :comment
  attribute :user_name

  attr_accessor :email, :comment, :username
  
  validates_presence_of :email
  validates_presence_of :comment
  validates_presence_of :username
  validates_format_of :email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  validates_length_of :comment, maximum: 223
end
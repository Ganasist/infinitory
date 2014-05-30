class Request < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email, message: "That email address has been used already"
  
  validates_presence_of :institute, message: "You must enter your university or institute"
  
  validates_format_of :email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i, message: "Not a valid email address"
end


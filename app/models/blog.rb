class Blog < ActiveRecord::Base

	validates :title, :entry, :url, presence: true
end

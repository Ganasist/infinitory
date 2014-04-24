class Blog < ActiveRecord::Base

	validates :title, :entry, :url, presence: true
	before_save :generate_bitly, on: :create

	private
		def generate_bitly
			b = Bitly.client
			u = b.shorten('http://www.infinitory.com/blog/' + self.id.to_s)
			self.bitly_url = u.short_url
		end
end

class Blog < ActiveRecord::Base

	validates :title, :entry, :url, presence: true
	after_save :generate_bitly, on: :create

	private
		def generate_bitly
			b = Bitly.client
			bitly = b.shorten('http://www.infinitory.com/blog/' + self.id.to_s)
			self.update_column(:bitly_url, bitly.short_url)
		end
end
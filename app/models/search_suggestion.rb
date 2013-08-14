class SearchSuggestion < ActiveRecord::Base
	def self.terms_for(prefix)
	  suggestions = where("term like ?", "#{prefix}_%")
	  suggestions.order("popularity desc").limit(10).pluck(:term)
	end

	def self.index_institutes
		Institute.find_each do |institute|
			index_term(institute.name)
	    institute.name.split.each { |t| index_term(t) }
	    index_term(institute.city)
		end
	end

	def self.index_term(term)
	  where(term: term.downcase).first_or_initialize.tap do |suggestion|
	    suggestion.increment! :popularity
	  end
	end
end

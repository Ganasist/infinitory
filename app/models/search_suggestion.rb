class SearchSuggestion < ActiveRecord::Base

	def self.terms_for(prefix)
	  suggestions = where("term ilike ?", "#{prefix}_%")
	  suggestions.order("popularity desc").limit(10).pluck(:term)
	end

	def self.index_institutes
	  Institute.find_each do |institute|
	    index_term(institute.name)
	    if institute.alternate_name.present?
		    index_term(institute.alternate_name)
    	end
    	if institute.acronym.present?
		    index_term(institute.acronym)
		  end
	  end
	end

	def self.index_term(term)
	  where(term: term).first_or_initialize.tap do |suggestion|
	    suggestion.increment! :popularity
	  end
	end
end


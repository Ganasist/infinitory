class SearchSuggestion
	def self.terms_for(prefix)
    $redis.zrevrange "search-suggestions:#{prefix.downcase}", 0, 4
  end 

  def self.index_institutes
    Institute.find_each do |institute|
      index_term(institute.name)
      index_term(institute.city)
      index_term(institute.acronym) if institute.acronym.present?
    end
  end

  def self.index_term(term)
    1.upto(term.length - 1) do |n|
      prefix = term[0, n]
      $redis.zincrby "search-suggestions:#{prefix.downcase}", 1, term.downcase
    end
  end
end

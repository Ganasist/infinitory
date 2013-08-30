class SearchSuggestionsController < ApplicationController
  respond_to :json
  def index
    render json: SearchSuggestion.terms_for(params[:term])
  end
end
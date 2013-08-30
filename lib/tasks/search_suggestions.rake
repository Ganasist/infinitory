namespace :search_suggestions do
  desc "Generate search suggestions from institutes"
  task :index => :environment do
    SearchSuggestion.index_institutes
  end
end
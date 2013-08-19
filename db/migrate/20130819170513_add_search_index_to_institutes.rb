class AddSearchIndexToInstitutes < ActiveRecord::Migration
  def up
    execute "create index institutes_name on institutes using gin(to_tsvector('english', name))"
    execute "create index institutes_city on institutes using gin(to_tsvector('english', city))"
    execute "create index institutes_country on institutes using gin(to_tsvector('english', country))"
    execute "create index institutes_acronym on institutes using gin(to_tsvector('english', acronym))"
    execute "create index institutes_alternate_name on institutes using gin(to_tsvector('english', alternate_name))"
  end

  def down
    execute "drop index institutes_alternate_name"
    execute "drop index institutes_acronym"
    execute "drop index institutes_country"
    execute "drop index institutes_city"
    execute "drop index institutes_name"
  end
end

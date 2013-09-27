class AddIndexToReagentsProperties < ActiveRecord::Migration
  def up
    execute "CREATE INDEX reagents_properties ON reagents USING GIN(properties)"
  end

  def down
    execute "DROP INDEX reagents_properties"
  end
end

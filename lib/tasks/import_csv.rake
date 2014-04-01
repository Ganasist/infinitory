require 'csv'

desc "Import items from csv file"
task :import_csv => [:environment] do

  file = "db/test.csv"

  CSV.foreach(file, headers: true, col_sep: ';') do |row|
    Reagent.create! row.to_hash
  end

end
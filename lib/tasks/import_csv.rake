require 'csv'

desc "Import items from csv file"
task :import_csv => [:environment] do

  file = "db/test_010414.csv"
  test = file.force_encoding("ISO-8859-1").encode('UTF-8', :invalid => :replace, :replace => '?')

  CSV.foreach(test, headers: true, col_sep: ';') do |row|
    Reagent.create! row.to_hash
  end

end
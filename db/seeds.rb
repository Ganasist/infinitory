institute_list = File.readlines("500 universities.txt")

Institute.delete_all
institute_list.each do |name|
  Institute.create!(:name => name)
end
institute_list = File.read("500 universities.txt").split(/\n/).reject(&:empty?)

Institute.delete_all
institute_list.each do |name|
  Institute.create!(:name => name)
end
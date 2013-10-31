object @department
attributes :name

child(:labs => "children") do
  attribute :name
  child(:users => "children") do
  	node :name do |n|
  		n.fullname
  	end
    node :size do |s|
      1
    end
  end
end
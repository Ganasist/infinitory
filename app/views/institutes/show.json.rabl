object @institute
attributes :name

child(@test) do
  attributes :name
  node :size do |u|
	  u.size
	end
end

child(@departments => "children") do
  attribute :name
  child(:labs => "children") do
  	attribute :name
  	node :size do |u|
		  u.size
		end
  end
end
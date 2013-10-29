object @institute
attributes :name

child :departments => "children" do
  attribute :name
  child :labs => "children" do
  	attribute :name
  	node :size do |u|
		  u.size
		end
  end
end

child :labs => "children" do
	attribute :name
	node :size do |u|
	  u.size
	end
end
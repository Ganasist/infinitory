object @institute
attributes :name

node :children do
  @orphans.map do |o|
		{ name: o.name, size: o.size }
	end
end

child @departments => "children" do
  attribute :name
  child(:labs => "children") do
  	attribute :name
    node :size do |l|
      l.size
    end
  end
end
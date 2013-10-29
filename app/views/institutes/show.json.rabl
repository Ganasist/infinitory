object @institute
attributes :name

child :departments => "children" do
  attribute :name
  child :labs => "children" do
  	attribute :name
  	child :users => "children" do
  		attribute :email => :name
  		node(:size) { 1 }
  	end
  end
end
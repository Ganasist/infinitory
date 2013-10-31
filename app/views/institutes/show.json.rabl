object @institute
attributes :name

child @departments => "children" do
  attribute :name
  child(:labs => "children") do
  	node :name do |u|
      u.name + " test"
    end
    child(:users => "children") do
      node :name do |u|
        u.email
      end
      node :size do
        1
      end
    end
  end
end


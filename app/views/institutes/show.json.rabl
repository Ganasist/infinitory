object @institute
attributes :name

child @departments => "children" do
  attribute :name
  child(:labs => "children") do
  	attribute :name
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


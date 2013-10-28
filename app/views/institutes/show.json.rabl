object @institute
attributes :name

child :departments do
  attributes :name
  child :labs do
  	attributes :name
  	child :users do
  		attributes :email
  	end
  end
end
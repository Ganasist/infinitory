json.array!(@reagents) do |reagent|
  json.extract! reagent, :name, :category, :owner, :location, :price, :serial, :quantity, :properties
  json.url reagent_url(reagent, format: :json)
end

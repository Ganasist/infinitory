json.array!(@institutes) do |institute|
  json.extract! institute, :name, :alternate_name, :acronym, :latitude, :longitude, :city, :address
  json.url institute_url(institute, format: :json)
end

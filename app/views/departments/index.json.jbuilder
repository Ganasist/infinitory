json.array!(@departments) do |department|
  json.extract! department, :name, :institute_id, :address, :longitude, :latitude
  json.url department_url(department, format: :json)
end

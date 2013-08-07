json.array!(@labs) do |lab|
  json.extract! lab, :department_id, :institute_id, :group_leader, :group_leader_email
  json.url lab_url(lab, format: :json)
end

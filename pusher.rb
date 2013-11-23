t = Lab.first.reagents.to_a

for i in t do
	i.user_ids = Lab.first.user_ids.sample(Random.rand(13))
	i.save
end
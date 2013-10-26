jQuery ->
	if gon?
		jsonData = {"name": gon.institute.name, "children":[{"name": gon.departments[0].name, "size": gon.departments.length, "children":[{"name":"labs","size": gon.labs.length, "children":[{"name":"member1","size": 1 },{"name":"member2","size": 1 }]}]}]}
		myFlower = new CodeFlower("#visualization", 350, 350).update(jsonData)

		console.log gon.departments
		console.log gon.labs
		console.log gon.users
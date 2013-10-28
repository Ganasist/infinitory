jQuery ->
	if gon?
		jsonData =
			"name": gon.institute.name
			"children": for department in gon.institute.departments
				"name":	department.name
				"children": for lab in department.labs
					"name": lab.name
					"size": lab.users.length

		myFlower = new CodeFlower("#visualization", 330, 250)
		myFlower.update(jsonData)

		console.log gon.institute.name
jQuery ->
	if gon?
		myFlower = new CodeFlower("#visualization", 400, 400)
		myFlower.update(gon.institute)

		console.log gon.institute
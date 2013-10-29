jQuery ->
	if gon?
		myFlower = new CodeFlower("#visualization", 350, 350)
		myFlower.update(gon.institute)

		console.log gon.institute
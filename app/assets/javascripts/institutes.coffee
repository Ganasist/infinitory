jQuery ->
	if gon?
		myFlower = new CodeFlower("#visualization", 300, 300)
		myFlower.update(gon.institute)

		console.log gon.institute
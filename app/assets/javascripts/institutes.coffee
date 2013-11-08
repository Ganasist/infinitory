if gon? && ($("#instituteFlower").length)
	instituteFlower = new CodeFlower("#instituteFlower", 350, 350)
	instituteFlower.update(gon.watch('rabl'))
	console.log gon.institute
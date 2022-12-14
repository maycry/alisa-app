# Shuffle array
export def shuffle(array)
	let currentIndex = array.length 
	let randomIndex

	while (currentIndex != 0) 
		randomIndex = Math.floor(Math.random() * currentIndex)
		currentIndex--
		[array[currentIndex], array[randomIndex]] = [array[randomIndex], array[currentIndex]]

	return array

export def getRandomInt max
	Math.floor Math.random() * max
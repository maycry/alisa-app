const prompts = ["1+2", "3+5", "2+5", "4+5"]

def getRandomInt max
	Math.floor Math.random() * max

tag prompt-box
	
	prop currentPrompt = getRandomInt prompts.length
	
	<self>
		<div> prompts[currentPrompt]

imba.mount <prompt-box>

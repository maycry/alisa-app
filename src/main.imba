import {shuffle,getRandomInt} from "./utils.imba"
import "./app.css"


let result = "?"
let submited? = false
let submitedCorrect? = false

class Level
	prop a 
	prop b 
	prop answers
	prop currentPrompt = -1
	prop promptsTotal = 10
	prop promptHistory = []

	def nextPrompt
		currentPrompt++
		a = getRandomInt 10
		b = getRandomInt 10
		answer1 = { result: a + b, correct: true, active: false }
		answer2 = { result: a + b + 1, correct: false, active: false }
		answer3 = { result: a + b + 2, correct: false, active: false }
		answer4 = { result: a + b - 1, correct: false, active: false }
		answers = [answer1, answer2, answer3, answer4]
		shuffle(answers)
		result = "?"
		submited? = false

	constructor
		nextPrompt()
		for i in [0 ... promptsTotal]
			promptHistory.push({completed: false, correct: false})

let lvl = new Level

tag app
	
	def handleSelect(e)
		result = lvl.a + lvl.b
		submitedCorrect? = e.detail
		submited? = true

	def reload
		lvl.promptHistory[lvl.currentPrompt]={completed: true, correct: submitedCorrect?}
		lvl.nextPrompt()
	
	css .grid d:grid grid-gap:13px gtc:1fr 1fr mt:10px
		.prompt bgc:cool2 rd:lg aspect-ratio:1/1 d:flex ai:center jc:center fs:2xl gc: 1 / 3 aspect-ratio: 2 / 1
		.next bgc:cool2 rd:lg d:flex ai:center jc:center fs:2xl gc: 1 / 3 h:100px 
		.next@active bgc:cool3 scale:95%
	
	def render
		<self>
			<div.grid>
				<.prompt> "{lvl.a}+{lvl.b}={result}"
				for answer in lvl.answers
					<answer-item  @select=(handleSelect(e)) data=answer>
				<button.next @click=reload [d:none]=!submited?> "Next"
			<ticks-group>

tag answer-item
	def select(data)
		data.active = true
		emit("select", data.correct)

	css aspect-ratio:1/1 d:flex ai:center jc:center
		button bgc:cool2 size:100% rd:lg fs:2xl
		button@active bgc:cool3 scale:95%
		.correct bgc:green4
		.incorrect bgc:red4
	
	<self> 
		<button @click=select(data) .correct=(data.active and data.correct) .incorrect=(data.active and !data.correct)> data.result

tag ticks-group
	css h:50px  w:100% d:flex g:10px pos:fixed b:0px jc:center
		div size:24px bgc:gray3 rd:full c:gray3
		.correct bgc:green4 c:green4
		.incorrect bgc:red4 c:red4

	<self>
		for prompt, i in lvl.promptHistory
			<div .correct=(prompt.correct and prompt.completed) .incorrect=(!prompt.correct and prompt.completed)> i + 1

imba.mount <app>

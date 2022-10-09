import {shuffle, getRandomInt} from "./utils.imba"
import "./app.css"

class Level
	prop a 
	prop b 
	prop answers
	prop currentPrompt = -1
	prop promptsTotal = 10
	prop promptHistory = []
	prop submited? = false
	prop submitedCorrect? = false

	def nextPrompt
		currentPrompt++
		a = getRandomInt 10
		b = getRandomInt 10
		answer1 = {result: a + b,     correct: true,  active: false}
		answer2 = {result: a + b + 1, correct: false, active: false}
		answer3 = {result: a + b + 2, correct: false, active: false}
		answer4 = {result: a + b - 1, correct: false, active: false}
		answers = [answer1, answer2, answer3, answer4]
		shuffle(answers)
		submited? = false

	constructor
		nextPrompt()
		for i in [0 ... promptsTotal]
			promptHistory.push({completed: false, correct: false})

let lvl = new Level

tag app
	def handleSelect(e)
		lvl.submitedCorrect? = e.detail.correct
		lvl.promptHistory[lvl.currentPrompt]={
			completed: true
			correct: lvl.submitedCorrect?
			}
		lvl.submited? = true

	def reload
		lvl.nextPrompt()
		if lvl.currentPrompt > lvl.promptsTotal - 1
			imba.unmount self
			imba.mount <modal-complete>
	
	css .grid d:grid grid-gap:13px gtc:1fr 1fr mt:10px
		.prompt bgc:cool2 rd:lg aspect-ratio:1/1 d:flex ai:center jc:center fs:2xl gc: 1 / 3 aspect-ratio: 2 / 1
		.next bgc:cool2 rd:lg d:flex ai:center jc:center fs:2xl gc: 1 / 3 h:100px 
		.next@active bgc:cool3 scale:95%
	
	def render
		<self>
			<div.grid>
				<.prompt> 
					"{lvl.a}+{lvl.b}={lvl.submited? ? lvl.a + lvl.b : "?"}"
				for answer in lvl.answers
					<answer-item  @select=(handleSelect(e)) data=answer>
				if lvl.submited?
					<button.next @click=reload> "Next"
			<ticks-group>

tag answer-item
	def select
		data.active = true
		emit("select", data)

	css aspect-ratio:1/1 d:flex ai:center jc:center
		button bgc:cool2 size:100% rd:lg fs:2xl
		button@active bgc:cool3 scale:95%
		.correct bgc:green4
		.incorrect bgc:red4
	
	def render
		<self> 
			if data.active
				<button @click=select .correct=data.correct .incorrect=!data.correct> data.result
			else
				<button @click=select> data.result

tag ticks-group
	css h:50px  w:100% d:flex g:10px pos:fixed b:0px jc:center
		div size:24px bgc:gray3 rd:full c:gray3
		.correct bgc:green4 c:green4
		.incorrect bgc:red4 c:red4

	def render
		<self>
			for prompt, i in lvl.promptHistory
				if prompt.completed
					<div .correct=prompt.correct .incorrect=!prompt.correct> i + 1
				else
					<div> i + 1

tag modal-complete
	css pos:absolute bgc:cool5 size: 94% t:3% r:3% rd:lg d:flex jc:center ai:center fld:column g:20px
		fs:5xl c:white fs:4xl
		button fs:lg p:10px 20px rd:lg
	
	def restart
			lvl = new Level
			imba.unmount self
			imba.mount <app>

	def render
		<self>
			<div> "Good Job!"
			<button @click=restart> "Start over"



imba.mount <app>

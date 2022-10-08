import {shuffle,getRandomInt} from "./utils.imba"
import "./app.css"

const a = getRandomInt 10
const b = getRandomInt 10
const answer1 = { result: a + b, correct?: true }
const answer2 = { result: a + b + 1, correct?: false }
const answer3 = { result: a + b + 2, correct?: false }
const answer4 = { result: a + b - 1, correct?: false }
let result = "?"
let submited? = false
let answers = [answer1, answer2, answer3, answer4]
let stack = ["none", "none", "none", "none", "none", "none", "none", "none", "none", "none"]

tag app
	
	def handleSelect
		result = a + b
		submited? = true

	def reload
		window.location.reload()
		return false
	
	css .grid d:grid grid-gap:13px gtc:1fr 1fr mt:10px
		.prompt bgc:cool2 rd:lg aspect-ratio:1/1 d:flex ai:center jc:center fs:2xl gc: 1 / 3 aspect-ratio: 2 / 1
		.next bgc:cool2 rd:lg d:flex ai:center jc:center fs:2xl gc: 1 / 3 h:100px 
		.next@active bgc:cool3 scale:95%
	
	def render
		<self>
			<div.grid>
				<.prompt> "{a}+{b}={result}"
				for answer in answers
					<answer-item @select=(handleSelect) data=answer>
				# <button @click=reload .hide=!submited?> "Reload"
				<button.next @click=reload [d:none]=!submited?> "Next"
			<ticks-group>
			

tag answer-item
	prop isActiveCorrect = false
	prop isActiveIncorrect = false

	def select(data)
		if !submited?
			if data.correct? 
				isActiveCorrect = true
				stack[0] = true
			else 
				isActiveIncorrect = true
				stack[0] = false
		emit("select")

	css aspect-ratio:1/1 d:flex ai:center jc:center
		button bgc:cool2 size:100% rd:lg fs:2xl
		button@active bgc:cool3 scale:95%
		.correct bgc:green4
		.incorrect bgc:red4
	
	<self> 
		<button @click=select(data) .correct=isActiveCorrect .incorrect=isActiveIncorrect> data.result

tag ticks-group

	css h:50px  w:100% d:flex g:10px pos:fixed b:0px jc:center
		div size:24px bgc:gray3 rd:full c:gray3
		.correct bgc:green4 c:green4
		.incorrect bgc:red4 c:red4

	<self>
		for tick in [0...10]
			if tick === 0
				<div .correct=(stack[0]!=="none" and stack[0]) .incorrect=(stack[0]!=="none" and !stack[0])> tick + 1
			else
				<div> tick + 1

imba.mount <app>

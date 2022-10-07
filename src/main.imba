import {shuffle} from "./utils.imba"

css html ff: Sans-Serif

let answers = []

def getRandomInt max
	Math.floor Math.random() * max

let number1 = getRandomInt 10
let number2 = getRandomInt 10

def fillAnswers(a, b)
	answers.push(a + b) 
	answers.push(a + b + 1)
	answers.push(a + b + 2)
	answers.push(a + b - 1)

fillAnswers(number1, number2)
shuffle(answers)

console.log "Test"

tag app

	css d:grid grid-gap:13px gtc:1fr 1fr mt:10px
		div bgc:cool2 rd:lg aspect-ratio:1/1 d:flex ai:center jc:center fs:2xl
		div@first gc: 1 / 3 aspect-ratio: 2/1

	<self>
		<div> "{number1}+{number2}=?"
		for answer in answers
			<div> answer

imba.mount <app>

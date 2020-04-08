function disableReaction(buttonId) {
	console.log(buttonId)
	document.getElementById(buttonId+'type1').disabled = true
	document.getElementById(buttonId+'type2').disabled = true
	document.getElementById(buttonId+'type3').disabled = true
	document.getElementById(buttonId+'type4').disabled = true
	document.getElementById(buttonId+'dislike').disabled = true
}
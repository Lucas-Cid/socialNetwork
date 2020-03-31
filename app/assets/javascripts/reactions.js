function changeReaction(button, owner_id, owner_type) {

	if (button.style.color == 'blue') {
		var counter_id = 'counter'+owner_type+owner_id+'_'+button.value;
		button.style.color = 'black';
		counter = document.getElementById(counter_id).innerHTML
		counter = counter-1
	}


}
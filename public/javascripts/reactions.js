function changeReaction(button, owner_id, owner_type, user_id, ownerPost_id) {
	if (user_id == ownerPost_id)
	{

	}
	else
	{

		if (button.style.color == 'rgb(51, 51, 204)') {
			var counter_id = 'counter'+owner_type+owner_id+'_'+button.value;
			button.style.color = 'black';
			var counter = document.getElementById(counter_id).innerHTML;
			document.getElementById(counter_id).innerHTML = counter-1;
		}
		else {
			let types = ['type1', 'type2', 'type3', 'type4', 'dislike']

			for (let type of types) {
				otherReactionsId = 'reaction'+owner_type+owner_id+'_'+type;
				var element = document.getElementById(otherReactionsId)
				if (element.style.color == 'rgb(51, 51, 204)')
				{
					element.style.color = 'black';

					var counter_id = 'counter'+owner_type+owner_id+'_'+element.value;
					var counter = document.getElementById(counter_id).innerHTML;
					document.getElementById(counter_id).innerHTML = counter-1;
				}
			}

			var counter_id = 'counter'+owner_type+owner_id+'_'+button.value;
			button.style.color = 'rgb(51, 51, 204)';
			var counter = document.getElementById(counter_id).innerHTML;
			document.getElementById(counter_id).innerHTML = parseInt(counter)+1;
		}

		if (owner_type == 'PostOpen')
		{
			var buttonId = 'reactionPost'+owner_id+'_'+button.value; 
			button = document.getElementById(buttonId);
			changeReaction(button, owner_id, 'Post', user_id, ownerPost_id);
		}
	}

}

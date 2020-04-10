function showImage(img){
	var modal = document.getElementById("imgModal");
	var modalImg = document.getElementById("img");
	modal.style.display = "block";
	modal.scrollTop = 0;
	modalImg.src = img.src;
	var span = document.getElementsByClassName("close")[0];
}

function closeImgModal() {
  var modal = document.getElementById("imgModal");
  modal.style.display = "none";
}
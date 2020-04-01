function loadDoc(lastPost_id, button, pageType, optionalId, controllerPath) {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var lastContent = document.getElementById("postsRender").innerHTML
      document.getElementById("postsRender").innerHTML= lastContent + this.responseText;
    }
  };
  var urlRequest =  controllerPath + "?lastPost_id=" + lastPost_id + "&pageType=" + pageType 
  				   + "&optionalId=" + optionalId 
  xhttp.open("GET", urlRequest, true);
  xhttp.send();

  button.style.display = 'none';
}
$(document).ready(function(){ 

	$.ajax({
	  type: 'POST',
	  url: '/reload',
	  timeout: 500
	});
	
	setInterval(function(){
		$.ajax({
		  type: 'POST',
		  url: '/updateFinish',
		  timeout: 1500,
		  success: function(data){
			  alert(data);
		  }
		});
	},4000);
});
$(document).ready(function(){ 

	$.ajax({
	  type: 'POST',
	  url: '/reload',
	  async: false,
	  timeout: 1500
	
	});
	
	setTimeout(function(){
		$.ajax({
		  type: 'POST',
		  url: '/updateFinish',
		  timeout: 1500,
		  success: function(data){
			  alert(data);
		  }
		});
	},60000*5);
});
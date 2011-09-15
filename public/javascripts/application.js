// Filter by Person

var names = [];

function get_names(){
  $("span.assigned-to").each(function(index) {
    names[index] = $(this).text().trim();
    names = $.unique(names);
    names.length = names.length - 1;
  });
};

function fill_select(){
  $.each(names,function(index,value){
    $("#names").append("<option value="+ (index + 1) +">"+value+"</option>");
  });
};

function show_all_tasks(){
  $(".item").each(function(){
    $(this).fadeIn('slow');
  });
}

function hide_all_tasks(){
  $(".item").each(function(){
    $(this).fadeOut('fast');
  });
}

function filter_by_name(){  
  if ($("#names").val() == 0){
    show_all_tasks();
  }
  else{
    name = names[$("#names").val()-1];
    hide_all_tasks();
    $("span.assigned-to").each(function(){
      if ($(this).text().trim() == name){
        $(this).parent().fadeIn('slow');
      };
    });
  };
};

$(document).ready(function(){
  get_names();
  fill_select();
  $('#names').change(function() {
    filter_by_name();
  });
  

  $("#main_board").tablesorter(); 

});



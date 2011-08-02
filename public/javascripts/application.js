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

function filter_by_name(){
  name = names[$("#names").val()];
  $("span.assigned-to").each(function(){
    if ($(this).text().trim() != name){
      $(this).parent().fadeOut('slow');
    }
    else{
      $(this).parent().fadeIn('slow');
    }
  });
};

$(document).ready(function(){
  get_names();
  fill_select();
  $('#names').change(function() {
    filter_by_name();
  });
});



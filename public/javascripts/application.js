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
  if ($("#names").val() == 0){
    $(".item").each(function(){
      $(this).fadeIn('fast');
    })
    return false;
  }
  $(".item").each(function(){
    $(this).fadeOut('fast');
  })
  $("span.assigned-to").each(function(){
    if ($(this).text().trim() != name){
      $(this).parent().fadeIn('slow');
    }
    else{
      $(this).parent().fadeOut('slow');
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



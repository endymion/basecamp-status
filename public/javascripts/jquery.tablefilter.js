/*!
 * jQuery TableFilter 1.0.0
 * 
 * Copyright 2011, Bakedweb.net
 *
 * Date: Thu Nov 03 15:04:36 2011 -0400
 */

(function($) {
  var columns_number = 0;
  var skip_column = false;
  var $columns_titles = new Array();
  var $opciones;
  var $table_ext;
  $.fn.tableFilter = function(user_opciones){
  
    $table_ext = this;
    //Merging the options
    var opciones_default = {
      exceptions: null,
      imgShowhide: null,
      divToDraw: 'body'
    }  
    
    $opciones = jQuery.extend(opciones_default , user_opciones);
    
    this.each( function(){
      $.fn.tableFilter.addClases(this); //set classes
      columns_titles = $.fn.tableFilter.getColumnsTitles(this);
      $.fn.tableFilter.drawFilter($.fn.tableFilter.getUniqueValues(this));
      $.fn.tableFilter.setButtonsFunctions();
    });
  
  };//tablefilter
  
  $.fn.tableFilter.getColumnsTitles = function(table){
    columns_number = $('._tablefilter_row0 td').size();
    $('thead th', table).each(function(index){
      if($opciones.exceptions != null){
        var exc_columns = $opciones.exceptions.split(",");
        for(j=0; j<= exc_columns.length; j++){
          if(exc_columns[j] - 1 == index){
            skip_column = true;
          }
        }
      }
      if(skip_column == false){
        $columns_titles[index] =  $(this).text().trim();
      }else{
        $columns_titles[index] = [];
        skip_column = false;
      }
    });
  }
  
  //This function adds classes to the columns and rows
  $.fn.tableFilter.addClases = function(table){
    $(table).addClass('tablefilter');
    $('tbody tr', table).each(function(iElement, element){
      $(element).addClass('_tablefilter_row' + iElement);
      $('td', element).each(function(iItem, item){
        $(item).addClass('_tablefilter_column'+iItem);
      });
    });
  };//tablefilter.addClases 
      
      
  $.fn.tableFilter.getUniqueValues = function(table){
    var columns = new Array(columns_number);
    for(i=0; i<= columns_number - 1; i++){ 
      if($opciones.exceptions != null){
        var exc_columns = $opciones.exceptions.split(",");
        for(j=0; j<= exc_columns.length; j++){
          if(exc_columns[j] - 1 == i){
            skip_column = true;
          }
        }
      }
      if(skip_column == false){
        columns[i] = new Array($("._tablefilter_column"+i).size());
        $("._tablefilter_column"+i).each(function(index){
          columns[i][index] = $(this).text().trim();
        });
        columns[i] = columns[i].getUniqueArraysValues();
      }else{
        columns[i] = [];
        skip_column = false;
      }
    }
    return columns;
  };
  
  //filter a array, remove duplicate items
  Array.prototype.getUniqueArraysValues = function () {
    var hash = new Object();
    for (j = 0; j < this.length; j++) {hash[this[j]] = true}
    var array = new Array();
    for (value in hash) {array.push(value)};
    return array;
  }
  
  $.fn.tableFilter.drawFilter =  function(data, divId){
    divId = $opciones.divToDraw;
    if($opciones.imgShowhide == null){
      var newTr = "<div id='_tableFilterToggleBtn'>show/hide filter</div><div id='_tableFilterList' style='display: none; padding: 10px;'>";
    }else{
      var newTr = "<div id='_tableFilterToggleBtn'><img src='"+ $opciones.imgShowhide +"'></div><div id='_tableFilterList' style='display: none; padding: 10px;'>";
    }
    for(i=0; i<= columns_number - 1 ; i++){
      newTr += "<div style='float: left; width:auto' class='scol"+ i +"'>";
      if($columns_titles[i] != "") {
        newTr += "<div class='_tableFilterTitle'>" + $columns_titles[i] + "</div>";
        newTr += "<input type='checkbox' id ='scol"+ i +"' class='col"+ i +" checkall' name='checkall' value='all' checked><span>all</span><br>";
      }
      for(j=0; j<= data[i].length - 1; j++){
          newTr += "<input type='checkbox' class='checkoption' name='option"+ j +"-tablefilter_column" + i + "' value='"+ data[i][j] +"' checked><span>"+ data[i][j] +"</span><br>";
      }
      newTr += "</div>";
    }
    newTr += "<div style='clear:both;'></div></div>";
    $('#' + divId).prepend(newTr);
  }
  
  $.fn.tableFilter.setButtonsFunctions =function(){
    $("#_tableFilterToggleBtn").click(function(){
      $("#_tableFilterList").toggle('slow', function() {
      });
    });
    
    $("#_tableFilterList input.checkoption").each(function(){
        $(this).change(function(){
          $.fn.tableFilter.filter();
        });
    });
    
    
    $.fn.tableFilter.filter =function(){
      $('tr', $table_ext).each(function(){
         $(this).css('display','');
       });
       
       $('#_tableFilterList input.checkoption').each(function(){
         column_aux = $(this).attr('name').split('-')
         column = column_aux[1];
         temp_value = $(this).val();
         temp_checked = $(this).is(':checked');
         
         $("._"+column, $table_ext).each(function(){
           if($(this).html().trim() == temp_value){
             if(temp_checked == false){
               $(this).parent().css('display','none');
             }
           }
         });
         
       });
    }
    
    $("#_tableFilterList input.checkall").each(function(){
       $(this).click(function(){
         $("."+$(this).attr('id') + " input.checkoption").each(function(){
           if( $(this).is(':checked') ){
             $(this).attr('checked', false);
           }else{
             $(this).attr('checked', true);
           }
         }); 
         $.fn.tableFilter.filter();
       });
    });
   
  }

})(jQuery);
describe("TableFilter Specs", function() {

  beforeEach(function() {
    loadFixtures('toTableFilter.html');
    $("#test_table").tableFilter({divToDraw: 'divDrawFilter'});
  });

  it("uncheck all on column 1", function() {
    $("#_tableFilterToggleBtn").click();
    $("#_tableFilterList input.col1.checkall").click();
    expect($("._tablefilter_row0").css("display")).toEqual("none");
    expect($("._tablefilter_row1").css("display")).toEqual("none");  
    expect($("._tablefilter_row2").css("display")).toEqual("none"); 
  });

  it("check all on column 1", function() {
    $("#_tableFilterToggleBtn").click();
    $("#_tableFilterList input.col1.checkall").click(); //uncheck
    $("#_tableFilterList input.col1.checkall").click(); //check
    expect($("._tablefilter_row0").attr('style')).toEqual("");
    expect($("._tablefilter_row1").attr('style')).toEqual("");  
    expect($("._tablefilter_row2").attr('style')).toEqual("");
  });
  

});
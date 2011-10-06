describe("TableFilter Specs", function() {

  beforeEach(function() {
    loadFixtures('toTableFilter.html');
    $("#test_table").tableFilter({divToDraw: 'divDrawFilter'});
  });

  it("uncheck all on column 1", function() {
    $("#_tableFilterToggleBtn").click();
    $("#_tableFilterList input.col1.checkall").click(); //uncheck
    expect($("._tablefilter_row0")).toBeHidden();
    expect($("._tablefilter_row1")).toBeHidden();
    expect($("._tablefilter_row2")).toBeHidden();
  });

  it("check all on column 1", function() {
    $("#_tableFilterToggleBtn").click();
    $("#_tableFilterList input.col1.checkall").click(); //uncheck
    $("#_tableFilterList input.col1.checkall").click(); //check
    expect($("._tablefilter_row0")).not.toBeHidden();
    expect($("._tablefilter_row1")).not.toBeHidden();
    expect($("._tablefilter_row2")).not.toBeHidden();
  });
  

});
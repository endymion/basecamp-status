describe("TableFilter Specs", function() {

  beforeEach(function() {
    loadFixtures('toTableFilter.html');
    $("#test_table").tableFilter({divToDraw: 'divDrawFilter'});
  });
  
  it("should exist basic filter elements", function(){
    expect($("#_tableFilterToggleBtn")).toExist();
    expect($("#_tableFilterList")).toExist();
    expect($("#_tableFilterList")).toExist();
  });
  
  it("spy button show/hide filter click event", function(){
    spyOnEvent($('#_tableFilterToggleBtn'), 'click');
    $('#_tableFilterToggleBtn').click();
    expect('click').toHaveBeenTriggeredOn($('#_tableFilterToggleBtn'));
  });
  
  it("click on tableFilterToggleBtn display & hide filter", function(){
    expect($("#_tableFilterList")).toBeHidden();
    $("#_tableFilterToggleBtn").click();
    expect($("#_tableFilterList")).not.toBeHidden();
  });
  
  it("all checkbox start checked", function(){
    $("#_tableFilterList input[type='checkbox']").each(function(){
      expect($(this)).toBeChecked();   
    });
  });
  
  it("should have all unique items on filter list, column name", function(){
    expect($("#_tableFilterList input[value='Hugo']").size()).toEqual(1);
    expect($("#_tableFilterList input[value='Hugo']")).toExist();
    expect($("#_tableFilterList input[value='Jose']")).toExist();
    expect($("#_tableFilterList input[value='TestName']")).toExist();
    expect($("#_tableFilterList input[value='OtherName']")).not.toExist();
  });

  it("uncheck all on column 1", function() {
    $("#_tableFilterToggleBtn").click();
    $("#_tableFilterList input.col0.checkall").click(); //uncheck
    expect($("._tablefilter_row0")).toBeHidden();
    expect($("._tablefilter_row1")).toBeHidden();
    expect($("._tablefilter_row2")).toBeHidden();
  });

  it("check all on column 1", function() {
    $("#_tableFilterToggleBtn").click();
    $("#_tableFilterList input.col0.checkall").click(); //uncheck
    $("#_tableFilterList input.col0.checkall").click(); //check
    expect($("._tablefilter_row0")).not.toBeHidden();
    expect($("._tablefilter_row1")).not.toBeHidden();
    expect($("._tablefilter_row2")).not.toBeHidden();
  });
  
  it("uncheck Hugo from filter", function() {
    $("#_tableFilterToggleBtn").click();
    $("#_tableFilterList input.checkoption[value='Hugo']").click();
    expect($("._tablefilter_row0")).toBeHidden(); //row0 'Hugo' should be hidden
    expect($("._tablefilter_row1")).not.toBeHidden();
    expect($("._tablefilter_row2")).not.toBeHidden();
  });
  

});
function onSubmit(e) {
  $('#branch').val($('#branch_ids').val().join(" "));
  $('#branch_ids').removeAttr('name');

  $.each(["start_date", "end_date"], function(index, id) {
    var a = [], elem;
    for (var i = 1; i <= 3; i++) {
      elem = $("#_" + id + "_" + i + "i");
      a[i] = elem.val();
      elem.removeAttr('name');
    }
    var date = new Date(Date.UTC(a[1], a[2] - 1, a[3])); // 2nd parameter is monthIndex
    console.log(date.toISOString());
    $("#" + id).val(date.toISOString().slice(0, 10));
  });

  $('#search-form input').each(function(index) {
    var item = $(this);
    if (!item.val() || item.val() == 'none') {
      item.removeAttr('name');
    }
  });
}

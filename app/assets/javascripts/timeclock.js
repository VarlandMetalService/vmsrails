function logout() {
  $.ajax({
    url: "/logout",
    type: 'DELETE'
  });
}

  window.onload = function startTime() {
    y = "AM"
    var today = new Date();
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
    var d = today.getDate();
    var t = today.getMonth()+1;
    var x = ""
    switch (today.getDay()) {
    case 0:
        x = "Sun";
        break;
    case 1:
        x = "Mon";
        break;
    case 2:
        x = "Tue";
        break;
    case 3:
        x = "Wed";
        break;
    case 4:
        x = "Thu";
        break;
    case 5:
        x = "Fri";
        break;
    case 6:
        x = "Sat";
}
    t = padTime(t);
    d = padTime(d);
    m = padTime(m);
    s = padTime(s);
    if (h > 12) {y = "PM"};
    h = checkHours(h);
    document.getElementById('clock').innerHTML =
    x + " " + t + "/" + d + " - " + h + ":" + m + ":" + s + " " + y;
    var t = setTimeout(startTime, 500);
  }
  function padTime(i) {
    if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
    return i;
  }
  function checkHours(i) {
    if (i == 0) {i = 12};
    if (i < 10) {i = "0" + i};
    if (i > 12) {i = i - 12 };
    return i;
  }
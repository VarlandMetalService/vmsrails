function logout() {
  $.ajax({
    url: "/logout",
    type: 'DELETE'
  });
}
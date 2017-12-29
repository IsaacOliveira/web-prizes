function addRule(){
  var form = document.getElementById("rule-form");
  var clonedForm = form.cloneNode(true);
  clonedForm.getElementsByTagName("input")[0].value = "";
  document.getElementById("all-rules-form").append(clonedForm);
}
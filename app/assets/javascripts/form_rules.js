function addRule(){
  var form = document.getElementById("rule-form");
  var clonedForm = form.cloneNode(true);
  clonedForm.getElementsByTagName("input")[0].value = "";
  document.getElementById("all-rules-form").append(clonedForm);
}

function removeRule(rule) {
  var allRulesForm = document.getElementById("all-rules-form")
  if(allRulesForm.childElementCount > 1){
    var form = rule.parentElement.parentElement.parentElement
    form.parentElement.removeChild(form)
  }else{
    alert("You can not remove all the rules")
  }
}
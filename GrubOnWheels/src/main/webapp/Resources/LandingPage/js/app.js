
let topic_arr=new Array('Movie Nights ?','Late night at office ?','Movie Marathon ?','Game Night ?','Hungry ?','Unexpected guests ?','Cooking gone Wrong ?');    
let topic_name=document.getElementById('topic');
let counter=0;
setInterval(changeTopic,3000);
function changeTopic() {
  topic_name.textContent =topic_arr[counter];
  counter++;
  if (counter >= topic_arr.length) {
    counter = 0;
  }
}
//Sidebar Event
let btn=document.getElementById('login');
btn.addEventListener('click',toggleSidebar);
function toggleSidebar(e)
{
  e.preventDefault();
  document.getElementById('overlay').style.display="block";
  document.getElementById('sidebar').classList.toggle('active');
}
//closing the Sidebar
let btn_close=document.getElementById('close-sidebar');
btn_close.addEventListener('click',closeSidebar);
function closeSidebar(e)
{
  e.preventDefault();
  document.getElementById('overlay').style.display="none";
  document.getElementById('sidebar').classList.toggle('active');
}

function validatePhoneNo(mobNo, action){
	var phNo = /^\d{10}$/;
	if(mobNo.value.match(phNo)){
		var xhr = new XMLHttpRequest();
        xhr.open("GET", "PhoneNumberServlet?phone=" + mobNo.value + "&action=" +action, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                if (xhr.responseText === "true") {
                    alert("Phone number already exists in the database. Please Log in");
                    return false;
                } else if(xhr.responseText.startsWith("invalid")){
                	alert("Phone Number is invalid");
                	return false;
                }
                else {
                	return true;
               }
            }
        };
        xhr.send();
		
	} else{
		alert("Enter a 10 digit Phone Number");
		return false;
	}
}

function validateForgotPhoneNo(mobNo, action){
	var phNo = /^\d{10}$/;
	if(mobNo.value.match(phNo)){
		var xhr = new XMLHttpRequest();
        xhr.open("GET", "PhoneNumberServlet?phone=" + mobNo.value + "&action=" +action, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                if (xhr.responseText === "true") {
                    return true;
                } 
                else {
                	alert("Phone Number does not exist in the database. Please create an account");
                	return false;
               }
            }
        };
        xhr.send();
	} else{
		alert("Enter a 10 digit Phone Number");
		return false;
	}
}

function validatePassword(password){
	var passwordPattern = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\S+$).{8,20}$/;
	if(password.value.match(passwordPattern)){
		return true;
	} else{
		alert("Password must be of 8 to 20 characters and contain atleast 1 digit, lowercase, uppercase and special character");
		return false;
	}
}

function checkPassword(){
	var pass1 = document.getElementById("password").value;
	var pass2 = document.getElementById("cpassword").value;
	if(pass1 != pass2){
		alert("Passwords do no match!");
		return false;
	} else{
		return true;
	}
}

function togglePassword(){
	var password = document.getElementById("password");
	if(password.type === "password"){
		password.type = "text";
	} else{
		password.type = "password";
	}
}

function toggleCPassword(){
	var password = document.getElementById("cpassword");
	if(password.type === "password"){
		password.type = "text";
	} else{
		password.type = "password";
	}
}
//Changing the Background Image
function changeImage()
{
  let bg=document.getElementById('header-content-2');
  let val=Math.floor((Math.random()*3)+1);
  console.log(val);
  switch(val)
  {
    
    case 1: bg.style.background="url('../img/bg-1.webp') no-repeat center center/cover";
    break;
    case 2: bg.style.background="url('../img/bg-2.webp') no-repeat center center/cover";
    break;
    case 3: bg.style.background="url('../img/bg-3.jpg') no-repeat center center/cover";
    break;

  }
}
changeImage();


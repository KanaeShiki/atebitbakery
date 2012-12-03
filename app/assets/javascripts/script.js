function validate()
{
	hideAllErrors();

	if(checkfields()>0)
	{
		return false;
	}
 	
	return true;
}
 
function hideAllErrors()
{
	document.getElementById('nameerror').style.visibility="hidden";
	document.getElementById('emailerror').style.visibility="hidden";
	document.getElementById('phoneerror').style.visibility="hidden";
}
 
function checkfields()
{
 	
	var errors=0;
 	
	var val=document.getElementById('name').value;
	
	if(val==" " || val=="" || val==null)
	{
		if(errors==0)
 		{
		document.getElementById('nameerror').style.visibility="visible";
		document.getElementById('name').focus();
		document.getElementById('name').select();
		}
		errors++;
	}
	 
	var val=document.getElementById('email').value;
	 			 	
	if(val==" " || val=="" ||  val==null ||  val.search(/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/) == -1)
	{
	 			 	
	 	if(errors==0)
	 	{
	 	document.getElementById('emailerror').style.visibility="visible";
	 	document.getElementById('email').focus();
	 	document.getElementById('email').select();
	 	}
	 	errors++;
 	}
 	
 	var val=document.getElementById('phone').value;
					
	if(val==" " || val=="" ||  val==null || val.length != 10 || isNaN(val)) 
	{
					 	
		if(errors==0)
		{
		document.getElementById('phoneerror').style.visibility="visible";
		document.getElementById('phone').focus();
		document.getElementById('phone').select();
		}
		errors++;
	 }
 	
 	return errors;
 	
}
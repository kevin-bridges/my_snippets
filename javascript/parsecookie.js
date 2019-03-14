// Reuse this function when parsing cookies in javascript

function parseCookie(){
	var obj = {};
	cookieArr = document.cookie;
	cookieArr = cookieArr.split(";");
	
	for (var i = 0; i < cookieArr.length; i++){
		//trim
		var cookieKV = cookieArr[i];
		cookieKV = cookieKV.trim();
		
		// split on "="
		var cookieKVArr = cookieKV.split("=");
		
		// store kv on obj
		obj[cookieKVArr[0]] = cookieKVArr[1];
	}
	
	return obj;
}


// HOW TO USE
// c = parseCookie();
// c.<CookieId>
//		c.SID

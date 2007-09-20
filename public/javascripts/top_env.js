var TopNav = Class.create();

TopNav.prototype = {
	is_active: false,
		
	// initialize()
	// Constructor runs on completion of the DOM loading.
	// The function copies html of .env to the bottom of the page which is used to display the 
	// drop-down environment list.
	//
	initialize: function() {	
		var envDiv = $$('.env div.hd-content');
		if (envDiv.size == 0) { return; }
		
		var newEnvDiv = $(document.createElement("div"));
		newEnvDiv.addClassName('env');
		//newEnvDiv.style.display = 'none';
		newEnvDiv.innerHTML = envDiv[0].innerHTML;
		newEnvDiv.hide();

		$('top-env').appendChild(newEnvDiv);
		$('top-env').onclick = function() {
			var obj = $(this.lastChild);
			myTopNav.is_active ? obj.hide() : obj.show();
			myTopNav.is_active = !myTopNav.is_active;
		}
	},
}

function initTopNav() { myTopNav = new TopNav(); }
initTopNav();


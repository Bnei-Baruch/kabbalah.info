var TopNav = Class.create();

TopNav.prototype = {
	is_active: 0,
		
	// initialize()
	// Constructor runs on completion of the DOM loading.
	// The function copies html of .env to the bottom of the page which is used to display the 
	// drop-down environment list.
	//
	initialize: function() {	
		var envDiv = $$('.env div.hd-content');
		if (envDiv.size == 0) { return; }
		
		var newEnvDiv = document.createElement("div");
		newEnvDiv.addClassName('env');
		//newEnvDiv.style.display = 'none';
		newEnvDiv.innerHTML = envDiv[0].innerHTML;
		$('top-env').appendChild(newEnvDiv);
		newEnvDiv.onclick = function() {
			this.is_active ? this.show() : this.hide();
			this.is_active = !this.is_active;
		}
	},
}

function initTopNav() { myTopNav = new TopNav(); }
initTopNav();


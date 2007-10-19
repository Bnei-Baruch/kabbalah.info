// This script: 1. Creates drop-down environments 2. Replaces 'rel="external"' with 'target="_blank'"
var TopNav = {
	is_active: false,
	dropdown: null,
	topenva: null,
	
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
		newEnvDiv.addClassName('drop-down');
		newEnvDiv.hide();
		// copy everything excluding script (Sortable in admin mode)
      // 'ul' and 'li' must be copied without id(s)
      this.copyNode(envDiv[0], newEnvDiv);

		$('top-env').appendChild(newEnvDiv);

		this.dropdown = $$('.drop-down')[0];
		this.topenva = $$('#top-env a')[0];
		this.topenva.onclick = function() {return false}
	},
   copyNode: function(fromNode, toNode) {
      $A(fromNode.childNodes).each(function(fromChild, index){
          if ((fromChild.tagName == undefined) ||
              (fromChild.tagName && fromChild.tagName != "IMG") ||
              (fromChild.tagName && fromChild.tagName != "SCRIPT")) {
            clone = fromChild.cloneNode(false);
            if (clone.id != "") {
              clone.id += "x";
            }
            var toChild = toNode.appendChild(clone);
            TopNav.copyNode(fromChild, toChild);
          }
      });
   },
	onmouse: function(event){
		var dropdown = this.dropdown;
		var target = Event.element(event);
		var ansc = target.ancestors();
		var desc = target.descendants();
		if (event.type == "mouseover") {
			if (ansc.indexOf(dropdown) != -1 ||
					desc.indexOf(dropdown) != -1 ||
					target == this.topenva ||
					target == dropdown) {
				dropdown.show();
			}
		} else {
			dropdown.hide();
		}
		return false;
	}
}

TopNav.initialize();
Event.observe('top-env', "mouseover", TopNav.onmouse.bindAsEventListener(TopNav));
Event.observe('top-env', "mouseout", TopNav.onmouse.bindAsEventListener(TopNav));

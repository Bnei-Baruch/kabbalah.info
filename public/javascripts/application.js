// Replaces 'rel="external"' with 'target="_blank'"
function externalLinks() {
	if (!document.getElementsByTagName) return;
	var anchors = document.getElementsByTagName("a");
	for (var i=0; i<anchors.length; i++) {
		var anchor = anchors[i];
		var relvalue = anchor.getAttribute("rel");

		if (anchor.getAttribute("href")) {
			var external = /external/;
			if (external.test(relvalue)) { anchor.target = "_blank"; }
		}
	}
}
window.onload = externalLinks;

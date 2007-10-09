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


/** 
 *  @fileoverview TextResizeDetector
 * 
 *  Detects changes to font sizes when user changes browser settings
 *  <br>Fires a custom event with the following data:<br><br>
 * 	iBase  : base font size  	
 *	iDelta : difference in pixels from previous setting<br>
 *  	iSize  : size in pixel of text<br>
 *  
 *  * @author Lawrence Carvalho carvalho@uk.yahoo-inc.com
 * @version 1.0
 */

/**
 * @constructor
 */
TextResizeDetector = function() { 
    var el  = null;
	var iIntervalDelay  = 200;
	var iInterval = null;
	var iCurrSize = -1;
	var iBase = -1;
 	var aListeners = [];
 	var createControlElement = function() {
	 	el = document.createElement('span');
		el.id='textResizeControl';
		el.innerHTML='&nbsp;';
		el.style.position="absolute";
		el.style.left="-9999px";
		var elC = document.getElementById(TextResizeDetector.TARGET_ELEMENT_ID);
		// insert before firstChild
		if (elC)
			elC.insertBefore(el,elC.firstChild);
		iBase = iCurrSize = TextResizeDetector.getSize();
 	};

 	function _stopDetector() {
		window.clearInterval(iInterval);
		iInterval=null;
	};
	function _startDetector() {
		if (!iInterval) {
			iInterval = window.setInterval('TextResizeDetector.detect()',iIntervalDelay);
		}
	};
 	
 	 function _detect() {
 		var iNewSize = TextResizeDetector.getSize();
		
 		if(iNewSize!== iCurrSize) {
			for (var 	i=0;i <aListeners.length;i++) {
				aListnr = aListeners[i];
				var oArgs = {  iBase: iBase,iDelta:((iCurrSize!=-1) ? iNewSize - iCurrSize + 'px' : "0px"),iSize:iCurrSize = iNewSize};
				if (!aListnr.obj) {
					aListnr.fn('textSizeChanged',[oArgs]);
				}
				else  {
					aListnr.fn.apply(aListnr.obj,['textSizeChanged',[oArgs]]);
				}
			}

 		}
 		return iCurrSize;
 	};
	var onAvailable = function() {
		
		if (!TextResizeDetector.onAvailableCount_i ) {
			TextResizeDetector.onAvailableCount_i =0;
		}

		if (document.getElementById(TextResizeDetector.TARGET_ELEMENT_ID)) {
			TextResizeDetector.init();
			if (TextResizeDetector.USER_INIT_FUNC){
				TextResizeDetector.USER_INIT_FUNC();
			}
			TextResizeDetector.onAvailableCount_i = null;
		}
		else {
			if (TextResizeDetector.onAvailableCount_i<600) {
	  	 	    TextResizeDetector.onAvailableCount_i++;
				setTimeout(onAvailable,200)
			}
		}
	};
	setTimeout(onAvailable,500);

 	return {
		 	/*
		 	 * Initializes the detector
		 	 * 
		 	 * @param {String} sId The id of the element in which to create the control element
		 	 */
		 	init: function() {
		 		
		 		createControlElement();		
				_startDetector();
 			},
			/**
			 * Adds listeners to the ontextsizechange event. 
			 * Returns the base font size
			 * 
			 */
 			addEventListener:function(fn,obj,bScope) {
				aListeners[aListeners.length] = {
					fn: fn,
					obj: obj
				}
				return iBase;
			},
			/**
			 * performs the detection and fires textSizeChanged event
			 * @return the current font size
			 * @type {integer}
			 */
 			detect:function() {
 				return _detect();
 			},
 			/**
 			 * Returns the height of the control element
 			 * 
			 * @return the current height of control element
			 * @type {integer}
 			 */
 			getSize:function() {
	 				var iSize;
			 		return el.offsetHeight;
		 		
		 		
 			},
 			/**
 			 * Stops the detector
 			 */
 			stopDetector:function() {
				return _stopDetector();
			},
			/*
			 * Starts the detector
			 */
 			startDetector:function() {
				return _startDetector();
			}
 	}
}();

function getStyle(el, style)
{
  if(!document.getElementById) return;

	var value = parseInt(el.style[toCamelCase(style)]);

  if(isNaN(value) || value == 0) {
		if(document.defaultView)
			value = document.defaultView.getComputedStyle(el, "").getPropertyValue(style);
		else if(el.currentStyle)
			value = el.currentStyle[toCamelCase(style)];
	}
	value = parseInt(value);
   if(isNaN(value)) {
     if (style == 'width')
       return el.offsetWidth;
     else if (style == 'height')
       return el.offsetHeight;
   }

	return value;
}

function setStyle(el, styl, value) {
  el.style[styl] = value;
}

function toCamelCase( sInput ) {
  var oStringList = sInput.split('-');

  if(oStringList.length == 1)   
    return oStringList[0];

  var ret = sInput.indexOf("-") == 0 ?
       oStringList[0].charAt(0).toUpperCase() + oStringList[0].substring(1) : oStringList[0];

  for(var i = 1, len = oStringList.length; i < len; i++){
    var s = oStringList[i];
    ret += s.charAt(0).toUpperCase() + s.substring(1)
  }

  return ret;
}

var resizableswf = null;
var baseSize;
var origWidth;
var origheight;
TextResizeDetector.TARGET_ELEMENT_ID = 'resizer';
TextResizeDetector.USER_INIT_FUNC = init;
    
function init(){
  var iBase = TextResizeDetector.addEventListener( onFontResize, null );
  resizableswf = document.getElementById('flashbox');
  origWidth  = parseFloat(getStyle(resizableswf, "width" ));
  origHeight = parseFloat(getStyle(resizableswf, "height"));
  if (iBase != 16){
		var sizeDiff = parseFloat(getStyle(document.getElementById(TextResizeDetector.TARGET_ELEMENT_ID), "width")) / parseFloat(origWidth);
  	fontResize(sizeDiff);
  }
}

function onFontResize(e,args) {
  var sizeDiff = getStyle(document.getElementById(TextResizeDetector.TARGET_ELEMENT_ID), "width") / origWidth;
  fontResize(sizeDiff);
}
function fontResize(sizeDiff)
{
    if(resizableswf){
        var newWidth = (origWidth * parseFloat(sizeDiff))+"px";
        var newHeight = (origHeight * parseFloat(sizeDiff))+"px";
        setStyle(resizableswf, "width", newWidth);
        setStyle(resizableswf, "height", newHeight);
    }
}


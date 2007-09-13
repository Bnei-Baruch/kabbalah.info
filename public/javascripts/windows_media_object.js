function CreateControl(DivID, url, autoStart, width, height, uimode){
  var d = document.getElementById(DivID);
  if (typeof width == "undefined") {
    width = "380";
  }
  if (typeof height == "undefined") {
    height = "356";
  }
  if (typeof uimode == "undefined") {
    uimode = "full";
  }
  d.innerHTML = 
    '<object class="object" id="MediaPlayer" classid="CLSID:6BF52A52-394A-11D3-B153-00C04F79FAA6" standby="Loading Windows Media Player components..." type="application/x-oleobject" width="'+width+'" height="'+height+'"> <param name="url" value="' + url + '" /> <param name="autostart" value="' +autoStart+'" /> <param name="uimode" value="'+uimode+'" /> <param name="stretchToFit" value="true" /> <embed src="' + url + '" type="application/x-mplayer2" pluginspage="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=6,4,7,1112" width="'+width+'" height="'+height+'" autostart="'+autoStart+'" uimode="'+uimode+'" /> </object>';
}

function fullScreen(player){
   if (player.playState == 3) {
      alert(fullScreenMessageNote);
      player.fullScreen = true
   } else {
      alert(fullScreenMessageErr);
   }
}

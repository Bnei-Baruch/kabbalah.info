function CreateControl(DivID, url, autoStart){
  var d = document.getElementById(DivID);
  d.innerHTML = 
    '<object class="object" id="MediaPlayer" classid="CLSID:6BF52A52-394A-11D3-B153-00C04F79FAA6" standby="Loading Windows Media Player components..." type="application/x-oleobject" width="380" height="356"> <param name="url" value="' + url + '" /> <param name="autostart" value="1" /> <param name="uimode" value="full" /> <param name="stretchToFit" value="true" /> <embed src="' + url + '" type="application/x-mplayer2" pluginspage="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=6,4,7,1112" width="380" height="356" autostart="' + autoStart +'" uimode="full" /> </object>';
}

function fullScreen(player){
   if (player.playState == 3) {
      alert(fullScreenMessageNote);
      player.fullScreen = true
   } else {
      alert(fullScreenMessageErr);
   }
}

function handlePlayStateChange(NewState){
    d = document.getElementById("fScreen");
    if (!d) return;
    if (NewState == 3){
        d.disabled = false;
    } else {
        d.disabled = true;
    }
}

function handleStatusChange(NewState){
  var player = document.getElementById("MediaPlayer");
  var d = document.getElementById("length");
  if (!d) return;
    //d.innerHTML = player.status;
}

intvlID=window.setInterval("GetStat()",1000);

function GetStat(){
  var player = document.getElementById("MediaPlayer");
  if (player == null) return;
  var p_state=player.playState;
  if(p_state == 3){
    d = document.getElementById("length");
    d.innerHTML = player.currentMedia.durationString + " / " + player.controls.currentPositionString + "";
  }
}
function handleMediaStateChange(NewState){
// Test whether the new media item is open.
  if (NewState == 13){
  var player = document.getElementById("MediaPlayer");
    // Write the formatted duration string to the DIV region.
    d = document.getElementById("length");
    d.innerHTML = player.currentMedia.durationString;
    d = document.getElementById("fsize");
    d.innerHTML = "(" + (parseInt(player.currentMedia.getItemInfo("FileSize")) / 1024 / 1024).toFixed(2) + "MB)";
  }
}


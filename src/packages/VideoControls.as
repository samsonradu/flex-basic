package packages
{
	public dynamic class VideoControls
	{
		import packages.Settings;
		import flash.display.*;
		import flash.events.*;
		import flash.external.*;
		import mx.controls.Alert;
		import mx.core.FlexGlobals;
		import spark.components.Button;
		import skins.*;		
				
		// controls
		public var toggleFullScreenBtn:Button;		
		
		private var jsCallMethod:String = "eventTrigger"; // external event trigger
		
		public function VideoControls()
		{
			jsCallMethod = Settings.JS_LOG_METHOD;
			initControls();
		}
		
		private function initControls():void
		{
			toggleFullScreenBtn = new Button;
			toggleFullScreenBtn.right = 10;
			toggleFullScreenBtn.top = 10;
			toggleFullScreenBtn.width = 14;
			toggleFullScreenBtn.height = 14;
			toggleFullScreenBtn.setStyle("skinClass", goFullscreenBtnStyle);
			toggleFullScreenBtn.addEventListener(MouseEvent.CLICK, toggleFullScreen);				
		}
		
		public function show():void
		{		
			if(!toggleFullScreenBtn.parent)
				FlexGlobals.topLevelApplication.addElement(toggleFullScreenBtn);			
		}
		
		public function hide():void
		{
			try {
				if (toggleFullScreenBtn.parent)
					FlexGlobals.topLevelApplication.removeElement(toggleFullScreenBtn);
			} 
			catch (error:Error) {
				dispatchResponse("error", error.message);		
			}
		}
		
		//toggle in/out fullscreen
		private function toggleFullScreen(event:MouseEvent):void 
		{
			try {
				switch (FlexGlobals.topLevelApplication.stage.displayState) {
					case StageDisplayState.FULL_SCREEN:
					{
						FlexGlobals.topLevelApplication.stage.displayState = StageDisplayState.NORMAL;
						toggleFullScreenBtn.setStyle("skinClass", goFullscreenBtnStyle);
					}
						break;
					
					default:
					{
						FlexGlobals.topLevelApplication.stage.displayState = StageDisplayState.FULL_SCREEN;
						toggleFullScreenBtn.setStyle("skinClass", goNormalscreenBtnStyle);
					}
						break;
				}
			} catch (err:SecurityError) 
			{
				Alert.show("error no fullscreen");
			}
		}	
		
		// trigger response event
		private function dispatchResponse(dispatchEvent:String, ...params):void
		{
			ExternalInterface.call(jsCallMethod, dispatchEvent, params);
		}	
		
	}	
		
}

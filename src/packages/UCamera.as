package packages
{

	import flash.external.*;
	import flash.media.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.*;
	import mx.controls.*;
	
	public dynamic class UCamera
	{
		public var CamOpen:Boolean = false;
		public var CamObject:Camera;
		public var toggleSound:Boolean = false;
		public var userMicrophone:Microphone = Microphone.getEnhancedMicrophone();
		public var userSound:SoundTransform;
		
		public var cameraWidth:Number  = 0;
		public var cameraHeight:Number = 0;
		public var cameraFps:Number    = 0;

		private var streamPublisher:NetStream;		
	
		
		public function UCamera():void
		{
			if (Camera.names.length > 0) {
				reset();				
			}
			else {
				Alert.show("You do not have a camera attached.");
				dispatchResponse("error", Settings.ERR_HARDWARE_NOCAMERA);
			}
		}
		
		/**
		 * Init camera
		 * 
		 * @return void
		 */
		public function open(name:String = null):void 
		{
			CamObject = Camera.getCamera(name);
			loadSettings(CamObject);
			
			if (CamObject.muted)
				// "remember" checkbox was not checked or user needs to allow camear access
				// open the privacy tab of the security panel, add the remember my option checkbox				
				Security.showSettings(SecurityPanel.PRIVACY);
			else {
				CamOpen = true;											
				// "remember" checkbox was checked, access is already granted						
				CamObject.setMode(cameraWidth, cameraHeight, cameraFps, false);
				CamObject.setQuality(0, Settings.CAMERA_QUALITY);
				CamObject.setKeyFrameInterval(40);		
			}
		}
		
		/**
		 * Close camera
		 * @return void
		 */			
		public function close():void 
		{
			CamOpen = false;
			getStream();
		}		
				
		/**
		 * Reset camera
		 * @return void
		 */			
		public function reset():void 
		{
			close();
			open();	
		}		
		
		/**
		 * Get camera stream
		 * @return Camera
		 */			
		public function getStream():Camera
		{
			if (!CamOpen)
				CamObject = null;					
			return CamObject;
		}	
	
		public function loadSettings(cam: Camera, auto: Boolean = true):void
		{
			cameraWidth  = Settings.CAMERA_MODE_WIDTH;
			cameraHeight = Settings.CAMERA_MODE_HEIGHT;
			cameraFps    = Settings.CAMERA_MODE_FPS;						
		}

		public function dispatchResponse(dispatchEvent:String, message:String):void{
			ExternalInterface.call(Settings.JS_LOG_METHOD, dispatchEvent, message);
		}			
	}
}

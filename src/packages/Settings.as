package packages
{
	public class Settings
	{
		import flash.external.*;	
		
		public static var COMPILED_AT:String = "2014-11-18 11:00:00";
		public static var VERSION:String = "1.0";
		
		public static var JS_CALLBACK_METHOD:String = "eventTrigger"; // external event trigger
		public static var JS_LOG_METHOD:String = "eventTrigger"; // external event trigger
		
		public static const CAMERA_MODE_WIDTH:Number  = 320; // 1024
		public static const CAMERA_MODE_HEIGHT:Number = 240;  // 768
		public static const CAMERA_MODE_FPS:Number    = 20;   // 25
		public static const CAMERA_QUALITY:Number     = 90;   // 100
		
		public static const MINI_WIDTH:Number = 235;
		public static const MINI_HEIGHT:Number = 175;
		
		public static var KEEP_ALIVE_TIMEOUT:int = 20 * 1000; // 1 seconds
		
		public static var APP_NAME:String = 'streamapp';
		public static var STATUS_TYPE_CONNECTION:String = APP_NAME + '.Status.Connection';
		public static var STATUS_TYPE_APPMODE:String = APP_NAME + '.Status.Mode';
		
		public static var ERROR_TYPE_CONNECTION:String = APP_NAME + '.Error.Connection';
		public static var ERROR_TYPE_APPMODE:String = APP_NAME + '.Error.Mode';
		public static var ERROR_TYPE_HARDWADE:String = APP_NAME + '.Error.Hardware';		
		
		public static var ST_CONNECTION_IS_CONNECTED:String = STATUS_TYPE_CONNECTION + '.Connected';
		public static var ST_CONNECTION_IS_DISCONNECTED:String = STATUS_TYPE_CONNECTION + '.Disconnected';
		
		public static var ST_APPMODE_CHANGING:String = STATUS_TYPE_APPMODE + '.Changing';
		public static var ST_APPMODE_CLIENT:String = STATUS_TYPE_APPMODE + '.Client';
		public static var ST_APPMODE_PERFORMER:String = STATUS_TYPE_APPMODE + '.Performer';
		
		public static var ERR_APPMODE_UNKNOWN:String = ERROR_TYPE_APPMODE + '.Unknown';
		public static var ERR_APPMODE_BLANK:String = ERROR_TYPE_APPMODE + '.Blank';
		
		public static var ERR_HARDWARE_NOCAMERA:String = ERROR_TYPE_HARDWADE + '.NoCamera';
		public static var ERR_HARDWARE_MIC:String = ERROR_TYPE_HARDWADE + '.Microphone';		
		
		public function Settings(){}
		
		/**
		 * Log data to external js
		 * 
		 * @param String dispatchEvent is the event/category type of the message
		 * @param String message
		 * 
		 * @return void
		 */
		public static function dispatchResponse(dispatchEvent:String, message:String):void
		{
			ExternalInterface.call(Settings.JS_LOG_METHOD, dispatchEvent, message);
		}		
	
	}
}

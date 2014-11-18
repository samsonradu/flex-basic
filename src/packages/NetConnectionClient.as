package packages
{
	import mx.core.FlexGlobals;	
	
	public class NetConnectionClient
	{
		public function NetConnectionClient(){}
		
		public function onMetaData(info:Object):void {
			trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
		}
		
		public function onBWCheck(... rest):Number 
		{ 
			return 0; 
		}
		
		public function onBWDone(... rest):void 
		{ 
			var p_bw:Number; 
			if (rest.length > 0) p_bw = rest[0]; 
			// your application should do something here 
			// when the bandwidth check is complete 
			trace("bandwidth = " + p_bw + " Kbps."); 
		}
		
		public function setPublisherStatus(publisherStatus:String):String
		{
			FlexGlobals.topLevelApplication.publisherStatus = publisherStatus;;
			return (publisherStatus);
		};		
	}
}

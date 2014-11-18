package packages
{
	import packages.NetConnectionClient;
	import packages.Settings;
    import flash.events.*;
    import flash.events.NetStatusEvent;
    import flash.external.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import mx.core.FlexGlobals;

    public dynamic class FmsConnection
    {
    
        public var nc:NetConnection = new NetConnection();
        public var rcResponder:Responder = new Responder(onResult, onFault); // remote call responder       
               
        
        public function FmsConnection(connection:String, userId:String, sessionId:String, options:Array = null)
        {
            Security.allowDomain("*");
            if (connection && userId && sessionId){                
                // set the connection params
                nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusEventHandler);  // Listener to see if connection is successful
                connect(connection, userId, sessionId, options);
            }
            else
                dispatchResponse("error", "No connection data");
        }
        
        // open connection
        private function connect(connection:String, userId:String, sessionId:String, options:Array):void
        {   
            if (nc)
            {
                nc.client = new NetConnectionClient();  
                nc.objectEncoding = flash.net.ObjectEncoding.AMF3;                  
                nc.connect(connection, userId, sessionId, options);     // Path to FMS Server e.g. rtmp://<hostname>/<application name> AND the <sessionId> for the client passed as a parameter
                nc.call("checkPermission", rcResponder);
            }
            else
                dispatchResponse("error", "No NetConnection. Please reload application.");
        }   
        
        // close connection
        public function disconnect():Boolean
        {
            nc.close();
            nc = null;
            return !isConnected();
        }
        
        // check if connected
        public function isConnected():Boolean
        {
            if (nc && nc.connected) 
                return true;
            else 
                return false;
                            
        }   
        
        // eventHandlers
        private function netStatusEventHandler(e:NetStatusEvent):void
        {   
            dispatchResponse("log", "FmsConnection." + e.info.code);
        
            if ( e.info.code == "NetConnection.Connect.Closed" )
                dispatchResponse("error", "You have been disconnected. Please reload application");
        }
        
        private function dispatchResponse(dispatchEvent:String, message:String):void{
            ExternalInterface.call(Settings.JS_LOG_METHOD, dispatchEvent, message);
        }       
        
        private function onResult(response:Object):void
        {
            FlexGlobals.topLevelApplication.parameters.globalPermissions = response.permission;
        };
        
        
        private function onFault(response:Object):void
        {
            dispatchResponse("error", "error " + response.toString() )            
        };  
    }
}

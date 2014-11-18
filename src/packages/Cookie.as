package packages
{
    import flash.net.SharedObject;
    public class Cookie {
        
        private var _time:Number;   
        private var _name:String;   
        private var _so:SharedObject;
        
        public function Cookie(name:String = "fApp", timeOut:Number=3600) {     
            _name = name;           
            _time = timeOut;            
            _so = SharedObject.getLocal(name, "/" );            
        }   
        
        // clear when timeout;
        public function clearTimeOut():void {   
            var obj:* = _so.data.cookie;    
            if(obj == undefined){       
                return;     
            }
            
            for(var key:String in obj){         
                if(obj[key] == undefined || obj[key].time == undefined || isTimeOut(obj[key].time)){
                    delete obj[key];                
                }               
            }
            _so.data.cookie = obj;
            _so.flush();
        }
        
        // check timeout
        private function isTimeOut(time:Number):Boolean {
            var today:Date = new Date();
            return time + _time * 1000 < today.getTime();
        }
        
        // get timeout;
        public function getTimeOut():Number {
            return _time;
        }
        
        // get cookie name;
        public function getName():String {
            return _name;       
        }
    
        // clear all Cookie value;
        public function clear():void {
            _so.clear();
        }
        
        // add Cookie item( key-value )
        public function put(key:String, value:*):void {
            var today:Date = new Date();
            key = "key_"+key;
            value.time = today.getTime();   
            if(_so.data.cookie == undefined){       
                var obj:Object = {};    
                obj[key] = value;   
                _so.data.cookie = obj;      
            }
            else{               
                _so.data.cookie[key] = value;           
            }           
            _so.flush();            
        }
        
        // remove Cookie item by key;
        public function remove(key:String):void {
            if (isExist(key)) {
                delete _so.data.cookie["key_" + key];
                _so.flush();
            }
        }
        
        // get Cookie item value by key;
        public function get(key:String):Object{
            return isExist(key)?_so.data.cookie["key_"+key]:null;
        }
        
        // check Cookie item exist;
        public function isExist(key:String):Boolean{
            key = "key_" + key;
            return _so.data.cookie != undefined && _so.data.cookie[key] != undefined;
            
        }
        
        public function hasExpired(key:String):Boolean
        {
            key = 'key_' + key;
            var obj:* = _so.data.cookie;
            return isTimeOut(obj[key].time);
        }       
        
    }
    
}

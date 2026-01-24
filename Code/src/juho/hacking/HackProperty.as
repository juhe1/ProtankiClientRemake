package juho.hacking {
   
   public class HackProperty {
      
      public var name:String;
      public var value:*;
      public var type:String;
      public var callBack:Function;
      
      public function HackProperty(_name:String, _value:*, _type:String, _callBack:Function) {
         this.name = _name;
         this.value = _value;
         this.type = _type;
         this.callBack = _callBack;
      }
   
   }
}
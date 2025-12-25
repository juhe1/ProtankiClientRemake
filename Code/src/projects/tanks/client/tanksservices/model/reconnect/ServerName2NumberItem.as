package projects.tanks.client.tanksservices.model.reconnect
{
   public class ServerName2NumberItem
   {
      
      private var _lang:String;
      
      private var _nameTemplate:String;
      
      private var _prefix:String;
      
      private var _shift:int;
      
      public function ServerName2NumberItem(param1:String = null, param2:String = null, param3:String = null, param4:int = 0)
      {
         super();
         this._lang = param1;
         this._nameTemplate = param2;
         this._prefix = param3;
         this._shift = param4;
      }
      
      public function get lang() : String
      {
         return this._lang;
      }
      
      public function set lang(param1:String) : void
      {
         this._lang = param1;
      }
      
      public function get nameTemplate() : String
      {
         return this._nameTemplate;
      }
      
      public function set nameTemplate(param1:String) : void
      {
         this._nameTemplate = param1;
      }
      
      public function get prefix() : String
      {
         return this._prefix;
      }
      
      public function set prefix(param1:String) : void
      {
         this._prefix = param1;
      }
      
      public function get shift() : int
      {
         return this._shift;
      }
      
      public function set shift(param1:int) : void
      {
         this._shift = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ServerName2NumberItem [";
         _loc1_ += "lang = " + this.lang + " ";
         _loc1_ += "nameTemplate = " + this.nameTemplate + " ";
         _loc1_ += "prefix = " + this.prefix + " ";
         _loc1_ += "shift = " + this.shift + " ";
         return _loc1_ + "]";
      }
   }
}


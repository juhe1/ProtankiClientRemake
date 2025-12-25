package projects.tanks.client.chat.types
{
   public class ChatMessage
   {
      private var _links:SetOfString;
      
      private var _sourceUserStatus:UserStatus;
      
      private var _system:Boolean;
      
      private var _targetUserStatus:UserStatus;
      
      private var _text:String;
      
      private var _warning:Boolean;
      
      public function ChatMessage(param1:SetOfString = null, param2:UserStatus = null, param3:Boolean = false, param4:UserStatus = null, param5:String = null, param6:Boolean = false)
      {
         super();
         this._links = param1;
         this._sourceUserStatus = param2;
         this._system = param3;
         this._targetUserStatus = param4;
         this._text = param5;
         this._warning = param6;
      }
      
      public function get links() : SetOfString
      {
         return this._links;
      }
      
      public function set links(param1:SetOfString) : void
      {
         this._links = param1;
      }
      
      public function get sourceUserStatus() : UserStatus
      {
         return this._sourceUserStatus;
      }
      
      public function set sourceUserStatus(param1:UserStatus) : void
      {
         this._sourceUserStatus = param1;
      }
      
      public function get system() : Boolean
      {
         return this._system;
      }
      
      public function set system(param1:Boolean) : void
      {
         this._system = param1;
      }
      
      public function get targetUserStatus() : UserStatus
      {
         return this._targetUserStatus;
      }
      
      public function set targetUserStatus(param1:UserStatus) : void
      {
         this._targetUserStatus = param1;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         this._text = param1;
      }
      
      public function get warning() : Boolean
      {
         return this._warning;
      }
      
      public function set warning(param1:Boolean) : void
      {
         this._warning = param1;
      }
      
      public function toString() : String
      {
         return "";
      }
   }
}

import flash.utils.Dictionary;

class SetOfString
{
   private var _dictionary:Dictionary = new Dictionary();
   
   public function SetOfString()
   {
      super();
   }
   
   public function add(param1:String) : void
   {
      this._dictionary[param1] = true;
   }
   
   public function contains(param1:String) : Boolean
   {
      return this._dictionary[param1];
   }
   
   public function remove(param1:String) : Boolean
   {
      var _loc2_:Boolean = Boolean(this.contains(param1));
      if(_loc2_)
      {
         delete this._dictionary[param1];
      }
      return _loc2_;
   }
   
   public function get dictionary() : Dictionary
   {
      return this._dictionary;
   }
}

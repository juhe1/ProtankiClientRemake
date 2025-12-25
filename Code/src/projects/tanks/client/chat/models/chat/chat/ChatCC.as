package projects.tanks.client.chat.models.chat.chat
{
   import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;
   
   public class ChatCC
   {
      private var newname_11143__END:Boolean;
      
      private var newname_11144__END:Boolean;
      
      private var newname_11145__END:int;
      
      private var newname_11146__END:Boolean;
      
      private var newname_6656__END:ChatModeratorLevel;
      
      private var newname_11147__END:String;
      
      private var newname_11148__END:Vector.<String>;
      
      private var newname_11149__END:int;
      
      private var newname_11150__END:int;
      
      private var newname_11151__END:Boolean;
      
      private var newname_11152__END:String;
      
      private var newname_11153__END:Boolean;
      
      private var newname_11154__END:Boolean;
      
      public function ChatCC(param1:Boolean = false, param2:Boolean = false, param3:int = 0, param4:Boolean = false, param5:ChatModeratorLevel = null, param6:String = null, param7:Vector.<String> = null, param8:int = 0, param9:int = 0, param10:Boolean = false, param11:String = null, param12:Boolean = false, param13:Boolean = false)
      {
         super();
         this.newname_11143__END = param1;
         this.newname_11144__END = param2;
         this.newname_11145__END = param3;
         this.newname_11146__END = param4;
         this.newname_6656__END = param5;
         this.newname_11147__END = param6;
         this.newname_11148__END = param7;
         this.newname_11149__END = param8;
         this.newname_11150__END = param9;
         this.newname_11151__END = param10;
         this.newname_11152__END = param11;
         this.newname_11153__END = param12;
         this.newname_11154__END = param13;
      }
      
      public function get admin() : Boolean
      {
         return this.newname_11143__END;
      }
      
      public function set admin(param1:Boolean) : void
      {
         this.newname_11143__END = param1;
      }
      
      public function get antifloodEnabled() : Boolean
      {
         return this.newname_11144__END;
      }
      
      public function set antifloodEnabled(param1:Boolean) : void
      {
         this.newname_11144__END = param1;
      }
      
      public function get bufferSize() : int
      {
         return this.newname_11145__END;
      }
      
      public function set bufferSize(param1:int) : void
      {
         this.newname_11145__END = param1;
      }
      
      public function get chatEnabled() : Boolean
      {
         return this.newname_11146__END;
      }
      
      public function set chatEnabled(param1:Boolean) : void
      {
         this.newname_11146__END = param1;
      }
      
      public function get chatModeratorLevel() : ChatModeratorLevel
      {
         return this.newname_6656__END;
      }
      
      public function set chatModeratorLevel(param1:ChatModeratorLevel) : void
      {
         this.newname_6656__END = param1;
      }
      
      public function get chatStubText() : String
      {
         return this.newname_11147__END;
      }
      
      public function set chatStubText(param1:String) : void
      {
         this.newname_11147__END = param1;
      }
      
      public function get linksWhiteList() : Vector.<String>
      {
         return this.newname_11148__END;
      }
      
      public function set linksWhiteList(param1:Vector.<String>) : void
      {
         this.newname_11148__END = param1;
      }
      
      public function get minChar() : int
      {
         return this.newname_11149__END;
      }
      
      public function set minChar(param1:int) : void
      {
         this.newname_11149__END = param1;
      }
      
      public function get minWord() : int
      {
         return this.newname_11150__END;
      }
      
      public function set minWord(param1:int) : void
      {
         this.newname_11150__END = param1;
      }
      
      public function get privateMessagesEnabled() : Boolean
      {
         return this.newname_11151__END;
      }
      
      public function set privateMessagesEnabled(param1:Boolean) : void
      {
         this.newname_11151__END = param1;
      }
      
      public function get selfName() : String
      {
         return this.newname_11152__END;
      }
      
      public function set selfName(param1:String) : void
      {
         this.newname_11152__END = param1;
      }
      
      public function get showLinks() : Boolean
      {
         return this.newname_11153__END;
      }
      
      public function set showLinks(param1:Boolean) : void
      {
         this.newname_11153__END = param1;
      }
      
      public function get typingSpeedAntifloodEnabled() : Boolean
      {
         return this.newname_11154__END;
      }
      
      public function set typingSpeedAntifloodEnabled(param1:Boolean) : void
      {
         this.newname_11154__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ChatCC [";
         _loc1_ += "admin = " + this.newname_11143__END + " ";
         _loc1_ += "antifloodEnabled = " + this.newname_11144__END + " ";
         _loc1_ += "bufferSize = " + this.newname_11145__END + " ";
         _loc1_ += "chatEnabled = " + this.newname_11146__END + " ";
         _loc1_ += "chatModeratorLevel = " + this.newname_6656__END + " ";
         _loc1_ += "chatStubText = " + this.newname_11147__END + " ";
         _loc1_ += "linksWhiteList = " + this.newname_11148__END + " ";
         _loc1_ += "minChar = " + this.newname_11149__END + " ";
         _loc1_ += "minWord = " + this.newname_11150__END + " ";
         _loc1_ += "privateMessagesEnabled = " + this.newname_11151__END + " ";
         _loc1_ += "selfName = " + this.newname_11152__END + " ";
         _loc1_ += "showLinks = " + this.newname_11153__END + " ";
         _loc1_ += "typingSpeedAntifloodEnabled = " + this.newname_11154__END + " ";
         return _loc1_ + "]";
      }
   }
}


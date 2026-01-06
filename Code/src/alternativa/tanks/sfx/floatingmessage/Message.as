package alternativa.tanks.sfx.floatingmessage
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class Message extends TextField
   {
      
      private static var poolSize:int;
      
      private static const DEFAULT_TEXT_FORMAT:TextFormat = new TextFormat("Tahoma",12);
      
      private static var pool:Vector.<Message> = new Vector.<Message>();
      
      public var lifeTime:int;
      
      public function Message()
      {
         super();
         autoSize = TextFieldAutoSize.LEFT;
         defaultTextFormat = DEFAULT_TEXT_FORMAT;
         background = true;
         backgroundColor = 0;
      }
      
      public static function create() : Message
      {
         if(poolSize == 0)
         {
            return new Message();
         }
         return pool[--poolSize];
      }
      
      public function set color(param1:uint) : void
      {
         var _loc2_:TextFormat = defaultTextFormat;
         _loc2_.color = param1;
         defaultTextFormat = _loc2_;
      }
      
      public function destroy() : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
         text = "";
         pool[poolSize++] = this;
      }
   }
}


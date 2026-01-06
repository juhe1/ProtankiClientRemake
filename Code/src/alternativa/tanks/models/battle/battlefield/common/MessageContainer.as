package alternativa.tanks.models.battle.battlefield.common
{
   import flash.display.Sprite;
   
   public class MessageContainer extends Sprite
   {
      
      protected var messageSpacing:int = 3;
      
      protected var container:Sprite = new Sprite();
      
      protected var shift:Number;
      
      public function MessageContainer()
      {
         super();
         addChild(this.container);
      }
      
      public function removeFirstMessage(param1:Boolean = false) : MessageLine
      {
         var _loc2_:int = this.container.numChildren;
         if(_loc2_ == 0)
         {
            return null;
         }
         var _loc3_:MessageLine = MessageLine(this.container.getChildAt(0));
         this.shift = int(_loc3_.height + _loc3_.y + this.messageSpacing);
         this.container.removeChild(_loc3_);
         _loc2_--;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            this.container.getChildAt(_loc4_).y = this.container.getChildAt(_loc4_).y - this.shift;
            _loc4_++;
         }
         return _loc3_;
      }
      
      protected function pushFront(param1:MessageLine) : void
      {
         param1.y = 0;
         param1.alpha = 1;
         this.container.addChildAt(param1,0);
         var _loc2_:int = this.container.numChildren;
         var _loc3_:int = 1;
         while(_loc3_ < _loc2_)
         {
            this.container.getChildAt(_loc3_).y = this.container.getChildAt(_loc3_).y + int(param1.height + this.messageSpacing);
            _loc3_++;
         }
      }
      
      protected function pushBack(param1:MessageLine) : void
      {
         param1.y = this.container.numChildren > 0 ? int(this.container.height + this.messageSpacing) : 0;
         this.container.addChild(param1);
      }
   }
}


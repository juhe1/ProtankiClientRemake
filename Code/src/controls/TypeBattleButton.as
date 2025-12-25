package controls
{
   import controls.base.BigButtonBase;
   import controls.buttons.ButtonStates;
   
   public class TypeBattleButton extends BigButtonBase
   {
      
      private var _data:Object;
      
      public function TypeBattleButton()
      {
         super();
         _label.multiline = true;
         _label.wordWrap = true;
         _label.height = 45;
      }
      
      override protected function onDisable() : void
      {
         super.onDisable();
         setState(ButtonStates.DOWN);
         this.align();
      }
      
      override protected function onEnable() : void
      {
         super.onEnable();
         this.align();
      }
      
      override public function set label(param1:String) : void
      {
         super.label = param1;
         this.align();
      }
      
      override protected function onStateChanged() : void
      {
         super.onStateChanged();
         this.align();
      }
      
      private function align() : void
      {
         var _loc1_:int = getState() == ButtonStates.DOWN ? 1 : 0;
         _label.y = int(25 - _label.textHeight / 2) + _loc1_;
         _info.y = 24 + _loc1_;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
      }
   }
}


package forms.payment
{
   import controls.Money;
   import controls.statassets.StatLineBackgroundNormal;
   import controls.statassets.StatLineBackgroundSelected;
   import controls.statassets.StatLineNormal;
   import fl.controls.List;
   import fl.data.DataProvider;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import utils.ScrollStyleUtils;
   
   public class PaymentList extends Sprite
   {
      
      private static var _withSMSText:Boolean = false;
      
      private var list:List = new List();
      
      private var header:PaymentListHeader = new PaymentListHeader();
      
      private var dp:DataProvider = new DataProvider();
      
      private var _width:int = 100;
      
      private var _height:int = 100;
      
      public function PaymentList()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.ConfigUI);
         ScrollStyleUtils.setGreenStyle(this.list);
      }
      
      private static function setBackground(param1:int) : BitmapData
      {
         var _loc2_:Sprite = new Sprite();
         var _loc3_:StatLineNormal = new StatLineNormal();
         var _loc4_:StatLineNormal = new StatLineNormal();
         var _loc5_:StatLineNormal = new StatLineNormal();
         var _loc6_:StatLineNormal = new StatLineNormal();
         var _loc7_:BitmapData = new BitmapData(param1 > 0 ? param1 : 1,23,true,0);
         var _loc8_:int = _withSMSText ? 80 : int((param1 - 70) / 2);
         _loc3_.height = _loc4_.height = _loc5_.height = _loc6_.height = 21;
         _loc2_.addChild(_loc3_);
         _loc2_.addChild(_loc5_);
         _loc2_.addChild(_loc6_);
         _loc3_.width = 70;
         _loc5_.x = 72;
         if(_withSMSText)
         {
            _loc2_.addChild(_loc4_);
            _loc4_.x = 72;
            _loc4_.width = param1 - 210;
            _loc5_.x = 74 + _loc4_.width;
         }
         _loc5_.width = _loc8_;
         _loc6_.x = _loc5_.x + _loc5_.width + 2;
         _loc6_.width = int(param1 - _loc6_.x - 3);
         _loc7_.draw(_loc2_);
         return _loc7_;
      }
      
      public function set withSMSText(param1:Boolean) : void
      {
         _withSMSText = param1;
         this.header.withSMSText = param1;
         this.dp.invalidate();
      }
      
      public function addItem(param1:String, param2:String, param3:String, param4:int, param5:String = "") : void
      {
         var _loc6_:Object = new Object();
         _loc6_.number = param1;
         _loc6_.cost = String(param2) + " " + param3;
         _loc6_.crystals = Money.numToString(param4,false);
         _loc6_.smsText = param5;
         this.dp.addItem(_loc6_);
         this.header.width = this.list.verticalScrollBar.visible ? this._width - 15 : this._width;
         StatLineBackgroundNormal.bg = new Bitmap(setBackground(this.list.verticalScrollBar.visible ? this._width - 15 : this._width));
         StatLineBackgroundSelected.bg = new Bitmap(setBackground(this.list.verticalScrollBar.visible ? this._width - 15 : this._width));
         this.dp.invalidate();
      }
      
      public function clear() : void
      {
         this.dp.removeAll();
      }
      
      private function ConfigUI(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.ConfigUI);
         this.list.rowHeight = 22;
         this.list.setStyle("cellRenderer",PaymentListRenderer);
         this.list.focusEnabled = false;
         this.list.dataProvider = this.dp;
         ScrollStyleUtils.setGreenStyle(this.list);
         addChild(this.header);
         addChild(this.list);
         this.list.y = 20;
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = int(param1);
         this.list.width = this._width;
         this.header.width = this.list.verticalScrollBar.visible ? this._width - 15 : this._width;
         StatLineBackgroundNormal.bg = new Bitmap(setBackground(this.list.verticalScrollBar.visible ? this._width - 15 : this._width));
         StatLineBackgroundSelected.bg = new Bitmap(setBackground(this.list.verticalScrollBar.visible ? this._width - 15 : this._width));
         this.dp.invalidate();
      }
      
      override public function set height(param1:Number) : void
      {
         this._height = int(param1);
         this.list.height = this._height - 20;
      }
   }
}


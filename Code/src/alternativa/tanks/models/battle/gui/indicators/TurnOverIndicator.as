package alternativa.tanks.models.battle.gui.indicators
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.services.battlegui.BattleGUIService;
   import alternativa.utils.removeDisplayObject;
   import controls.Label;
   import controls.statassets.BlackRoundRect;
   import flash.display.Bitmap;
   import flash.events.Event;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class TurnOverIndicator extends BlackRoundRect
   {
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var battleGUIService:BattleGUIService;
      
      [Inject]
      public static var localeService:ILocaleService;
      
      private static const turnOverIconClass:Class = TurnOverIndicator_turnOverIconClass;
      
      private var _show:Boolean;
      
      public function TurnOverIndicator()
      {
         var _loc8_:int = 0;
         var _loc10_:Label = null;
         var _loc11_:Bitmap = null;
         super();
         var _loc1_:String = localeService.getText(TanksLocale.TEXT_TURNOVER_HINT_1);
         var _loc2_:String = localeService.getText(TanksLocale.TEXT_TURNOVER_HINT_2);
         var _loc3_:int = 30;
         var _loc4_:int = 30;
         var _loc5_:int = 5;
         var _loc6_:int = 16;
         var _loc7_:Bitmap = new Bitmap(new turnOverIconClass().bitmapData);
         addChild(_loc7_);
         _loc7_.y = _loc3_;
         _loc8_ = _loc7_.y + _loc7_.height + 2 * _loc5_;
         var _loc9_:Label = new Label();
         _loc9_.size = _loc6_;
         _loc9_.text = _loc1_;
         _loc9_.y = _loc8_;
         addChild(_loc9_);
         width = _loc9_.textWidth;
         _loc8_ += _loc9_.height + _loc5_;
         _loc10_ = new Label();
         _loc10_.size = _loc6_;
         _loc10_.text = _loc2_;
         _loc10_.y = _loc8_;
         addChild(_loc10_);
         if(width < _loc10_.textWidth)
         {
            width = _loc10_.textWidth;
         }
         _loc8_ += _loc10_.height + 2 * _loc5_;
         _loc11_ = new Bitmap(localeService.getImage(TanksLocale.IMAGE_TURNOVER_HINT_DELETE_BUTTON));
         _loc11_.y = _loc8_;
         addChild(_loc11_);
         if(width < _loc11_.width)
         {
            width = _loc11_.width;
         }
         _loc8_ += _loc11_.height;
         width += 2 * _loc4_;
         _loc7_.x = width - _loc7_.width >> 1;
         _loc11_.x = width - _loc11_.width >> 1;
         _loc9_.x = width - _loc9_.width >> 1;
         _loc10_.x = width - _loc10_.width >> 1;
         height = _loc8_ + _loc3_;
         this._show = false;
      }
      
      public function show() : void
      {
         if(this._show)
         {
            return;
         }
         this._show = true;
         battleGUIService.getViewportContainer().addChild(this);
         this.onResize();
         display.stage.addEventListener(Event.RESIZE,this.onResize);
      }
      
      public function hide() : void
      {
         if(!this._show)
         {
            return;
         }
         this._show = false;
         removeDisplayObject(this);
         display.stage.removeEventListener(Event.RESIZE,this.onResize);
      }
      
      private function onResize(param1:Event = null) : void
      {
         this.x = display.stage.stageWidth - this.width >> 1;
         this.y = display.stage.stageHeight - this.height >> 1;
      }
      
      public function destroy() : void
      {
         this.hide();
      }
   }
}


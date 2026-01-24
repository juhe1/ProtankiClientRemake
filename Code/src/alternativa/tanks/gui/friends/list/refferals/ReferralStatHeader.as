package alternativa.tanks.gui.friends.list.refferals
{
   import alternativa.osgi.service.locale.ILocaleService;
   import controls.statassets.*;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import forms.events.StatListEvent;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class ReferralStatHeader extends Sprite
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      protected var tabs:Vector.<Number>;
      
      protected var headers:Vector.<String>;
      
      protected var _currentSort:int = 1;
      
      protected var _oldSort:int = 1;
      
      protected var _width:int = 800;
      
      public function ReferralStatHeader()
      {
         var _loc2_:StatHeaderButton = null;
         this.tabs = new Vector.<Number>();
         super();
         this.headers = Vector.<String>([localeService.getText(TanksLocale.TEXT_REFERAL_STATISTICS_HEADER_CALLSIGN),localeService.getText(TanksLocale.TEXT_REFERAL_STATISTICS_HEADER_INCOME)]);
         var _loc1_:int = 0;
         while(_loc1_ < 2)
         {
            _loc2_ = new StatHeaderButton(_loc1_ == 1);
            _loc2_.label = this.headers[_loc1_];
            _loc2_.height = 18;
            _loc2_.numSort = _loc1_;
            _loc2_.addEventListener(MouseEvent.CLICK,this.changeSort);
            addChild(_loc2_);
            _loc1_++;
         }
         this.draw();
      }
      
      protected function draw() : void
      {
         var _loc1_:StatHeaderButton = null;
         this.tabs = Vector.<Number>([0,this._width - 120,this._width - 1]);
         var _loc2_:int = 0;
         while(_loc2_ < 2)
         {
            _loc1_ = getChildAt(_loc2_) as StatHeaderButton;
            _loc1_.width = this.tabs[_loc2_ + 1] - this.tabs[_loc2_] - 2;
            _loc1_.x = this.tabs[_loc2_];
            _loc1_.selected = _loc2_ == this._currentSort;
            _loc2_++;
         }
      }
      
      protected function changeSort(param1:MouseEvent) : void
      {
         var _loc2_:StatHeaderButton = param1.currentTarget as StatHeaderButton;
         this._currentSort = _loc2_.numSort;
         if(this._currentSort != this._oldSort)
         {
            this.draw();
            dispatchEvent(new StatListEvent(this._currentSort));
            this._oldSort = this._currentSort;
         }
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = Math.floor(param1);
         this.draw();
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      public function setDefaultSort() : void
      {
         this._oldSort = 1;
      }
   }
}


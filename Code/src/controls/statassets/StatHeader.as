package controls.statassets
{
   import alternativa.osgi.service.locale.ILocaleService;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import forms.events.StatListEvent;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class StatHeader extends Sprite
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      protected var tabs:Vector.<Number>;
      
      protected var headers:Vector.<String>;
      
      protected var _currentSort:int = 8;
      
      protected var _oldSort:int = 8;
      
      protected var _width:int = 800;
      
      public function StatHeader()
      {
         var _loc1_:StatHeaderButton = null;
         var _loc2_:int = 0;
         this.tabs = new Vector.<Number>();
         super();
         this.headers = Vector.<String>([localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_NUMBER),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_RANK),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_CALLSIGN),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_SCORE),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_KILLS),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_DEATHS),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_RATIO),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_WEALTH),localeService.getText(TanksLocale.TEXT_STATISTICS_HEADER_RATING)]);
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            _loc1_ = new StatHeaderButton(_loc2_ < 1 || _loc2_ > 2);
            _loc1_.label = this.headers[_loc2_];
            _loc1_.height = 18;
            _loc1_.numSort = _loc2_;
            addChild(_loc1_);
            if(_loc2_ > 0)
            {
               _loc1_.addEventListener(MouseEvent.CLICK,this.changeSort);
            }
            _loc2_++;
         }
         this.draw();
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = Math.floor(param1);
         this.draw();
      }
      
      protected function draw() : void
      {
         var _loc1_:StatHeaderButton = null;
         var _loc2_:int = int(this._width - 365);
         this.tabs = Vector.<Number>([0,55,180,_loc2_,_loc2_ + 60,_loc2_ + 130,_loc2_ + 180,_loc2_ + 220,_loc2_ + 285,this._width - 1]);
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            _loc1_ = getChildAt(_loc3_) as StatHeaderButton;
            _loc1_.width = this.tabs[_loc3_ + 1] - this.tabs[_loc3_] - 2;
            _loc1_.x = this.tabs[_loc3_];
            _loc1_.selected = _loc3_ == this._currentSort;
            _loc3_++;
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
   }
}


package alternativa.tanks.gui.news
{
   import alternativa.osgi.service.locale.ILocaleService;
   import controls.TankWindowInner;
   import controls.base.DefaultButtonBase;
   import controls.base.LabelBase;
   import fl.containers.ScrollPane;
   import fl.controls.ScrollPolicy;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import forms.ColorConstants;
   import forms.TankWindowWithHeader;
   import projects.tanks.client.chat.models.news.showing.NewsItemData;
   import projects.tanks.clients.flash.commons.services.datetime.DateFormatter;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
   import utils.ScrollStyleUtils;
   
   public class NewsAlertWindow extends DialogWindow
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private static const SCROLL_SPEED_MULTIPLIER:int = 3;
      
      private static const WIDTH:int = 500;
      
      private var scrollPane:ScrollPane = new ScrollPane();
      
      private var scrollContainer:Sprite = new Sprite();
      
      private var window:TankWindowWithHeader;
      
      private var closeButton:DefaultButtonBase;
      
      private var innerWidth:int;
      
      public function NewsAlertWindow(param1:Vector.<NewsItemData>)
      {
         super();
         this.innerWidth = WIDTH - 2 * 10;
         this.addNewsItems(param1);
         var _loc2_:int = this.scrollContainer.height < 300 ? int(this.scrollContainer.height + 100) : 400;
         this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_NEWS,WIDTH,_loc2_);
         addChild(this.window);
         var _loc3_:TankWindowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
         _loc3_.x = 10;
         _loc3_.y = 10;
         _loc3_.height = this.window.height - 50 - 2 * 10;
         _loc3_.width = this.window.width - 2 * 10;
         addChild(_loc3_);
         ScrollStyleUtils.setGreenStyle(this.scrollPane);
         this.scrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.scrollPane.verticalScrollPolicy = ScrollPolicy.AUTO;
         this.scrollPane.source = this.scrollContainer;
         this.scrollPane.x = 10;
         this.scrollPane.y = 10;
         this.scrollPane.focusEnabled = false;
         this.scrollPane.setSize(_loc3_.width - 10,_loc3_.height - 2 * 10);
         this.scrollPane.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,true);
         this.scrollPane.update();
         _loc3_.addChild(this.scrollPane);
         this.scrollPane.update();
         this.closeButton = new DefaultButtonBase();
         this.closeButton.label = localeService.getText(TanksLocale.TEXT_CLOSE_LABEL);
         this.closeButton.x = (this.window.width - this.closeButton.width) / 2;
         this.closeButton.y = this.window.height - this.closeButton.height - 20;
         this.closeButton.addEventListener(MouseEvent.CLICK,this.onClickCancel);
         addChild(this.closeButton);
      }
      
      private function onClickCancel(param1:MouseEvent = null) : void
      {
         this.destroy();
         dialogService.removeDialog(this);
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         param1.delta *= SCROLL_SPEED_MULTIPLIER;
      }
      
      private function createNewsItem(param1:NewsItemData) : NewsItem
      {
         var _loc2_:NewsItem = new NewsItem(param1,null,0);
         _loc2_.x = -4;
         return _loc2_;
      }
      
      private function addNewsItems(param1:Vector.<NewsItemData>) : void
      {
         var _loc4_:NewsItemData = null;
         var _loc5_:Sprite = null;
         var _loc6_:NewsItem = null;
         var _loc7_:String = null;
         var _loc8_:LabelBase = null;
         var _loc2_:int = 0;
         var _loc3_:String = "";
         for each(_loc4_ in param1)
         {
            _loc6_ = this.createNewsItem(_loc4_);
            _loc7_ = this.getDateString(_loc4_.dateInSeconds);
            if(_loc3_ != _loc7_)
            {
               _loc3_ = _loc7_;
               _loc8_ = new LabelBase();
               _loc8_.htmlText = _loc3_;
               _loc8_.textColor = ColorConstants.NEWS_DATE;
               this.scrollContainer.addChild(_loc8_);
               _loc8_.x = this.innerWidth - _loc8_.textWidth - 20 >> 1;
               _loc8_.y = _loc2_;
               _loc2_ += 10;
            }
            _loc6_.y = _loc2_;
            _loc6_.resize(this.innerWidth - 20);
            this.scrollContainer.addChild(_loc6_);
            _loc2_ = _loc6_.y + _loc6_.height + 10;
         }
         _loc5_ = new Sprite();
         _loc5_.graphics.beginFill(0,0);
         _loc5_.graphics.drawRect(0,0,10,20);
         _loc5_.graphics.endFill();
         _loc5_.y = _loc2_;
         this.scrollContainer.addChild(_loc5_);
      }
      
      private function getDateString(param1:int) : String
      {
         var _loc2_:Date = new Date();
         _loc2_.setTime(param1 * 1000);
         return DateFormatter.formatDateToLocalized(_loc2_);
      }
      
      override protected function cancelKeyPressed() : void
      {
         this.onClickCancel();
      }
      
      override protected function confirmationKeyPressed() : void
      {
         this.onClickCancel();
      }
      
      override public function get height() : Number
      {
         return this.window.height;
      }
      
      override public function get width() : Number
      {
         return this.window.width;
      }
      
      private function destroy() : void
      {
         var _loc2_:NewsItem = null;
         this.scrollPane.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this.closeButton.removeEventListener(MouseEvent.CLICK,this.onClickCancel);
         var _loc1_:int = 0;
         while(_loc1_ < this.scrollContainer.numChildren)
         {
            _loc2_ = this.scrollContainer.getChildAt(_loc1_) as NewsItem;
            if(_loc2_ != null)
            {
               _loc2_.destroy();
            }
            _loc1_++;
         }
      }
   }
}


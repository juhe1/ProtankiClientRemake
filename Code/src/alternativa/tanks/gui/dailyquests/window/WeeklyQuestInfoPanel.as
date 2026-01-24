package alternativa.tanks.gui.dailyquests.window
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.effects.BlinkEffect;
   import controls.TankWindowInner;
   import controls.labels.MouseDisabledLabel;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import projects.tanks.client.panel.model.weeklyquest.profile.WeeklyQuestDescription;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class WeeklyQuestInfoPanel extends Sprite
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private static const leftProgressResource:Class = WeeklyQuestInfoPanel_leftProgressResource;
      
      private static const centerProgressResource:Class = WeeklyQuestInfoPanel_centerProgressResource;
      
      private static const MIX_WIDTH_FOR_TEXT:int = 570;
      
      public static const HEIGHT:int = 50;
      
      private static const DAYS_IN_WEEK:int = 7;
      
      private static const SPACE:int = 5;
      
      private static const BIG_SPACE:int = 5;
      
      private static const IMAGE_WIDTH:int = 44;
      
      private var leftProgressPart:Bitmap = new Bitmap(new leftProgressResource().bitmapData);
      
      private var centerProgressPart:Bitmap = new Bitmap(new centerProgressResource().bitmapData);
      
      private var progressBackground:TankWindowInner;
      
      private var completedQuestsBitmap:Bitmap = new Bitmap();
      
      private var currentQuestBitmap:Bitmap = new Bitmap();
      
      private var weeklyQuestHintLabel:MouseDisabledLabel = new MouseDisabledLabel();
      
      private var currentQuestStreak:int;
      
      private var isQuestDoneForToday:Boolean;
      
      private var questImage:Bitmap = new Bitmap();
      
      private var rewardImage:Bitmap = new Bitmap();
      
      private var blinkEffect:BlinkEffect = new BlinkEffect(0.3,0.6);
      
      private var panelWidth:int;
      
      public function WeeklyQuestInfoPanel()
      {
         super();
      }
      
      public function init(param1:WeeklyQuestDescription) : void
      {
         this.currentQuestStreak = param1.currentQuestStreak;
         this.isQuestDoneForToday = param1.doneForToday;
         this.initImages(param1);
      }
      
      private function initImages(param1:WeeklyQuestDescription) : void
      {
         this.questImage.bitmapData = param1.questImage.data;
         this.questImage.x = 0;
         this.questImage.y = SPACE + 4;
         addChild(this.questImage);
         this.rewardImage.bitmapData = param1.rewardImage.data;
         this.rewardImage.x = this.panelWidth - SPACE;
         this.rewardImage.y = 2 * SPACE + 4;
         addChild(this.rewardImage);
      }
      
      public function redraw(param1:int) : void
      {
         this.panelWidth = param1 - 2 * IMAGE_WIDTH - 2 * BIG_SPACE;
         this.redrawPanel();
      }
      
      public function showQuestDoneForToday(param1:int) : void
      {
         if(!this.isQuestDoneForToday)
         {
            ++this.currentQuestStreak;
            this.isQuestDoneForToday = true;
         }
         this.redraw(param1);
      }
      
      private function redrawPanel() : void
      {
         this.redrawImages();
         this.redrawInner();
         this.redrawQuests();
         this.redrawLabel();
      }
      
      private function redrawLabel() : void
      {
         this.weeklyQuestHintLabel.visible = this.panelWidth > MIX_WIDTH_FOR_TEXT;
      }
      
      private function redrawImages() : void
      {
         this.rewardImage.x = this.panelWidth + IMAGE_WIDTH + 2 * BIG_SPACE;
      }
      
      private function redrawInner() : void
      {
         if(this.progressBackground == null)
         {
            this.progressBackground = new TankWindowInner(this.panelWidth,HEIGHT,TankWindowInner.GREEN);
            this.progressBackground.x = IMAGE_WIDTH + BIG_SPACE;
            this.progressBackground.y = SPACE;
            addChild(this.progressBackground);
            this.completedQuestsBitmap.x = IMAGE_WIDTH + BIG_SPACE + 1;
            this.completedQuestsBitmap.y = SPACE + 1;
            this.completedQuestsBitmap.blendMode = BlendMode.OVERLAY;
            addChild(this.completedQuestsBitmap);
            this.currentQuestBitmap.y = SPACE + 1;
            this.currentQuestBitmap.blendMode = BlendMode.OVERLAY;
            addChild(this.currentQuestBitmap);
            this.weeklyQuestHintLabel.x = IMAGE_WIDTH + BIG_SPACE + SPACE;
            this.weeklyQuestHintLabel.y = 4 * SPACE;
            this.weeklyQuestHintLabel.text = "Do missions and get bonuses. (or something like that, i don't know what here should be :D)";
            addChild(this.weeklyQuestHintLabel);
         }
         this.progressBackground.width = this.panelWidth;
      }
      
      private function redrawQuests() : void
      {
         var _loc3_:Shape = null;
         var _loc4_:Graphics = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Shape = null;
         var _loc8_:Graphics = null;
         this.blinkEffect.stop();
         var _loc1_:Number = this.panelWidth * 1 / DAYS_IN_WEEK;
         var _loc2_:int = _loc1_ * this.currentQuestStreak;
         if(this.currentQuestStreak != 0)
         {
            this.completedQuestsBitmap.bitmapData = new BitmapData(_loc2_,this.leftProgressPart.height,true,0);
            this.completedQuestsBitmap.bitmapData.draw(this.leftProgressPart);
            if(_loc2_ > this.leftProgressPart.width)
            {
               this.centerProgressPart.width = Math.min(_loc2_ - this.leftProgressPart.width,this.panelWidth - this.leftProgressPart.width * 2) - 2;
               _loc3_ = new Shape();
               _loc4_ = _loc3_.graphics;
               _loc4_.beginBitmapFill(this.centerProgressPart.bitmapData);
               _loc4_.drawRect(this.leftProgressPart.width,0,this.centerProgressPart.width,this.centerProgressPart.height);
               _loc4_.endFill();
               this.completedQuestsBitmap.bitmapData.draw(_loc3_);
            }
            if(this.currentQuestStreak == DAYS_IN_WEEK)
            {
               this.completedQuestsBitmap.bitmapData.draw(this.leftProgressPart,new Matrix(-1,0,0,1,this.panelWidth - 2,0));
            }
         }
         if(!this.isQuestDoneForToday)
         {
            _loc5_ = _loc1_;
            _loc6_ = 0;
            this.currentQuestBitmap.bitmapData = new BitmapData(this.panelWidth - _loc2_,this.leftProgressPart.height,true,0);
            if(this.currentQuestStreak == 0)
            {
               this.currentQuestBitmap.bitmapData.draw(this.leftProgressPart);
               _loc5_ = _loc1_ - this.leftProgressPart.width;
               _loc6_ = this.leftProgressPart.width;
            }
            if(this.currentQuestStreak == 6)
            {
               this.currentQuestBitmap.bitmapData.draw(this.leftProgressPart,new Matrix(-1,0,0,1,this.panelWidth - _loc2_,0));
               _loc5_ = this.panelWidth - _loc2_ - this.leftProgressPart.width;
            }
            this.centerProgressPart.width = _loc5_;
            _loc7_ = new Shape();
            _loc8_ = _loc7_.graphics;
            _loc8_.beginBitmapFill(this.centerProgressPart.bitmapData);
            _loc8_.drawRect(_loc6_,0,this.centerProgressPart.width,this.centerProgressPart.height);
            _loc8_.endFill();
            this.currentQuestBitmap.bitmapData.draw(_loc7_);
            this.currentQuestBitmap.x = this.completedQuestsBitmap.x + this.completedQuestsBitmap.width - (this.currentQuestStreak == 0 ? 0 : 2);
            this.blinkEffect.start(this.currentQuestBitmap);
         }
         else
         {
            this.currentQuestBitmap.visible = false;
         }
      }
   }
}


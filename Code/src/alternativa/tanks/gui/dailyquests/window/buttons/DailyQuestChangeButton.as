package alternativa.tanks.gui.dailyquests.window.buttons
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.service.money.IMoneyListener;
   import alternativa.tanks.service.money.IMoneyService;
   import assets.Diamond;
   import controls.Money;
   import controls.base.ThreeLineBigButton;
   import controls.labels.MouseDisabledLabel;
   import flash.display.Sprite;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class DailyQuestChangeButton extends ThreeLineBigButton implements IMoneyListener
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var moneyService:IMoneyService;
      
      private static const NOT_ENOUGH_CRYSTALS_TEXT_COLOR:int = 16731648;
      
      private static const ENOUGH_CRYSTALS_TEXT_COLOR:int = 16777215;
      
      private var priceLabel:MouseDisabledLabel;
      
      private var crystals:int;
      
      public function DailyQuestChangeButton()
      {
         super();
         this.priceLabel = new MouseDisabledLabel();
         this.priceLabel.size = 11;
         super.setText(localeService.getText(TanksLocale.TEXT_DAILY_QUEST_CHANGE));
         moneyService.addListener(this);
      }
      
      public function showButtonWithCrystals(param1:int) : void
      {
         this.crystals = param1;
         var _loc2_:Diamond = new Diamond();
         _loc2_.y = 3;
         var _loc3_:Sprite = new Sprite();
         _loc3_.addChild(this.priceLabel);
         _loc3_.addChild(_loc2_);
         addChild(_loc3_);
         this.priceLabel.text = Money.numToString(param1,false);
         this.priceLabel.x = int(_width / 2 - (this.priceLabel.width + _loc2_.width) / 2);
         _loc2_.x = this.priceLabel.x + this.priceLabel.textWidth + 7;
         this.updatePriceLabelColor();
         super.showInTwoRows(captionLabel,_loc3_);
      }
      
      public function showButtonWithoutCrystals() : void
      {
         super.showInOneRow(captionLabel);
      }
      
      public function crystalsChanged(param1:int) : void
      {
         this.updatePriceLabelColor();
      }
      
      private function updatePriceLabelColor() : void
      {
         this.priceLabel.textColor = moneyService.crystal < this.crystals ? uint(NOT_ENOUGH_CRYSTALS_TEXT_COLOR) : uint(ENOUGH_CRYSTALS_TEXT_COLOR);
      }
      
      public function removeListeners() : void
      {
         moneyService.removeListener(this);
      }
   }
}


package alternativa.tanks.service.money
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.buycrystals.BuyCrystalsAlert;
   import alternativa.tanks.service.panel.IPanelView;
   import alternativa.tanks.service.payment.IPaymentService;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
   
   public class MoneyService implements IMoneyService
   {
      
      [Inject] // added
      public static var panelView:IPanelView;
      
      [Inject] // added
      public static var paymentService:IPaymentService;
      
      [Inject] // added
      public static var alertService:IAlertService;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private var mask:int = 0;
      
      private var listeners:Vector.<IMoneyListener>;
      
      private var _crystals:int = 0;
      
      private var _lastServerCrystals:int = 0;
      
      private var _crystalsExpenses:int = 0;
      
      public function MoneyService()
      {
         super();
         this.listeners = new Vector.<IMoneyListener>();
      }
      
      private static function showBuyCrystalsForm(param1:int) : void
      {
         new BuyCrystalsAlert(param1);
      }
      
      public function addListener(param1:IMoneyListener) : void
      {
         if(this.listeners.indexOf(param1) == -1)
         {
            this.listeners.push(param1);
         }
      }
      
      public function removeListener(param1:IMoneyListener) : void
      {
         var _loc2_:Number = Number(this.listeners.indexOf(param1));
         if(_loc2_ >= 0)
         {
            this.listeners.splice(_loc2_,1);
         }
      }
      
      public function get crystal() : int
      {
         var _loc1_:int = this._crystals ^ this.mask;
         this.setCrystals(_loc1_);
         return _loc1_;
      }
      
      public function init(param1:int) : void
      {
         this._lastServerCrystals = param1;
         this.updateCrystals(param1);
      }
      
      public function checkEnough(param1:int) : Boolean
      {
         if(this.crystal < param1)
         {
            if(paymentService.isEnabled())
            {
               showBuyCrystalsForm(param1 - this._crystals);
            }
            else
            {
               alertService.showOkAlert(localeService.getText(TanksLocale.TEXT_NOT_ENOUGH_MONEY_FOR_BUY_ITEM));
            }
            return false;
         }
         return true;
      }
      
      public function spend(param1:int) : void
      {
         this.updateCrystals(this.crystal - param1);
         this._crystalsExpenses += param1;
      }
      
      public function setServerCrystals(param1:int) : void
      {
         this.changeCrystals(param1 - this._lastServerCrystals);
         this._lastServerCrystals = param1;
      }
      
      public function changeCrystals(param1:int) : void
      {
         if(param1 < 0)
         {
            this._crystalsExpenses += param1;
            if(this._crystalsExpenses < 0)
            {
               param1 = this._crystalsExpenses;
               this._crystalsExpenses = 0;
            }
            else
            {
               param1 = 0;
            }
         }
         this.updateCrystals(this.crystal + param1);
      }
      
      protected function updateCrystals(param1:int) : void
      {
         var _loc3_:IMoneyListener = null;
         panelView.getPanel().playerInfo.crystals = param1;
         this.setCrystals(param1);
         var _loc2_:int = 0;
         while(_loc2_ < this.listeners.length)
         {
            _loc3_ = this.listeners[_loc2_];
            _loc3_.crystalsChanged(param1);
            _loc2_++;
         }
      }
      
      protected function setCrystals(param1:int) : void
      {
         this.mask = Math.random() * 4294967295 ^ 0x153B8A92;
         this._crystals = param1 ^ this.mask;
      }
   }
}


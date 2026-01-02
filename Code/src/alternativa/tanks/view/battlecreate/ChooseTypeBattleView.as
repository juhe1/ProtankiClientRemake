package alternativa.tanks.view.battlecreate
{
   import alternativa.osgi.service.locale.ILocaleService;
   import controls.TypeBattleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class ChooseTypeBattleView extends Sprite
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private static const MIN_FULL_NAME_WIDTH:int = 400;
      
      private var _battleTypesButton:Array;
      
      private var _selectedButton:TypeBattleButton;
      
      private var createBattleFormView:CreateBattleFormView;
      
      private var _buttonLabelsName:Vector.<String>;
      
      private var _buttonLabelsShortName:Vector.<String>;
      
      private var _componentWidth:Number = 0;
      
      private var _componentHeight:Number = 0;
      
      public function ChooseTypeBattleView(param1:CreateBattleFormView)
      {
         super();
         this.createBattleFormView = param1;
         this.initLabelNames();
      }
      
      private function initLabelNames() : void
      {
         this._buttonLabelsName = new Vector.<String>();
         this._buttonLabelsName.push(CreateBattleFormLabels.deathMatchButtonLabel);
         this._buttonLabelsName.push(CreateBattleFormLabels.teamDeathMatchButtonLabel);
         this._buttonLabelsName.push(CreateBattleFormLabels.captureTheFlagButtonLabel);
         this._buttonLabelsName.push(CreateBattleFormLabels.dominationButtonLabel);
         this._buttonLabelsName.push(localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_BUTTON_ASSAULT));
         this._buttonLabelsName.push(localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_BUTTON_RUGBY));
         this._buttonLabelsName.push("SUR");
         this._buttonLabelsName.push(localeService.getText(TanksLocale.TEXT_JGR_MODE_NAME));
         this._buttonLabelsShortName = new Vector.<String>();
         this._buttonLabelsShortName.push(CreateBattleFormLabels.deathMatchButtonShortLabel);
         this._buttonLabelsShortName.push(CreateBattleFormLabels.teamDeathMatchButtonShortLabel);
         this._buttonLabelsShortName.push(CreateBattleFormLabels.captureTheFlagButtonShortLabel);
         this._buttonLabelsShortName.push(CreateBattleFormLabels.dominationButtonShortLabel);
         this._buttonLabelsShortName.push(localeService.getText(TanksLocale.TEXT_AS_SHORT_NAME));
         this._buttonLabelsShortName.push(localeService.getText(TanksLocale.TEXT_RUGBY_SHORT_NAME));
         this._buttonLabelsShortName.push("SUR");
         this._buttonLabelsShortName.push(localeService.getText(TanksLocale.TEXT_JGR_SHORT_NAME));
      }
      
      public function setAvailableTypesBattle(param1:Vector.<BattleMode>) : void
      {
         var _loc3_:TypeBattleButton = null;
         var _loc4_:Object = null;
         this.destroy();
         this._battleTypesButton = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = new TypeBattleButton();
            _loc3_.data = param1[_loc2_];
            _loc3_.label = this._buttonLabelsName[param1[_loc2_].value];
            addChild(_loc3_);
            _loc4_ = new Object();
            _loc4_.id = param1[_loc2_].value;
            _loc4_.button = _loc3_;
            this._battleTypesButton[_loc2_] = _loc4_;
            _loc2_++;
         }
         this._battleTypesButton.sortOn(["id"],[Array.NUMERIC]);
         this.setEvents();
         this.resize(this._componentWidth,this._componentHeight);
      }
      
      public function setEvents() : void
      {
         var _loc2_:TypeBattleButton = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._battleTypesButton.length)
         {
            _loc2_ = TypeBattleButton(this._battleTypesButton[_loc1_].button);
            _loc2_.addEventListener(MouseEvent.CLICK,this.onClickButton);
            _loc1_++;
         }
      }
      
      public function removeEvents() : void
      {
         var _loc2_:TypeBattleButton = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._battleTypesButton.length)
         {
            _loc2_ = TypeBattleButton(this._battleTypesButton[_loc1_].button);
            _loc2_.removeEventListener(MouseEvent.CLICK,this.onClickButton);
            _loc1_++;
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:int = 0;
         if(this._battleTypesButton != null)
         {
            this.removeEvents();
            _loc1_ = 0;
            while(_loc1_ < this._battleTypesButton.length)
            {
               removeChild(this._battleTypesButton[_loc1_].button);
               this._battleTypesButton[_loc1_] = null;
               _loc1_++;
            }
         }
         this._battleTypesButton = null;
      }
      
      public function resize(param1:Number, param2:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TypeBattleButton = null;
         var _loc7_:TypeBattleButton = null;
         this._componentWidth = param1;
         this._componentHeight = param2;
         if(this._battleTypesButton != null)
         {
            _loc3_ = int(this._battleTypesButton.length);
            _loc4_ = int((param1 - (_loc3_ - 1) * 4 + 1) / _loc3_);
            _loc5_ = 0;
            while(_loc5_ < this._battleTypesButton.length)
            {
               _loc6_ = TypeBattleButton(this._battleTypesButton[_loc5_].button);
               _loc6_.width = _loc4_;
               if(_loc5_ != 0)
               {
                  _loc7_ = TypeBattleButton(this._battleTypesButton[_loc5_ - 1].button);
                  _loc6_.x = _loc7_.x + _loc7_.width + 4;
               }
               _loc5_++;
            }
            this.setLabels();
         }
      }
      
      private function setLabels() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Boolean = this._componentWidth > MIN_FULL_NAME_WIDTH;
         var _loc2_:int = 0;
         while(_loc2_ < this._battleTypesButton.length)
         {
            _loc3_ = int(this._battleTypesButton[_loc2_].id);
            TypeBattleButton(this._battleTypesButton[_loc2_]["button"]).label = _loc1_ ? this._buttonLabelsName[_loc3_] : this._buttonLabelsShortName[_loc3_];
            _loc2_++;
         }
      }
      
      public function getComponentHeight() : Number
      {
         return this._battleTypesButton != null ? Number(this._battleTypesButton[0].button.height) : 10;
      }
      
      private function onClickButton(param1:MouseEvent) : void
      {
         var _loc2_:BattleMode = BattleMode((param1.currentTarget as TypeBattleButton).data);
         this.createBattleFormView.setBattleMode(_loc2_);
      }
      
      public function setTypeBattle(param1:BattleMode) : void
      {
         var _loc3_:TypeBattleButton = null;
         if(this._selectedButton != null)
         {
            this._selectedButton.enabled = true;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._battleTypesButton.length)
         {
            _loc3_ = TypeBattleButton(this._battleTypesButton[_loc2_].button);
            if(param1 == BattleMode(_loc3_.data))
            {
               this._selectedButton = _loc3_;
               this._selectedButton.enabled = false;
            }
            _loc2_++;
         }
      }
   }
}


package alternativa.tanks.gui.selectcountry
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.service.country.CountryService;
   import controls.TankWindow;
   import controls.base.DefaultButtonBase;
   import controls.base.LabelBase;
   import controls.dropdownlist.DropDownList;
   import flash.events.MouseEvent;
   import projects.tanks.client.panel.model.usercountry.CountryInfo;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
   
   public class SelectCountryAlert extends DialogWindow
   {
      
      [Inject] // added
      public static var countryService:CountryService;
      
      [Inject] // added
      public static var dialogService:IDialogsService;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private const TOP_PADDING:int = 20;
      
      private var okButton:DefaultButtonBase;
      
      private var chooseCountryComboBox:DropDownList;
      
      private var countrySelectedCallback:Function;
      
      public function SelectCountryAlert(param1:Function)
      {
         var _loc4_:LabelBase = null;
         super();
         this.countrySelectedCallback = param1;
         var _loc2_:TankWindow = new TankWindow(340,140);
         addChild(_loc2_);
         this.okButton = new DefaultButtonBase();
         this.okButton.label = localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_OK);
         this.okButton.x = (width - this.okButton.width) / 2;
         this.okButton.y = _loc2_.height - this.okButton.height - 20;
         this.okButton.addEventListener(MouseEvent.CLICK,this.onClick);
         addChild(this.okButton);
         var _loc3_:LabelBase = new LabelBase();
         _loc3_.text = localeService.getText(TanksLocale.TEXT_CHECK_YOU_LOCATION_TEXT);
         _loc3_.x = this.TOP_PADDING;
         _loc3_.y = this.TOP_PADDING + 5;
         addChild(_loc3_);
         _loc4_ = new LabelBase();
         _loc4_.text = localeService.getText(TanksLocale.TEXT_YOURE_LOCATION_TEXT);
         _loc4_.x = this.TOP_PADDING;
         _loc4_.y = 55;
         _loc4_.width = 300;
         _loc4_.wordWrap = true;
         addChild(_loc4_);
         this.chooseCountryComboBox = new DropDownList();
         this.chooseCountryComboBox.width = _loc2_.width - 45 - _loc3_.width;
         this.chooseCountryComboBox.y = this.TOP_PADDING;
         this.initCountries();
         addChild(this.chooseCountryComboBox);
         this.chooseCountryComboBox.x = _loc3_.x + _loc3_.width + 5;
         dialogService.addDialog(this);
      }
      
      private function initCountries() : void
      {
         var _loc1_:Vector.<CountryInfo> = countryService.getRegisteredCountries();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            this.chooseCountryComboBox.addItem({
               "rang":0,
               "index":_loc2_,
               "id":_loc2_,
               "gameName":_loc1_[_loc2_].countryName,
               "code":_loc1_[_loc2_].countryCode
            });
            _loc2_++;
         }
         this.chooseCountryComboBox.sortOn("gameName");
         if(Boolean(countryService.getDefaultCountryCode()))
         {
            this.chooseCountryComboBox.selectItemByField("code",countryService.getDefaultCountryCode());
         }
         else
         {
            this.chooseCountryComboBox.selectItemByField("id",0);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         dialogService.removeDialog(this);
         this.countrySelectedCallback(this.chooseCountryComboBox.selectedItem["code"]);
         this.destroyWindow();
      }
      
      private function destroyWindow() : void
      {
         this.okButton.removeEventListener(MouseEvent.CLICK,this.onClick);
         this.countrySelectedCallback = null;
         this.okButton = null;
         this.chooseCountryComboBox = null;
      }
   }
}


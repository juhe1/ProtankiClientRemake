package alternativa.tanks.gui.friends.list.refferals
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.friends.FriendsWindow;
   import alternativa.tanks.gui.friends.IFriendsListState;
   import alternativa.tanks.service.referrals.ReferralsService;
   import alternativa.tanks.service.referrals.ReferralsServiceEvent;
   import alternativa.tanks.service.referrals.buttonhelper.ReferralsButtonHelperService;
   import alternativa.tanks.service.referrals.notification.NewReferralsNotifierService;
   import assets.Diamond;
   import controls.TankWindowInner;
   import controls.base.LabelBase;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import forms.ColorConstants;
   import forms.stat.ReferralWindowBigButton;
   import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
   import projects.tanks.client.panel.model.referrals.ReferralIncomeData;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class ReferralForm extends Sprite implements IFriendsListState
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var referralService:ReferralsService;
      
      [Inject] // added
      public static var partnerService:IPartnerService;
      
      [Inject] // added
      public static var newReferralsNotifierService:NewReferralsNotifierService;
      
      [Inject] // added
      public static var referralsButtonHelperService:ReferralsButtonHelperService;
      
      private static const MARGIN:int = 9;
      
      private static const TEXT_CONTROL_HEIGHT:int = 26;
      
      private var countLabel:LabelBase = new LabelBase();
      
      private var crystalLabel:LabelBase = new LabelBase();
      
      private var inviteReferralButton:ReferralWindowBigButton;
      
      private var referralStatList:ReferralStatList = new ReferralStatList();
      
      public function ReferralForm()
      {
         super();
         this.addCountLabel();
         this.addCrystalLabel();
         this.addReferralStatList();
         this.inviteReferralButton = referralsButtonHelperService.getReferralInviteButton();
         addChild(this.inviteReferralButton);
      }
      
      private function addCountLabel() : void
      {
         var _loc1_:LabelBase = null;
         _loc1_ = new LabelBase();
         _loc1_.text = localeService.getText(TanksLocale.TEXT_REFERAL_WINDOW_COUNT_LABEL);
         addChild(_loc1_);
         var _loc2_:TankWindowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
         _loc2_.width = 80;
         _loc2_.height = TEXT_CONTROL_HEIGHT;
         _loc2_.x = _loc1_.x + _loc1_.width + FriendsWindow.WINDOW_MARGIN;
         addChild(_loc2_);
         _loc1_.y = _loc2_.height - _loc1_.height >> 1;
         this.countLabel.x = _loc2_.x + _loc2_.width - MARGIN - this.countLabel.width;
         this.countLabel.y = _loc1_.y;
         this.countLabel.autoSize = TextFieldAutoSize.RIGHT;
         this.countLabel.color = ColorConstants.GREEN_TEXT;
         this.countLabel.text = "0";
         addChild(this.countLabel);
      }
      
      private function addCrystalLabel() : void
      {
         var _loc1_:LabelBase = new LabelBase();
         _loc1_.text = localeService.getText(TanksLocale.TEXT_REFERAL_WINDOW_SUMMARY_LABEL);
         addChild(_loc1_);
         var _loc2_:TankWindowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
         _loc2_.width = 100;
         _loc2_.height = TEXT_CONTROL_HEIGHT;
         _loc2_.x = FriendsWindow.WINDOW_WIDTH - FriendsWindow.WINDOW_MARGIN * 2 - _loc2_.width;
         addChild(_loc2_);
         _loc1_.x = _loc2_.x - MARGIN - _loc1_.width;
         _loc1_.y = _loc2_.height - _loc1_.height >> 1;
         var _loc3_:Diamond = new Diamond();
         _loc3_.x = _loc2_.x + _loc2_.width - MARGIN - _loc3_.width;
         _loc3_.y = _loc2_.height - _loc3_.height >> 1;
         addChild(_loc3_);
         this.crystalLabel.autoSize = TextFieldAutoSize.RIGHT;
         this.crystalLabel.color = ColorConstants.GREEN_TEXT;
         this.crystalLabel.x = _loc3_.x - 2 - this.crystalLabel.width;
         this.crystalLabel.y = _loc1_.y;
         this.crystalLabel.text = "0";
         addChild(this.crystalLabel);
      }
      
      private function addReferralStatList() : void
      {
         this.referralStatList.y = this.countLabel.y + TEXT_CONTROL_HEIGHT + 4;
         addChild(this.referralStatList);
      }
      
      private function referralsDataIsUpdated(param1:ReferralsServiceEvent) : void
      {
         var _loc2_:Vector.<ReferralIncomeData> = referralService.getReferrals();
         this.countLabel.text = _loc2_.length.toString();
         this.crystalLabel.text = this.calculateCrystalsSum(_loc2_).toString();
         this.referralStatList.addReferrals(_loc2_);
      }
      
      private function calculateCrystalsSum(param1:Vector.<ReferralIncomeData>) : int
      {
         var _loc3_:ReferralIncomeData = null;
         var _loc2_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc2_ += _loc3_.income;
         }
         return _loc2_;
      }
      
      public function initList() : void
      {
         referralService.addEventListener(ReferralsServiceEvent.DATA_UPDATED,this.referralsDataIsUpdated);
         referralService.requestUpdatingReferralsData();
         newReferralsNotifierService.resetNewReferralsCount();
      }
      
      public function hide() : void
      {
         if(parent.contains(this))
         {
            parent.removeChild(this);
            this.referralStatList.hide();
         }
         referralService.removeEventListener(ReferralsServiceEvent.DATA_UPDATED,this.referralsDataIsUpdated);
      }
      
      public function resize(param1:Number, param2:Number) : void
      {
         var _loc3_:int = int(param2) - this.inviteReferralButton.height;
         var _loc4_:int = int(param1);
         this.referralStatList.resize(_loc4_,_loc3_);
         this.inviteReferralButton.y = param2 - 10;
         this.inviteReferralButton.x = _loc4_ - this.inviteReferralButton.width >> 1;
      }
      
      public function filter(param1:String, param2:String) : void
      {
      }
      
      public function resetFilter() : void
      {
      }
   }
}


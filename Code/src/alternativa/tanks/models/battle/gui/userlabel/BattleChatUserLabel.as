package alternativa.tanks.models.battle.gui.userlabel
{
   import alternativa.tanks.battle.objects.tank.ClientTankState;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.display.resistance.ResistanceShieldIcon;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.tank.resistance.TankResistances;
   import alternativa.tanks.services.tankregistry.TankUsersRegistry;
   import alternativa.types.Long;
   import controls.base.LabelBase;
   import controls.chat.MessageColor;
   import filters.Filters;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.text.AntiAliasType;
   import forms.userlabel.ChatUserLabel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   
   public class BattleChatUserLabel extends ChatUserLabel
   {
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      [Inject]
      public static var tankUsersRegistry:TankUsersRegistry;
      
      [Inject]
      public static var userInfoService:BattleUserInfoService;
      
      private var resitanceLabel:LabelBase;
      
      public function BattleChatUserLabel(param1:String, param2:Boolean = true)
      {
         var _loc4_:IGameObject = null;
         var _loc5_:Tank = null;
         this.resitanceLabel = new LabelBase();
         _uid = userInfoService.getUserName(param1);
         _rank = userInfoService.getUserRank(param1);
         _chatModeratorLevel = userInfoService.getChatModeratorLevel(param1);
         _writeInPublicChat = false;
         _writePrivateInChat = false;
         _blockUserEnable = param2;
         var _loc3_:Boolean = false;
         if(battleInfoService.isSpectatorMode())
         {
            _loc4_ = tankUsersRegistry.getUser(param1);
            if(_loc4_ != null)
            {
               _loc5_ = ITankModel(_loc4_.adapt(ITankModel)).getTank();
               if(_loc5_ != null)
               {
                  _loc3_ = _loc5_.state == ClientTankState.ACTIVE;
               }
            }
         }
         this._focusOnUserEnabled = _loc3_;
         super(param1);
         if(!_self)
         {
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         }
      }
      
      [Obfuscation(rename="false")]
      override protected function getShadowFilters() : Array
      {
         return Filters.SHADOW_FILTERS;
      }
      
      [Obfuscation(rename="false")]
      protected function getShadowFiltersOnOver() : Array
      {
         return Filters.SHADOW_ON_OVER_FILTERS;
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         shadowContainer.filters = this.getShadowFilters();
         this.resitanceLabel.filters = this.getShadowFilters();
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         shadowContainer.filters = this.getShadowFiltersOnOver();
         this.resitanceLabel.filters = this.getShadowFiltersOnOver();
      }
      
      [Obfuscation(rename="false")]
      override protected function onMouseClick(param1:MouseEvent) : void
      {
         showClanProfile = true;
         super.onMouseClick(param1);
      }
      
      [Obfuscation(rename="false")]
      override protected function updateProperties() : void
      {
         var _loc2_:TankResistances = null;
         var _loc3_:int = 0;
         var _loc4_:Bitmap = null;
         setUid(_uid);
         setRank(_rank);
         setFriendState(_friendInfoUpdater.state);
         var _loc1_:IGameObject = tankUsersRegistry.getUser(super.userId);
         if(_loc1_ != null)
         {
            _loc2_ = TankResistances(_loc1_.adapt(TankResistances));
            _loc3_ = int(_loc2_.getResistance(false));
            if(_loc3_ > 0)
            {
               _loc4_ = ResistanceShieldIcon.getBitmapFor(_loc1_, super.userId);
               _loc4_.y += 4;
               _loc4_.x = _uidLabel.x + _uidLabel.textWidth + 7;
               shadowContainer.addChild(_loc4_);
               this.resitanceLabel.text = _loc3_ == 100 ? "??" : _loc3_.toString();
               addChild(this.resitanceLabel);
               this.resitanceLabel.x = _loc4_.x + 3;
               this.resitanceLabel.color = MessageColor.YELLOW;
               this.resitanceLabel.filters = this.getShadowFilters();
            }
         }
      }
      
      [Obfuscation(rename="false")]
      override protected function createUidLabel() : void
      {
         super.createUidLabel();
         _uidLabel.antiAliasType = AntiAliasType.ADVANCED;
         _uidLabel.thickness = 150;
         _uidLabel.sharpness = 200;
      }
   }
}


package alternativa.tanks.view.battlelist.battleitem
{
   import alternativa.tanks.controllers.battlelist.BattleListItemParams;
   import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
   import alternativa.tanks.view.battlelist.friends.FriendsIndicator;
   import assets.cellrenderer.battlelist.Abris;
   import controls.base.LabelBase;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import forms.ColorConstants;
   import projects.tanks.client.battleservice.BattleCreateParameters;
   import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleInfoUtils;
   
   public class BattleListItem extends Sprite
   {
      
      private static const DEFAULT_HEIGHT:int = 19;
      
      private static const MAPLABEL_MIN_RIGHT_INDENT:int = 6;
      
      private var _itemWidth:int = 100;
      
      private var proBattleIcon:Bitmap = new Bitmap();
      
      private var privateBattleIcon:Bitmap = new Bitmap();
      
      private var formatBattleIcon:Bitmap = new Bitmap();
      
      private var battleNameLabel:LabelBase = new LabelBase();
      
      private var userCountAbris:Abris = new Abris();
      
      private var blueCountAbris:Abris = new Abris();
      
      private var redCountAbris:Abris = new Abris();
      
      private var dmPlayersCount:LabelBase = new LabelBase();
      
      private var blueCount:LabelBase = new LabelBase();
      
      private var redCount:LabelBase = new LabelBase();
      
      private var friendsIndicator:FriendsIndicator;
      
      private var mapNameLabel:LabelBase = new LabelBase();
      
      private var data:BattleListItemParams;
      
      public function BattleListItem(param1:BattleListItemParams, param2:int)
      {
         super();
         this.data = param1;
         this._itemWidth = param2;
         this.drawDefaultHeight();
         if(this.createParams.privateBattle)
         {
            this.addPrivateBattleIcon();
         }
         else if(param1.formatBattle)
         {
            this.addFormatBattleIcon();
         }
         else if(this.createParams.proBattle)
         {
            this.addProBattleIcon();
         }
         var _loc3_:uint = this.getLabelColorByAccessible();
         var _loc4_:uint = this.getMapNameLabelColor(this.params.suspicionLevel);
         var _loc5_:int = int(this._itemWidth * 0.55);
         if(param1.isDM)
         {
            this.addControlsDM(_loc5_);
         }
         else
         {
            this.addControlsTDM(_loc5_);
         }
         this.friendsIndicator = new FriendsIndicator(param1.accessible,this.params.friends,_loc3_);
         this.friendsIndicator.x = (param1.isDM ? this.dmPlayersCount.x + this.dmPlayersCount.width : this.blueCount.x + this.blueCount.width) + 3;
         this.friendsIndicator.y = 2;
         this.friendsIndicator.visible = this.params.friends > 0;
         addChild(this.friendsIndicator);
         this.updateUsersCount();
         this.addControlMapName(_loc4_);
         this.mapNameLabel.size = 12;
         this.mapNameLabel.color = _loc3_;
         this.mapNameLabel.autoSize = TextFieldAutoSize.RIGHT;
         this.mapNameLabel.align = TextFormatAlign.RIGHT;
         this.mapNameLabel.text = param1.params.mapName;
         this.mapNameLabel.y = 1;
         addChild(this.mapNameLabel);
         this.resize(this._itemWidth);
      }
      
      private function get createParams() : BattleCreateParameters
      {
         return this.data.params.createParams;
      }
      
      private function get params() : BattleInfoBaseParams
      {
         return this.data.params;
      }
      
      private function drawDefaultHeight() : void
      {
         graphics.clear();
         graphics.beginFill(0,0);
         graphics.drawRect(0,0,1,DEFAULT_HEIGHT);
         graphics.endFill();
      }
      
      private function getLabelColorByAccessible() : uint
      {
         return this.data.accessible ? ColorConstants.GREEN_LABEL : ColorConstants.ACCESS_LABEL;
      }
      
      private function addControlMapName(param1:uint) : void
      {
         this.battleNameLabel.color = param1;
         this.battleNameLabel.autoSize = TextFieldAutoSize.NONE;
         this.battleNameLabel.size = 12;
         this.battleNameLabel.width = this._itemWidth / 2;
         this.battleNameLabel.height = 18;
         this.battleNameLabel.x = 12;
         this.battleNameLabel.y = 1;
         this.battleNameLabel.text = this.getFullMapName();
         addChild(this.battleNameLabel);
      }
      
      private function addControlsTDM(param1:int) : void
      {
         this.redCountAbris.x = param1;
         this.redCountAbris.y = 3;
         addChild(this.redCountAbris);
         this.blueCountAbris.x = param1 + 27;
         this.blueCountAbris.y = 3;
         addChild(this.blueCountAbris);
         this.redCount.autoSize = TextFieldAutoSize.NONE;
         this.redCount.size = 12;
         this.redCount.align = TextFormatAlign.CENTER;
         this.redCount.x = int(param1 - 0.5);
         this.redCount.y = 1;
         this.redCount.width = 27;
         this.redCount.height = 16;
         addChild(this.redCount);
         this.blueCount.autoSize = TextFieldAutoSize.NONE;
         this.blueCount.align = TextFormatAlign.CENTER;
         this.blueCount.x = int(param1 + 26.5);
         this.blueCount.y = 1;
         this.blueCount.width = 25;
         this.blueCount.height = 16;
         addChild(this.blueCount);
      }
      
      private function addControlsDM(param1:int) : void
      {
         this.userCountAbris.x = int(param1 - 0.5);
         this.userCountAbris.y = 3;
         addChild(this.userCountAbris);
         this.dmPlayersCount = new LabelBase();
         this.dmPlayersCount.autoSize = TextFieldAutoSize.NONE;
         this.dmPlayersCount.size = 12;
         this.dmPlayersCount.align = TextFormatAlign.CENTER;
         this.dmPlayersCount.x = param1 - 20;
         this.dmPlayersCount.y = 1;
         this.dmPlayersCount.width = 52;
         this.dmPlayersCount.height = 16;
         addChild(this.dmPlayersCount);
      }
      
      private function getFullMapName() : String
      {
         var _loc1_:String = this.createParams.proBattle ? this.params.mapName : this.getMapNameWithoutFormat();
         if(this.data.formatBattle)
         {
            _loc1_ = _loc1_ + " " + this.data.formatName;
         }
         return _loc1_;
      }
      
      private function getMapNameWithoutFormat() : String
      {
         return BattleInfoUtils.buildBattleName(this.params.mapName,this.createParams.battleMode.name);
      }
      
      private function addProBattleIcon() : void
      {
         this.proBattleIcon.bitmapData = BattleTypeIcon.getProIconData(this.data.accessible);
         this.addBattleTypeIcon(this.proBattleIcon);
      }
      
      private function addFormatBattleIcon() : void
      {
         this.formatBattleIcon.bitmapData = BattleTypeIcon.getFormatIconData(this.data.accessible);
         this.addBattleTypeIcon(this.formatBattleIcon);
      }
      
      private function addPrivateBattleIcon() : void
      {
         this.privateBattleIcon.bitmapData = BattleTypeIcon.getPrivateIconData(this.data.accessible);
         this.addBattleTypeIcon(this.privateBattleIcon);
      }
      
      private function addBattleTypeIcon(param1:Bitmap) : void
      {
         param1.y = 5;
         param1.x = 0;
         addChild(param1);
      }
      
      public function resize(param1:int) : void
      {
         this._itemWidth = param1;
         var _loc2_:int = int(this._itemWidth * 0.55);
         if(this.data.isDM)
         {
            this.userCountAbris.x = _loc2_;
            this.dmPlayersCount.x = int(_loc2_ - 0.5);
            this.friendsIndicator.x = this.dmPlayersCount.x + this.dmPlayersCount.width + 4;
         }
         else
         {
            this.redCountAbris.x = _loc2_;
            this.blueCountAbris.x = _loc2_ + 27;
            this.redCount.x = int(_loc2_ - 0.5);
            this.blueCount.x = int(_loc2_ + 26.5);
            this.friendsIndicator.x = this.blueCount.x + this.blueCount.width + 4;
         }
         if(Boolean(this.params.customName))
         {
            this.battleNameLabel.text = this.params.customName;
         }
         else
         {
            this.battleNameLabel.text = this.getFullMapName();
         }
         if(this.needCutMapLabelText())
         {
            this.cutMapLabelText();
         }
         this.mapNameLabel.x = this._itemWidth - this.mapNameLabel.width;
      }
      
      private function cutMapLabelText() : void
      {
         if(this.data.formatBattle)
         {
            this.battleNameLabel.text = this.getMapNameWithoutFormat();
            if(this.needCutMapLabelText())
            {
               this.battleNameLabel.text = this.params.mapName;
            }
         }
         else
         {
            this.battleNameLabel.text = this.params.mapName;
         }
      }
      
      private function needCutMapLabelText() : Boolean
      {
         var _loc1_:Number = this.battleNameLabel.x + this.battleNameLabel.textWidth;
         if(this.data.isDM)
         {
            return _loc1_ > this.userCountAbris.x - MAPLABEL_MIN_RIGHT_INDENT;
         }
         return _loc1_ > this.redCountAbris.x - MAPLABEL_MIN_RIGHT_INDENT;
      }
      
      public function updateSuspicion(param1:BattleSuspicionLevel) : void
      {
         this.battleNameLabel.color = this.getMapNameLabelColor(param1);
      }
      
      private function getMapNameLabelColor(param1:BattleSuspicionLevel) : uint
      {
         switch(param1)
         {
            case BattleSuspicionLevel.NONE:
               return this.getLabelColorByAccessible();
            case BattleSuspicionLevel.HIGH:
               return ColorConstants.BATTLE_SUSPICIOUS_HIGH;
            default:
               return ColorConstants.BATTLE_SUSPICIOUS_LOW;
         }
      }
      
      public function updateUsersCount() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc1_:int = this.createParams.maxPeopleCount;
         var _loc2_:int = this.params.friends;
         if(this.data.isDM)
         {
            _loc3_ = int(this.data.dmParams.users.length);
            _loc4_ = _loc3_ == _loc1_;
            this.userCountAbris.gotoAndStop(_loc4_ ? 1 : 2);
            this.dmPlayersCount.text = String(_loc3_);
            this.dmPlayersCount.color = _loc4_ ? 8816262 : 16777215;
         }
         else
         {
            _loc5_ = int(this.data.teamParams.usersRed.length);
            _loc6_ = int(this.data.teamParams.usersBlue.length);
            _loc7_ = _loc5_ == _loc1_;
            _loc8_ = _loc6_ == _loc1_;
            this.redCountAbris.gotoAndStop(_loc7_ ? 3 : 5);
            this.redCount.text = String(_loc5_);
            this.redCount.color = _loc7_ ? 8816262 : 16777215;
            this.blueCountAbris.gotoAndStop(_loc8_ ? 4 : 6);
            this.blueCount.text = String(_loc6_);
            this.blueCount.color = _loc8_ ? 8816262 : 16777215;
         }
         this.friendsIndicator.setFriendCount(_loc2_);
         this.friendsIndicator.visible = _loc2_ > 0;
      }
      
      public function updateBattleName() : void
      {
         var _loc1_:* = this.params.customName != null ? this.params.customName : this.getFullMapName();
         this.battleNameLabel.text = _loc1_;
      }
      
      public function updateAccessible() : void
      {
         var _loc1_:Boolean = this.data.accessible;
         this.updateBattleTypeIconAccessible();
         var _loc2_:uint = this.getLabelColorByAccessible();
         this.battleNameLabel.color = this.getMapNameLabelColor(this.params.suspicionLevel);
         this.friendsIndicator.setAccessable(_loc1_);
      }
      
      private function updateBattleTypeIconAccessible() : void
      {
         var _loc1_:Boolean = this.data.accessible;
         if(this.createParams.privateBattle)
         {
            this.privateBattleIcon.bitmapData = BattleTypeIcon.getPrivateIconData(_loc1_);
         }
         if(this.data.formatBattle)
         {
            this.formatBattleIcon.bitmapData = BattleTypeIcon.getFormatIconData(_loc1_);
         }
         if(this.createParams.proBattle)
         {
            this.proBattleIcon.bitmapData = BattleTypeIcon.getProIconData(_loc1_);
         }
      }
   }
}


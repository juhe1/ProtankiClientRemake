package alternativa.tanks.gui.friends.list.renderer
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.friends.battleLink.BattleLink;
   import alternativa.tanks.gui.friends.list.renderer.background.RendererBackGroundClanMembersList;
   import controls.base.LabelBase;
   import fl.controls.listClasses.CellRenderer;
   import fl.controls.listClasses.ListData;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import forms.ColorConstants;
   import forms.Styles;
   import forms.contextmenu.BattleInviteContextMenuLabel;
   import forms.userlabel.UserLabel;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.IBattleLinkActivatorService;
   import services.contextmenu.IContextMenuService;
   
   public class ClanMembersListRenderer extends CellRenderer
   {
      
      [Inject]
      public static var battleLinkActivatorService:IBattleLinkActivatorService;
      
      [Inject]
      public static var localeService:ILocaleService;
      
      [Inject]
      public static var contextMenuService:IContextMenuService;
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      public static const ROW_HEIGHT:int = 18;
      
      private static var gradientGreenIconClass:Class = ClanMembersListRenderer_gradientGreenIconClass;
      
      private static var gradientGreenBitmapData:BitmapData = Bitmap(new gradientGreenIconClass()).bitmapData;
      
      private static var gradientGreyIconClass:Class = ClanMembersListRenderer_gradientGreyIconClass;
      
      private static var gradientGreyBitmapData:BitmapData = Bitmap(new gradientGreyIconClass()).bitmapData;
      
      private var _labelsContainer:DisplayObject;
      
      private var _userLabel:UserLabel;
      
      private var _battleLink:BattleLink;
      
      private var _isNewLabel:LabelBase;
      
      private var _gradientGreen:Bitmap;
      
      private var _gradientGrey:Bitmap;
      
      private var _battleInviteIcon:Bitmap;
      
      public function ClanMembersListRenderer()
      {
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         _data = param1;
         mouseEnabled = false;
         mouseChildren = true;
         buttonMode = useHandCursor = false;
         this._labelsContainer = this.createLabels(_data);
         var _loc2_:DisplayObject = new RendererBackGroundClanMembersList(this._userLabel.online);
         var _loc3_:DisplayObject = new RendererBackGroundClanMembersList(this._userLabel.online,true);
         setStyle(Styles.UP_SKIN,_loc2_);
         setStyle(Styles.DOWN_SKIN,_loc2_);
         setStyle(Styles.OVER_SKIN,_loc2_);
         setStyle(Styles.SELECTED_UP_SKIN,_loc3_);
         setStyle(Styles.SELECTED_OVER_SKIN,_loc3_);
         setStyle(Styles.SELECTED_DOWN_SKIN,_loc3_);
      }
      
      private function createLabels(param1:Object) : Sprite
      {
         var _loc2_:Sprite = new Sprite();
         if(param1.id != null)
         {
            if(this._battleInviteIcon == null)
            {
               this._battleInviteIcon = new Bitmap(BattleInviteContextMenuLabel.battleInviteBitmapData);
            }
            this._battleInviteIcon.x = 0;
            this._battleInviteIcon.y = (ROW_HEIGHT - this._battleInviteIcon.height) / 2;
            this._battleInviteIcon.visible = false;
            _loc2_.addChild(this._battleInviteIcon);
            this._userLabel = new UserLabel(param1.id,false);
            this._userLabel.inviteBattleEnable = true;
            this._userLabel.showClanProfile = false;
            this._userLabel.x = this._battleInviteIcon.x + this._battleInviteIcon.width + 4;
            this._userLabel.y = 0;
            _loc2_.addChild(this._userLabel);
            if(Boolean(param1.isNew))
            {
               if(this._userLabel.online)
               {
                  if(this._gradientGreen == null)
                  {
                     this._gradientGreen = new Bitmap(gradientGreenBitmapData);
                  }
                  this._gradientGreen.visible = true;
                  _loc2_.addChild(this._gradientGreen);
               }
               else
               {
                  if(this._gradientGrey == null)
                  {
                     this._gradientGrey = new Bitmap(gradientGreyBitmapData);
                  }
                  this._gradientGrey.visible = true;
                  _loc2_.addChild(this._gradientGrey);
               }
               if(this._isNewLabel == null)
               {
                  this._isNewLabel = new LabelBase();
                  this._isNewLabel.text = localeService.getText(TanksLocale.TEXT_FRIENDS_NEW_FRIEND);
                  this._isNewLabel.color = ColorConstants.GREEN_LABEL;
                  this._isNewLabel.mouseEnabled = false;
               }
               this._isNewLabel.visible = true;
               this._isNewLabel.x = 223 - this._isNewLabel.width;
               this._isNewLabel.y = 0;
               _loc2_.addChild(this._isNewLabel);
               if(this._gradientGreen != null)
               {
                  this._gradientGreen.x = this._isNewLabel.x - 7;
               }
               if(this._gradientGrey != null)
               {
                  this._gradientGrey.x = this._isNewLabel.x - 7;
               }
            }
            else
            {
               if(this._isNewLabel != null)
               {
                  this._isNewLabel.visible = false;
               }
               if(this._gradientGreen != null)
               {
                  this._gradientGreen.visible = false;
               }
               if(this._gradientGrey != null)
               {
                  this._gradientGrey.visible = false;
               }
            }
            if(this._battleLink != null)
            {
               this._battleLink.removeEvents();
               this._battleLink.labelCont.removeEventListener(MouseEvent.CLICK,this.onBattleLinkClick);
            }
            this._battleLink = new BattleLink(param1.id);
            this._battleLink.labelCont.addEventListener(MouseEvent.CLICK,this.onBattleLinkClick,false,0,true);
            _loc2_.addChild(this._battleLink);
            this._battleLink.x = 233;
            this.updateStatusOnline();
            this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver,false,0,true);
            this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut,false,0,true);
         }
         return _loc2_;
      }
      
      private function updateStatusOnline() : void
      {
         _data.online = this._userLabel.online;
         this._userLabel.setUidColor(this._userLabel.online ? ColorConstants.GREEN_LABEL : ColorConstants.ACCESS_LABEL,false);
         this._battleInviteIcon.visible = this._userLabel.online && Boolean(_data.availableInvite);
      }
      
      private function onRollOver(param1:MouseEvent) : void
      {
         if(Boolean(_data.isNew))
         {
            if(this._isNewLabel != null)
            {
               this._isNewLabel.visible = false;
            }
            if(this._userLabel.online)
            {
               if(this._gradientGreen != null)
               {
                  this._gradientGreen.visible = false;
               }
            }
            else if(this._gradientGrey != null)
            {
               this._gradientGrey.visible = false;
            }
         }
         super.selected = true;
      }
      
      private function onRollOut(param1:MouseEvent) : void
      {
         if(Boolean(_data.isNew))
         {
            if(this._isNewLabel != null)
            {
               this._isNewLabel.visible = true;
            }
            if(this._userLabel.online)
            {
               if(this._gradientGreen != null)
               {
                  this._gradientGreen.visible = true;
               }
            }
            else if(this._gradientGrey != null)
            {
               this._gradientGrey.visible = true;
            }
         }
         super.selected = false;
      }
      
      private function onClickRemoveFriend(param1:MouseEvent) : void
      {
         contextMenuService.removeFromFriends(this._userLabel.userId,this._userLabel.uid);
      }
      
      private function onBattleLinkClick(param1:MouseEvent) : void
      {
         if(this._battleLink.hasData() && this._battleLink.data.isClickable())
         {
            battleLinkActivatorService.navigateToBattleUrl(this._battleLink.data.getBattleData());
         }
      }
      
      override public function set listData(param1:ListData) : void
      {
         _listData = param1;
         label = _listData.label;
         if(this._labelsContainer != null)
         {
            setStyle("icon",this._labelsContainer);
         }
      }
      
      override protected function drawBackground() : void
      {
         var _loc1_:String = enabled ? mouseState : "disabled";
         if(selected)
         {
            _loc1_ = "selected" + _loc1_.substr(0,1).toUpperCase() + _loc1_.substr(1);
         }
         _loc1_ += "Skin";
         var _loc2_:DisplayObject = background;
         background = getDisplayObjectInstance(getStyleValue(_loc1_));
         addChildAt(background,0);
         if(_loc2_ != null && _loc2_ != background)
         {
            removeChild(_loc2_);
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
      }
   }
}


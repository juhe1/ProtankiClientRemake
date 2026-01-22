package alternativa.tanks.gui.friends.list.renderer
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.friends.FriendActionIndicator;
   import alternativa.tanks.gui.friends.list.renderer.background.RendererBackGroundIncomingList;
   import controls.base.LabelBase;
   import fl.controls.listClasses.CellRenderer;
   import fl.controls.listClasses.ListData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import forms.ColorConstants;
   import forms.userlabel.UserLabel;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import services.contextmenu.IContextMenuService;
   
   public class FriendsIncomingListRenderer extends CellRenderer
   {
      
      [Inject]
      public static var contextMenuService:IContextMenuService;
      
      [Inject]
      public static var localeService:ILocaleService;
      
      private var _labelsContainer:DisplayObject;
      
      private var _userLabel:UserLabel;
      
      private var _acceptRequestIndicator:FriendActionIndicator;
      
      private var _rejectRequestIndicator:FriendActionIndicator;
      
      private var _isNewLabel:LabelBase;
      
      public function FriendsIncomingListRenderer()
      {
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         _data = param1;
         mouseEnabled = false;
         mouseChildren = true;
         buttonMode = useHandCursor = false;
         var _loc2_:RendererBackGroundIncomingList = new RendererBackGroundIncomingList(false);
         var _loc3_:RendererBackGroundIncomingList = new RendererBackGroundIncomingList(true);
         setStyle("upSkin",_loc2_);
         setStyle("downSkin",_loc2_);
         setStyle("overSkin",_loc2_);
         setStyle("selectedUpSkin",_loc3_);
         setStyle("selectedOverSkin",_loc3_);
         setStyle("selectedDownSkin",_loc3_);
         this._labelsContainer = this.createLabels(_data);
         if(this._acceptRequestIndicator == null)
         {
            this._acceptRequestIndicator = new FriendActionIndicator(FriendActionIndicator.YES);
            addChild(this._acceptRequestIndicator);
         }
         this._acceptRequestIndicator.visible = false;
         if(this._rejectRequestIndicator == null)
         {
            this._rejectRequestIndicator = new FriendActionIndicator(FriendActionIndicator.NO);
            addChild(this._rejectRequestIndicator);
         }
         this._rejectRequestIndicator.visible = false;
         if(this._isNewLabel == null)
         {
            this._isNewLabel = new LabelBase();
            this._isNewLabel.text = localeService.getText(TanksLocale.TEXT_FRIENDS_NEW) + "!";
            this._isNewLabel.height = 18;
            this._isNewLabel.y = -1;
            this._isNewLabel.color = ColorConstants.GREEN_LABEL;
            addChild(this._isNewLabel);
            this._isNewLabel.mouseEnabled = false;
         }
         this._isNewLabel.visible = _data.isNew;
         this.addEventListener(Event.RESIZE,this.onResize,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut,false,0,true);
         this.resize();
         this._acceptRequestIndicator.addEventListener(MouseEvent.CLICK,this.onClickAcceptRequest,false,0,true);
         this._rejectRequestIndicator.addEventListener(MouseEvent.CLICK,this.onClickRejectRequest,false,0,true);
      }
      
      private function onResize(param1:Event) : void
      {
         this.resize();
      }
      
      private function resize() : void
      {
         this._rejectRequestIndicator.x = _width - this._rejectRequestIndicator.width - 6;
         this._acceptRequestIndicator.x = this._rejectRequestIndicator.x - this._acceptRequestIndicator.width - 1;
         this._isNewLabel.x = _width - this._isNewLabel.width - 6;
      }
      
      private function createLabels(param1:Object) : Sprite
      {
         var _loc2_:Sprite = new Sprite();
         if(param1.id != null)
         {
            this._userLabel = new UserLabel(param1.id);
            this._userLabel.x = -3;
            this._userLabel.y = -1;
            _loc2_.addChild(this._userLabel);
            this._userLabel.setUidColor(ColorConstants.GREEN_LABEL);
         }
         return _loc2_;
      }
      
      private function onRollOver(param1:MouseEvent) : void
      {
         this._acceptRequestIndicator.visible = true;
         this._rejectRequestIndicator.visible = true;
         if(Boolean(_data.isNew))
         {
            this._isNewLabel.visible = false;
         }
         super.selected = true;
      }
      
      private function onRollOut(param1:MouseEvent) : void
      {
         this._acceptRequestIndicator.visible = false;
         this._rejectRequestIndicator.visible = false;
         if(Boolean(_data.isNew))
         {
            this._isNewLabel.visible = true;
         }
         super.selected = false;
      }
      
      private function onClickAcceptRequest(param1:MouseEvent) : void
      {
         contextMenuService.acceptRequest(this._userLabel.userId,this._userLabel.uid);
      }
      
      private function onClickRejectRequest(param1:MouseEvent) : void
      {
         contextMenuService.rejectRequest(this._userLabel.userId,this._userLabel.uid);
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


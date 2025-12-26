package alternativa.tanks.view.registration
{
   import alternativa.tanks.service.IExternalEntranceService;
   import controls.DefaultIconButton;
   import controls.FBButton;
   import controls.TankWindow;
   import controls.VKButton;
   import controls.base.LabelBase;
   
   public class ExternalEntranceForm extends TankWindow
   {
      
      [Inject]
      public static var externalEntranceService:IExternalEntranceService;
      
      public var vkButton:VKButton;
      
      public var fbButton:FBButton;
      
      public var infoLabel:LabelBase;
      
      private var _margin:int = 20;
      
      private var _border:int = 25;
      
      private var _space:int = 5;
      
      public function ExternalEntranceForm(param1:int, param2:int, param3:String)
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:DefaultIconButton = null;
         this.vkButton = new VKButton();
         this.fbButton = new FBButton();
         this.infoLabel = new LabelBase();
         this.infoLabel.text = param3;
         if(Boolean(externalEntranceService.facebookEnabled) && Boolean(externalEntranceService.vkontakteEnabled))
         {
            param2 += 15;
            this.vkButton.width = 102;
            this.fbButton.width = 102;
            _loc4_ = this.vkButton.width + this.fbButton.width + this._space + 2 * this._border;
            param1 = Math.min(_loc4_,param1);
         }
         else
         {
            _loc6_ = externalEntranceService.vkontakteEnabled ? this.vkButton : this.fbButton;
            _loc6_.width = 102;
            _loc4_ = _loc6_.width + this.infoLabel.width + this._space + 2 * this._border;
            param1 = Math.min(_loc4_,param1);
         }
         super(param1,param2);
         if(Boolean(externalEntranceService.facebookEnabled) && Boolean(externalEntranceService.vkontakteEnabled))
         {
            addChild(this.infoLabel);
            addChild(this.vkButton);
            addChild(this.fbButton);
            _loc5_ = (param1 - this.fbButton.width - this.vkButton.width) / 3;
            this.infoLabel.x = (param1 - this.infoLabel.width) / 2;
            this.infoLabel.y = 2 * this._space + 4;
            this.vkButton.y = this.infoLabel.y + this.infoLabel.height + this._space;
            this.vkButton.x = _loc5_;
            this.fbButton.y = this.infoLabel.y + this.infoLabel.height + this._space;
            this.fbButton.x = 2 * _loc5_ + this.vkButton.width;
         }
         else
         {
            addChild(this.infoLabel);
            addChild(_loc6_);
            _loc5_ = (param1 - _loc6_.width - this.infoLabel.width - this._space) / 2;
            this.infoLabel.x = _loc5_;
            this.infoLabel.y = this._margin + this._space;
            _loc6_.x = param1 - _loc6_.width - _loc5_;
            _loc6_.y = this.infoLabel.y - 7;
         }
      }
   }
}


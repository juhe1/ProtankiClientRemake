package alternativa.tanks.models.battle.gui.chat
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.models.battle.battlefield.common.MessageLine;
   import alternativa.tanks.models.battle.ctf.MessageColor;
   import alternativa.tanks.models.battle.gui.userlabel.BattleChatUserLabel;
   import alternativa.types.Long;
   import controls.Label;
   import flash.text.AntiAliasType;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class BattleChatLine extends MessageLine
   {
      
      [Inject]
      public static var localeService:ILocaleService;
      
      private var output:Label;
      
      private var _namesWidth:int = 0;
      
      private var _width:int = 300;
      
      private var chatUserLabel:BattleChatUserLabel;
      
      public function BattleChatLine(param1:Long, param2:BattleTeam, param3:String, param4:Boolean, param5:Boolean)
      {
         var _loc7_:Label = null;
         this.output = new Label();
         super();
         var _loc6_:int = 0;
         if(param5)
         {
            _loc6_ = 14;
            _loc7_ = new Label();
            _loc7_.color = MessageColor.YELLOW;
            _loc7_.text = localeService.getText(TanksLocale.TEXT_SPECTATOR_NAME) + ":";
            _loc7_.thickness = 50;
            _loc7_.sharpness = 0;
            _loc7_.mouseEnabled = false;
            shadowContainer.addChild(_loc7_);
            _loc7_.x = _loc6_;
            _loc6_ += _loc7_.textWidth + 1;
         }
         else
         {
            this.chatUserLabel = new BattleChatUserLabel(param1);
            this.chatUserLabel.setUidColor(MessageColor.getUserNameColor(param2,param5),true);
            this.chatUserLabel.setAdditionalText(":");
            addChild(this.chatUserLabel);
            _loc6_ += this.chatUserLabel.width;
         }
         this.output.color = MessageColor.getTextColor(param2,param4,param5);
         this.output.antiAliasType = AntiAliasType.ADVANCED;
         this.output.thickness = 150;
         this.output.sharpness = 200;
         this.output.multiline = true;
         this.output.wordWrap = true;
         this.output.mouseEnabled = false;
         shadowContainer.addChild(this.output);
         this._namesWidth = _loc6_;
         if(this._namesWidth > this._width / 2)
         {
            this.output.y = 15;
            this.output.x = 0;
            this.output.width = this._width - 5;
         }
         else
         {
            this.output.x = this._namesWidth + 3;
            this.output.y = 0;
            this.output.width = this._width - this._namesWidth - 8;
         }
         this.output.text = param3;
      }
      
      [Obfuscation(rename="false")]
      public function alignChatUserLabel() : void
      {
         this._namesWidth = this.chatUserLabel.width;
         if(this._namesWidth > this._width / 2)
         {
            this.output.y = 15;
            this.output.x = 0;
            this.output.width = this._width - 5;
         }
         else
         {
            this.output.x = this._namesWidth + 3;
            this.output.y = 0;
            this.output.width = this._width - this._namesWidth - 8;
         }
      }
      
      [Obfuscation(rename="false")]
      override public function set width(param1:Number) : void
      {
         this._width = int(param1);
         if(this._namesWidth > this._width / 2 && this.output.text.length * 8 > this._width - this._namesWidth)
         {
            this.output.y = 21;
            this.output.x = 0;
            this.output.width = this._width - 5;
            this.output.height = 20;
         }
         else
         {
            this.output.x = this._namesWidth;
            this.output.y = 0;
            this.output.width = this._width - this._namesWidth - 5;
            this.output.height = 20;
         }
      }
   }
}


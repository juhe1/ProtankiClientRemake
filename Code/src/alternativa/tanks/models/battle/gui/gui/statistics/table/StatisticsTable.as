package alternativa.tanks.models.battle.gui.gui.statistics.table
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.models.battle.battlefield.event.ContinueBattleEvent;
   import alternativa.tanks.models.battle.gui.gui.statistics.field.timelimit.TimeLimitField;
   import alternativa.tanks.models.battle.gui.statistics.ClientUserStat;
   import alternativa.tanks.services.targeting.TargetingInputManager;
   import alternativa.types.Long;
   import alternativa.utils.removeDisplayObject;
   import controls.Label;
   import controls.RedButton;
   import controls.buttons.h30px.GreenMediumButton;
   import controls.resultassets.ResultWindowGray;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class StatisticsTable extends Sprite
   {
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var inputManager:TargetingInputManager;
      
      private var redTeamView:ViewStatistics;
      
      private var blueTeamView:ViewStatistics;
      
      private var dmView:ViewStatistics;
      
      private var controlPanel:Sprite;
      
      private var exitButton:RedButton;
      
      private var continueButton:GreenMediumButton;
      
      private var exitBg:ResultWindowGray;
      
      private var isTeamMode:Boolean;
      
      private var restartLabel:Label;
      
      private var restartField:TimeLimitField;
      
      private var battleNamePlate:BattleNamePlate;
      
      private var matchBattle:Boolean;
      
      public function StatisticsTable(param1:String, param2:Boolean)
      {
         super();
         this.isTeamMode = param2;
         visible = false;
         this.battleNamePlate = new BattleNamePlate(param1);
      }
      
      public function setBattleName(param1:String) : *
      {
         this.battleNamePlate.setBattleName(param1);
      }
      
      public function showDm(param1:Boolean, param2:Boolean, param3:String, param4:Vector.<ClientUserStat>, param5:Boolean, param6:int) : void
      {
         if(!visible)
         {
            this.dmView = this.createView(ViewStatistics.GREEN,param3,param4,param5,BattleTeam.NONE,param2);
            addChild(this.dmView);
            this.doShow(param1,param6);
         }
      }
      
      public function showTeam(param1:Boolean, param2:String, param3:Vector.<ClientUserStat>, param4:Vector.<ClientUserStat>, param5:Boolean, param6:int, param7:BattleTeam, param8:Boolean) : void
      {
         if(!visible)
         {
            this.redTeamView = this.createView(ViewStatistics.RED,param2,param3,param5,param7,param8);
            addChild(this.redTeamView);
            this.blueTeamView = this.createView(ViewStatistics.BLUE,param2,param4,param5,param7,param8);
            addChild(this.blueTeamView);
            this.doShow(param1,param6);
         }
      }
      
      private function createView(param1:int, param2:String, param3:Vector.<ClientUserStat>, param4:Boolean, param5:BattleTeam, param6:Boolean) : ViewStatistics
      {
         var _loc7_:ViewStatistics = new ViewStatistics(param1,param2,param4,param5,param6);
         _loc7_.updatePlayersInfo(param3);
         return _loc7_;
      }
      
      private function doShow(param1:Boolean, param2:int) : void
      {
         this.matchBattle = param1;
         inputManager.startDialogWithAllowedKeyboardInput();
         visible = true;
         addChild(this.battleNamePlate);
         this.createExitPanel(param2);
         display.stage.addEventListener(Event.RESIZE,this.onResize);
         this.onResize();
      }
      
      public function hide() : void
      {
         if(!visible)
         {
            return;
         }
         visible = false;
         display.stage.removeEventListener(Event.RESIZE,this.onResize);
         removeChild(this.battleNamePlate);
         removeDisplayObject(this.blueTeamView);
         this.blueTeamView = null;
         removeDisplayObject(this.redTeamView);
         this.redTeamView = null;
         removeDisplayObject(this.dmView);
         this.dmView = null;
         if(this.exitButton != null)
         {
            this.exitButton.removeEventListener(MouseEvent.CLICK,this.onExitClick);
            this.exitButton = null;
         }
         if(this.continueButton != null)
         {
            this.continueButton.removeEventListener(MouseEvent.CLICK,this.onContinueClick);
            this.continueButton = null;
         }
         removeDisplayObject(this.controlPanel);
         this.controlPanel = null;
         inputManager.endDialog();
      }
      
      private function onResize(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         var _loc5_:ViewStatistics = null;
         _loc2_ = display.stage.stageWidth / 2;
         var _loc3_:int = display.stage.stageHeight / 2;
         var _loc4_:ViewStatistics = null;
         _loc5_ = null;
         if(Boolean(this.dmView))
         {
            this.setViewHeight();
            this.dmView.y = -(this.dmView.height >> 1);
            _loc4_ = _loc5_ = this.dmView;
         }
         else if(Boolean(this.blueTeamView) && Boolean(this.redTeamView))
         {
            this.setTeamViewHeight();
            this.redTeamView.y = -(this.blueTeamView.height + this.redTeamView.height + 5 >> 1);
            this.blueTeamView.y = this.redTeamView.y + this.redTeamView.height + 5;
            _loc4_ = this.redTeamView;
            _loc5_ = this.blueTeamView;
         }
         this.battleNamePlate.y = _loc4_.y - this.battleNamePlate.height - 5;
         this.battleNamePlate.width = _loc4_.width;
         this.controlPanel.y = _loc5_.y + _loc5_.height + 10;
         this.exitBg.width = _loc4_.width;
         this.exitButton.x = this.exitBg.width - this.exitButton.width - 7;
         x = _loc2_ - (width >> 1);
         y = _loc3_;
      }
      
      private function setViewHeight() : void
      {
         var _loc1_:Number = display.stage.stageHeight - 200;
         this.dmView.resize(_loc1_);
      }
      
      private function setTeamViewHeight() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = display.stage.stageHeight - 200;
         this.blueTeamView.resize(_loc1_);
         this.redTeamView.resize(_loc1_);
         if(this.blueTeamView.height + this.redTeamView.height > _loc1_)
         {
            _loc2_ = 0.5 * _loc1_;
            if(this.blueTeamView.height > _loc2_ && this.redTeamView.height > _loc2_)
            {
               this.blueTeamView.resize(_loc2_);
               this.redTeamView.resize(_loc2_);
            }
            else if(this.blueTeamView.height < _loc2_)
            {
               this.redTeamView.resize(_loc1_ - this.blueTeamView.height);
            }
            else
            {
               this.blueTeamView.resize(_loc1_ - this.redTeamView.height);
            }
         }
      }
      
      private function createExitPanel(param1:int) : void
      {
         this.controlPanel = new Sprite();
         this.exitBg = new ResultWindowGray();
         this.exitBg.width = width;
         this.controlPanel.addChild(this.exitBg);
         this.exitButton = new RedButton();
         this.exitBg.height = this.exitButton.height + 8;
         this.exitButton.addEventListener(MouseEvent.CLICK,this.onExitClick);
         this.exitButton.width = 96;
         this.exitButton.label = localeService.getText(TanksLocale.TEXT_BATTLE_EXIT);
         this.exitButton.x = this.exitBg.width - this.exitButton.width - 7;
         this.exitButton.y = 4;
         this.controlPanel.addChild(this.exitButton);
         if(param1 > 0)
         {
            this.continueButton = new GreenMediumButton();
            this.continueButton.addEventListener(MouseEvent.CLICK,this.onContinueClick);
            this.continueButton.width = 96;
            this.continueButton.label = localeService.getText(TanksLocale.TEXT_CONTINUE_BATTLE_TEXT);
            this.continueButton.x = 7;
            this.continueButton.y = 4;
            this.controlPanel.addChild(this.continueButton);
            this.restartLabel = new Label();
            this.restartLabel.text = this.matchBattle ? localeService.getText(TanksLocale.TEXT_BATTLE_FINISH_IN) : localeService.getText(TanksLocale.TEXT_BATTLE_RESTART) + ": ";
            this.controlPanel.addChild(this.restartLabel);
            this.restartLabel.x = 4;
            this.restartLabel.y = 10;
            this.restartLabel.visible = false;
            this.restartField = new TimeLimitField(-1,null,null,true);
            this.restartField.startCountdown(param1);
            this.controlPanel.addChild(this.restartField);
            this.restartField.x = this.restartLabel.x + this.restartLabel.width;
            this.restartField.y = 4;
            this.restartField.size = 22;
            this.restartField.visible = false;
         }
         addChild(this.controlPanel);
      }
      
      public function removePlayer(param1:String, param2:BattleTeam) : void
      {
         if(!visible)
         {
            return;
         }
         if(this.isTeamMode && this.blueTeamView && Boolean(this.redTeamView))
         {
            if(param2 == BattleTeam.BLUE)
            {
               this.blueTeamView.removePlayer(param1);
            }
            else
            {
               this.redTeamView.removePlayer(param1);
            }
            this.setTeamViewHeight();
         }
         else if(Boolean(this.dmView))
         {
            this.dmView.removePlayer(param1);
            this.setViewHeight();
         }
      }
      
      public function updatePlayersDm(param1:Vector.<ClientUserStat>) : void
      {
         if(visible)
         {
            this.dmView.updatePlayersInfo(param1);
            this.setViewHeight();
            this.onResize();
         }
      }
      
      public function updatePlayerDm(param1:ClientUserStat) : void
      {
         if(visible)
         {
            this.dmView.updatePlayerInfo(param1);
         }
      }
      
      public function updatePlayersTeam(param1:Vector.<ClientUserStat>, param2:BattleTeam) : void
      {
         if(visible)
         {
            if(param2 == BattleTeam.BLUE)
            {
               this.blueTeamView.updatePlayersInfo(param1);
            }
            else if(param2 == BattleTeam.RED)
            {
               this.redTeamView.updatePlayersInfo(param1);
            }
            this.setTeamViewHeight();
            this.onResize();
         }
      }
      
      public function updatePlayerTeam(param1:ClientUserStat) : void
      {
         if(visible)
         {
            if(param1.teamType == BattleTeam.BLUE)
            {
               this.blueTeamView.updatePlayerInfo(param1);
            }
            else if(param1.teamType == BattleTeam.RED)
            {
               this.redTeamView.updatePlayerInfo(param1);
            }
         }
      }
      
      private function onExitClick(param1:MouseEvent) : void
      {
         dispatchEvent(new ContinueBattleEvent(ContinueBattleEvent.EXIT));
      }
      
      private function onContinueClick(param1:MouseEvent) : void
      {
         if(!this.matchBattle)
         {
            this.restartLabel.visible = true;
            this.restartField.visible = true;
         }
         this.continueButton.visible = false;
         dispatchEvent(new ContinueBattleEvent(ContinueBattleEvent.CONTINUE));
      }
   }
}


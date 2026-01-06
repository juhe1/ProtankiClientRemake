package alternativa.tanks.camera.controllers.spectator
{
   import alternativa.math.Vector3;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.TankUnloadedEvent;
   import alternativa.tanks.battle.objects.tank.ClientTankState;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.scene3d.BattleScene3D;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.tank.spawn.ITankSpawner;
   import alternativa.tanks.services.bonusregion.IBonusRegionService;
   import alternativa.tanks.services.tankregistry.TankUsersRegistry;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import platform.client.fp10.core.type.AutoClosable;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import services.contextmenu.ContextMenuServiceEvent;
   import services.contextmenu.IContextMenuService;
   
   public class PlayerCamera implements KeyboardHandler, BattleEventListener, AutoClosable
   {
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var tankUsersRegistry:TankUsersRegistry;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var contextMenuService:IContextMenuService;
      
      [Inject]
      public static var bonusRegionService:IBonusRegionService;
      
      private var focusedUser:Tank;
      
      private var spectatorController:SpectatorCameraController;
      
      public function PlayerCamera(param1:SpectatorCameraController)
      {
         super();
         this.spectatorController = param1;
         battleEventDispatcher.addBattleEventListener(TankUnloadedEvent,this);
         contextMenuService.addEventListener(ContextMenuServiceEvent.FOCUS_ON_USER,this.onFocusOnUser);
      }
      
      private function onFocusOnUser(param1:ContextMenuServiceEvent) : void
      {
         var _loc2_:IGameObject = tankUsersRegistry.getUser(param1.userId);
         this.focusOnTank(this.getTank(_loc2_));
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         var _loc2_:Tank = TankUnloadedEvent(param1).tank;
         if(this.focusedUser == _loc2_)
         {
            this.unfocus();
         }
      }
      
      public function handleKeyUp(param1:KeyboardEvent) : void
      {
      }
      
      public function handleKeyDown(param1:KeyboardEvent) : void
      {
         this.onKey(param1);
      }
      
      private function onKey(param1:KeyboardEvent) : void
      {
         var _loc2_:Tank = null;
         if(param1.ctrlKey)
         {
            switch(param1.keyCode)
            {
               case Keyboard.F:
                  _loc2_ = this.findNearestUser(null);
                  break;
               case Keyboard.R:
                  _loc2_ = this.findNearestUser(BattleTeam.BLUE);
                  break;
               case Keyboard.B:
                  _loc2_ = this.findNearestUser(BattleTeam.RED);
                  break;
               case Keyboard.U:
                  this.unfocus();
            }
            if(Boolean(_loc2_))
            {
               this.focusOnTank(_loc2_);
            }
         }
         else if(Boolean(this.focusedUser))
         {
            switch(param1.keyCode)
            {
               case Keyboard.RIGHT:
                  this.nextPlayer();
                  break;
               case Keyboard.LEFT:
                  this.prevPlayer();
            }
         }
      }
      
      private function findNearestUser(param1:BattleTeam) : Tank
      {
         var _loc6_:IGameObject = null;
         var _loc7_:Tank = null;
         var _loc8_:Number = NaN;
         var _loc2_:Tank = null;
         var _loc3_:Number = 100000000000000000000;
         var _loc4_:GameCamera = this.battleScene().getCamera();
         var _loc5_:Vector3 = new Vector3(_loc4_.x,_loc4_.y,_loc4_.z);
         for each(_loc6_ in tankUsersRegistry.getUsers())
         {
            _loc7_ = this.getTank(_loc6_);
            if(_loc7_.teamType != param1 && _loc7_.state == ClientTankState.ACTIVE)
            {
               _loc8_ = _loc7_.getBody().state.position.distanceTo(_loc5_);
               if(_loc8_ < _loc3_)
               {
                  _loc3_ = _loc8_;
                  _loc2_ = _loc7_;
               }
            }
         }
         return _loc2_;
      }
      
      private function focusOnTank(param1:Tank) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.state != ClientTankState.ACTIVE)
         {
            return;
         }
         if(this.focusedUser == null)
         {
            battleService.activateFollowCamera();
         }
         else
         {
            this.onUnfocus();
         }
         this.focusedUser = param1;
         var _loc2_:ITankSpawner = ITankSpawner(this.focusedUser.user.adapt(ITankSpawner));
         _loc2_.setLocal();
         battleService.setCameraTarget(param1);
         bonusRegionService.changeTank(param1);
      }
      
      public function unfocus() : void
      {
         if(Boolean(this.focusedUser))
         {
            this.onUnfocus();
            this.focusedUser = null;
            this.spectatorController.activate();
            this.spectatorController.setPositionFromCamera();
            bonusRegionService.resetTank();
         }
      }
      
      private function onUnfocus() : void
      {
         var _loc1_:ITankSpawner = null;
         if(this.focusedUser != null)
         {
            _loc1_ = ITankSpawner(this.focusedUser.user.adapt(ITankSpawner));
            _loc1_.setRemote();
         }
      }
      
      private function nextPlayer() : void
      {
         this.focusOnTank(this.nextPlayerInDirection(1));
      }
      
      private function prevPlayer() : void
      {
         this.focusOnTank(this.nextPlayerInDirection(-1));
      }
      
      private function nextPlayerInDirection(param1:int) : Tank
      {
         var _loc5_:Tank = null;
         var _loc2_:Vector.<IGameObject> = tankUsersRegistry.getUsers();
         var _loc3_:int = int(_loc2_.indexOf(this.focusedUser.user));
         if(_loc3_ == -1)
         {
            return null;
         }
         var _loc4_:int = _loc3_;
         while(true)
         {
            _loc4_ += param1;
            if(_loc4_ == -1)
            {
               _loc4_ = _loc2_.length - 1;
            }
            else if(_loc4_ == _loc2_.length)
            {
               _loc4_ = 0;
            }
            _loc5_ = this.getTank(_loc2_[_loc4_]);
            if(_loc5_.teamType == this.focusedUser.teamType && _loc5_.state == ClientTankState.ACTIVE)
            {
               break;
            }
            if(_loc3_ == _loc4_)
            {
               return null;
            }
         }
         return _loc5_;
      }
      
      private function getTank(param1:IGameObject) : Tank
      {
         var _loc2_:ITankModel = ITankModel(param1.adapt(ITankModel));
         return _loc2_.getTank();
      }
      
      private function battleScene() : BattleScene3D
      {
         return battleService.getBattleScene3D();
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         battleEventDispatcher.removeBattleEventListener(TankUnloadedEvent,this);
         contextMenuService.removeEventListener(ContextMenuServiceEvent.FOCUS_ON_USER,this.onFocusOnUser);
      }
   }
}


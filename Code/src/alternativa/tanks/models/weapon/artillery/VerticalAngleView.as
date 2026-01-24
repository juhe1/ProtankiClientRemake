package alternativa.tanks.models.weapon.artillery
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.controllers.TurretController;
   import alternativa.tanks.display.usertitle.AngleBar;
   import alternativa.tanks.display.usertitle.PowerBar;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.services.battlegui.BattleGUIService;
   import alternativa.utils.removeDisplayObject;
   import flash.events.Event;
   import platform.client.fp10.core.type.AutoClosable;
   import platform.client.fp10.core.type.IGameObject;
   
   public class VerticalAngleView implements AutoClosable
   {
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var battleGuiService:BattleGUIService;
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private var angleBar:AngleBar;
      
      private var powerBar:PowerBar;
      
      private var turretController:TurretController;
      
      private var weapon:ArtilleryWeapon;
      
      public function VerticalAngleView(param1:IGameObject, param2:ArtilleryWeapon)
      {
         super();
         this.weapon = param2;
         var _loc3_:ITankModel = ITankModel(param1.adapt(ITankModel));
         this.turretController = _loc3_.getTurretController();
         this.angleBar = new AngleBar();
         this.powerBar = new PowerBar();
         this.angleBar.setAngle(param2.getInitialAngle());
         this.powerBar.setPower(0,0);
         battleGuiService.getGuiContainer().addChild(this.angleBar);
         battleGuiService.getGuiContainer().addChild(this.powerBar);
         this.angleBar.addEventListener(Event.ENTER_FRAME,this.update,false,int.MIN_VALUE);
         display.stage.addEventListener(Event.RESIZE,this.onResize,false,int.MIN_VALUE);
         this.onResize();
      }
      
      private function onResize(param1:Event = null) : void
      {
         var _loc2_:int = display.stage.stageWidth >> 1;
         this.angleBar.x = _loc2_ - 70;
         this.angleBar.y = (display.stage.stageHeight >> 1) + 50;
         this.powerBar.x = _loc2_ + 70;
         this.powerBar.y = this.angleBar.y;
      }
      
      private function update(param1:Event) : void
      {
         var _loc2_:int = 0;
         this.angleBar.setAngle(this.getDirectionInAngles());
         if(this.weapon.isCharging())
         {
            _loc2_ = int(battleService.getPhysicsTime());
            this.powerBar.setPower(this.weapon.getPower(_loc2_),this.weapon.getDiscretePower(_loc2_));
         }
         this.onResize();
      }
      
      private function getDirectionInAngles() : Number
      {
         return -this.turretController.getDirection() * 180 / Math.PI;
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         removeDisplayObject(this.angleBar);
         removeDisplayObject(this.powerBar);
         this.angleBar.removeEventListener(Event.ENTER_FRAME,this.update);
         display.stage.removeEventListener(Event.RESIZE,this.onResize);
      }
   }
}


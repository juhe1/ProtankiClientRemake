package alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.aim
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.ClientTankState;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.scene3d.Renderer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherEffects;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.IRocketLauncherWeapon;
   import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.RocketTargetPoint;
   import flash.display.BitmapData;
   
   public class RocketLauncherAim implements Renderer
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private static const position:Vector3 = new Vector3();
      
      private var visible:Boolean;
      
      private var spriteAim:Sprite3D;
      
      private var target:RocketTargetPoint;
      
      private var weapon:IRocketLauncherWeapon;
      
      private var aimShape:AimShape;
      
      private var effects:RocketLauncherEffects;
      
      private var targetWasLost:Boolean;
      
      public function RocketLauncherAim(param1:RocketTargetPoint, param2:IRocketLauncherWeapon)
      {
         super();
         this.target = param1;
         this.weapon = param2;
         this.effects = param2.getEffects();
         this.aimShape = new AimShape();
         var _loc3_:BitmapData = new BitmapData(this.aimShape.width,this.aimShape.height,true,0);
         this.aimShape.setTexture(_loc3_);
         var _loc4_:TextureMaterial = new TextureMaterial(_loc3_);
         _loc4_.uploadEveryFrame = true;
         this.spriteAim = new Sprite3D(this.aimShape.width,this.aimShape.height,_loc4_);
         this.spriteAim.perspectiveScale = false;
         this.spriteAim.useShadowMap = false;
         this.spriteAim.useLight = false;
         this.spriteAim.depthTest = false;
      }
      
      public function show() : void
      {
         if(!this.visible)
         {
            battleService.getBattleScene3D().getFrontContainer().addChild(this.spriteAim);
            battleService.getBattleScene3D().addRenderer(this,0);
            this.visible = true;
            this.targetWasLost = false;
            this.effects.playAimingSoundEffect();
         }
      }
      
      public function hide() : void
      {
         if(this.visible)
         {
            battleService.getBattleScene3D().getFrontContainer().removeChild(this.spriteAim);
            battleService.getBattleScene3D().removeRenderer(this,0);
            this.visible = false;
            this.effects.killAimingSoundEffect();
         }
      }
      
      public function render(param1:int, param2:int) : void
      {
         var _loc4_:GameCamera = null;
         var _loc5_:Vector3 = null;
         var _loc6_:Vector3 = null;
         var _loc3_:Tank = this.target.getTank();
         if(this.target.hasTarget() && _loc3_.state == ClientTankState.ACTIVE)
         {
            this.actualizeEffects();
            _loc4_ = battleService.getBattleScene3D().getCamera();
            _loc5_ = _loc4_.position;
            _loc6_ = _loc3_.getBody().state.position;
            if(_loc4_.fogNear > 0)
            {
               position.diff(_loc6_,_loc5_).setLength(_loc4_.fogNear * 0.5).add(_loc5_);
            }
            else
            {
               position.copy(_loc6_);
            }
            this.spriteAim.x = position.x;
            this.spriteAim.y = position.y;
            this.spriteAim.z = position.z;
            this.targetWasLost = this.target.isLost();
         }
         else
         {
            this.hide();
         }
      }
      
      private function actualizeEffects() : void
      {
         this.aimShape.update(this.target.isLost(),1 - this.weapon.getStatus());
         if(this.targetWasLost != this.target.isLost())
         {
            if(this.target.isLost())
            {
               this.effects.playTargetLostSoundEffect();
            }
            else
            {
               this.effects.playAimingSoundEffect();
            }
         }
      }
   }
}


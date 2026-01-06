package alternativa.tanks.models.weapon.machinegun.sfx
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.engine3d.AnimatedSprite3D;
   import alternativa.tanks.engine3d.TextureAnimation;
   
   public class Smoke extends ParticleSystem
   {
      
      private static const MAX_COUNT:int = 5;
      
      private var size:Number;
      
      private var speed:Number;
      
      private var top:Number;
      
      private var emitterPosition:Vector3 = new Vector3();
      
      private var animation:TextureAnimation;
      
      private var container:Scene3DContainer;
      
      public function Smoke(param1:Number, param2:Number, param3:Number, param4:Number)
      {
         super(SmokeParticle,param4,MAX_COUNT);
         this.size = param1;
         this.speed = param2;
         this.top = param3;
      }
      
      public function setAnimation(param1:TextureAnimation) : void
      {
         this.animation = param1;
      }
      
      public function setContainer(param1:Scene3DContainer) : void
      {
         this.container = param1;
      }
      
      public function setEmitterPosition(param1:Vector3) : void
      {
         this.emitterPosition.copy(param1);
      }
      
      override protected function onCreateParticle(param1:Particle) : void
      {
         var _loc2_:SmokeParticle = SmokeParticle(param1);
         _loc2_.init(this.size,this.emitterPosition,Math.random() * Math.PI * 2,this.animation);
         this.container.addChild(_loc2_.sprite);
      }
      
      override protected function onUpdateParticle(param1:Particle, param2:Number) : void
      {
         var _loc3_:SmokeParticle = null;
         _loc3_ = SmokeParticle(param1);
         var _loc4_:AnimatedSprite3D = _loc3_.sprite;
         _loc4_.update(param2);
         _loc4_.z += this.speed * param2;
         var _loc5_:Number = 1 - Math.abs(this.top / 2 - (_loc4_.z - _loc3_.initialZ)) * 2 / this.top;
         _loc4_.alpha = _loc5_;
         _loc4_.rotation = _loc3_.rotation + _loc5_ * 0.3;
         if(_loc4_.z - _loc3_.initialZ >= this.top)
         {
            _loc3_.alive = false;
         }
      }
      
      override protected function onDeleteParticle(param1:Particle) : void
      {
         this.container.removeChild(SmokeParticle(param1).sprite);
      }
      
      override public function clear() : void
      {
         super.clear();
         this.animation = null;
         this.container = null;
      }
   }
}


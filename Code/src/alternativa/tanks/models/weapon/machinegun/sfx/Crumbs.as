package alternativa.tanks.models.weapon.machinegun.sfx
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   
   public class Crumbs extends ParticleSystem
   {
      
      private static const MIN_PARTICLE_SIZE:Number = 130;
      
      private static const SPEED:Number = 6;
      
      private static const MAX_TIME:Number = 0.2;
      
      private static const GRAVITY:Number = 20;
      
      private static const INTERVAL:int = 0.1;
      
      private static const MAX_COUNT:int = 5;
      
      private static const MIN_SCALE:Number = 0.1;
      
      private static const DIRECTION:Vector3 = new Vector3();
      
      private var emitterPosition:Vector3 = new Vector3();
      
      private var material:TextureMaterial;
      
      private var container:Scene3DContainer;
      
      public function Crumbs()
      {
         super(CrumbsParticle,INTERVAL,MAX_COUNT);
      }
      
      public function setMaterial(param1:TextureMaterial) : void
      {
         this.material = param1;
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
         var _loc2_:CrumbsParticle = CrumbsParticle(param1);
         var _loc3_:Number = MIN_PARTICLE_SIZE + Math.random() * MIN_PARTICLE_SIZE / 2;
         var _loc4_:Sprite3D = _loc2_.sprite;
         DIRECTION.x = Math.random() * 2 - 1;
         DIRECTION.y = -Math.random();
         DIRECTION.z = Math.random() * 2 - 1;
         DIRECTION.normalize();
         DIRECTION.scale(SPEED);
         _loc2_.init(_loc3_,this.emitterPosition,DIRECTION,this.material);
         this.container.addChild(_loc4_);
      }
      
      override protected function onUpdateParticle(param1:Particle, param2:Number) : void
      {
         var _loc3_:CrumbsParticle = CrumbsParticle(param1);
         var _loc4_:Sprite3D = _loc3_.sprite;
         var _loc5_:Vector3 = _loc3_.direction;
         _loc5_.z -= GRAVITY * param2;
         _loc4_.x += _loc5_.x;
         _loc4_.y += _loc5_.y;
         _loc4_.z += _loc5_.z;
         _loc3_.time += param2;
         if(_loc3_.time > MAX_TIME)
         {
            _loc3_.time = MAX_TIME;
         }
         _loc4_.alpha = 1 - _loc3_.time / MAX_TIME;
         var _loc6_:Number = 1 - _loc4_.alpha;
         if(_loc6_ < MIN_SCALE)
         {
            _loc6_ = MIN_SCALE;
         }
         _loc4_.scaleX = _loc6_;
         _loc4_.scaleY = _loc6_;
         _loc4_.scaleZ = _loc6_;
         if(_loc4_.alpha <= 0)
         {
            _loc3_.alive = false;
         }
      }
      
      override protected function onDeleteParticle(param1:Particle) : void
      {
         this.container.removeChild(CrumbsParticle(param1).sprite);
      }
      
      override public function clear() : void
      {
         super.clear();
         this.material = null;
         this.container = null;
      }
   }
}


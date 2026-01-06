package alternativa.tanks.models.tank.ultimate.hornet
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import flash.geom.Vector3D;
   
   public class RadarEffect extends PooledObject implements GraphicEffect
   {
      
      private static const SIZE:int = 600;
      
      public static const FADE:Number = 0.5;
      
      public static const MIN:Number = 0.05;
      
      public static const RANGE:Number = 1 - MIN;
      
      public static const HALF:Number = RANGE / 2;
      
      public static const OFFSET:Number = 330;
      
      public static const SPEED:Number = 0.5;
      
      private static const vector:Vector3D = new Vector3D();
      
      private var container:Scene3DContainer;
      
      private var target:Object3D;
      
      private var life:Number;
      
      private var ring1:Sprite3D;
      
      private var ring2:Sprite3D;
      
      private var ring3:Sprite3D;
      
      private var time:Number;
      
      public function RadarEffect(param1:Pool)
      {
         super(param1);
         this.ring1 = new Sprite3D(SIZE,SIZE);
         this.ring1.useLight = false;
         this.ring1.useShadowMap = false;
         this.ring1.softAttenuation = 200;
         this.ring2 = new Sprite3D(SIZE,SIZE);
         this.ring2.useLight = false;
         this.ring2.useShadowMap = false;
         this.ring2.rotation = Math.PI;
         this.ring2.scaleX = MIN + RANGE / 3;
         this.ring2.scaleY = MIN + RANGE / 3;
         this.ring2.scaleZ = MIN + RANGE / 3;
         this.ring2.softAttenuation = 200;
         this.ring3 = new Sprite3D(SIZE,SIZE);
         this.ring3.useLight = false;
         this.ring3.useShadowMap = false;
         this.ring3.rotation = Math.PI;
         this.ring3.scaleX = 1 - RANGE / 3;
         this.ring3.scaleY = 1 - RANGE / 3;
         this.ring3.scaleZ = 1 - RANGE / 3;
         this.ring3.softAttenuation = 200;
      }
      
      public function init(param1:TextureMaterial, param2:Object3D, param3:Number) : *
      {
         this.target = param2;
         this.life = param3;
         this.ring1.material = param1;
         this.ring2.material = param1;
         this.ring3.material = param1;
         this.time = 0;
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = param1;
         param1.addChild(this.ring1);
         param1.addChild(this.ring2);
         param1.addChild(this.ring3);
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         var _loc6_:Number = NaN;
         var _loc3_:Number = param1 / 1000;
         this.time += _loc3_;
         vector.x = param2.x - this.target.x;
         vector.y = param2.y - this.target.y;
         vector.z = param2.z - this.target.z + 50;
         vector.normalize();
         this.ring1.x = this.target.x + vector.x * OFFSET;
         this.ring1.y = this.target.y + vector.y * OFFSET;
         this.ring1.z = this.target.z + vector.z * OFFSET + 50;
         this.ring2.x = this.ring1.x;
         this.ring2.y = this.ring1.y;
         this.ring2.z = this.ring1.z;
         this.ring3.x = this.ring1.x;
         this.ring3.y = this.ring1.y;
         this.ring3.z = this.ring1.z;
         var _loc4_:Number = _loc3_ * SPEED;
         var _loc5_:Number = this.ring1.scaleX + _loc4_;
         if(_loc5_ > 1)
         {
            _loc5_ = MIN;
         }
         this.ring1.scaleX = _loc5_;
         this.ring1.scaleY = _loc5_;
         this.ring1.scaleZ = _loc5_;
         this.ring1.alpha = 1 - Math.abs(MIN + HALF - _loc5_) / HALF;
         _loc5_ = this.ring2.scaleX + _loc4_;
         if(_loc5_ > 1)
         {
            _loc5_ = MIN;
         }
         this.ring2.scaleX = _loc5_;
         this.ring2.scaleY = _loc5_;
         this.ring2.scaleZ = _loc5_;
         this.ring2.alpha = 1 - Math.abs(MIN + HALF - _loc5_) / HALF;
         _loc5_ = this.ring3.scaleX + _loc4_;
         if(_loc5_ > 1)
         {
            _loc5_ = MIN;
         }
         this.ring3.scaleX = _loc5_;
         this.ring3.scaleY = _loc5_;
         this.ring3.scaleZ = _loc5_;
         this.ring3.alpha = 1 - Math.abs(MIN + HALF - _loc5_) / HALF;
         if(this.time <= FADE)
         {
            _loc6_ = this.time / FADE;
            this.ring1.alpha *= _loc6_;
            this.ring2.alpha *= _loc6_;
            this.ring3.alpha *= _loc6_;
            return true;
         }
         if(this.time <= this.life - FADE)
         {
            _loc6_ = 1;
            this.ring1.alpha *= _loc6_;
            this.ring2.alpha *= _loc6_;
            this.ring3.alpha *= _loc6_;
            return true;
         }
         _loc6_ = 1 - (this.time - this.life + FADE) / FADE;
         this.ring1.alpha *= _loc6_;
         this.ring2.alpha *= _loc6_;
         this.ring3.alpha *= _loc6_;
         if(_loc6_ > 0)
         {
            return true;
         }
         return false;
      }
      
      public function kill() : void
      {
         this.ring1.alpha = 0;
         this.ring2.alpha = 0;
         this.ring3.alpha = 0;
      }
      
      public function destroy() : void
      {
         this.container.removeChild(this.ring1);
         this.container.removeChild(this.ring2);
         this.container.removeChild(this.ring3);
         this.ring1.material = null;
         this.ring2.material = null;
         this.ring3.material = null;
         this.container = null;
         this.target = null;
         recycle();
      }
   }
}


package alternativa.tanks.models.tank.ultimate.viking
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import flash.display.BlendMode;
   import flash.geom.Vector3D;
   
   public class BurningEffect extends PooledObject implements GraphicEffect
   {
      
      private static const FLAME_SIZE:int = 300;
      
      private static const SMOKE_SIZE:int = 500;
      
      public static const FADE:Number = 0.5;
      
      public static const MIN:Number = 0.7;
      
      public static const HALF:Number = (1 - MIN) / 2;
      
      public static const FLAME_OFFSET:Number = 330;
      
      public static const SMOKE_OFFSET:Number = 300;
      
      private static const vector:Vector3D = new Vector3D();
      
      private var container:Scene3DContainer;
      
      private var target:Object3D;
      
      private var life:Number;
      
      private var flame1:Sprite3D;
      
      private var flame2:Sprite3D;
      
      private var smoke1:Sprite3D;
      
      private var smoke2:Sprite3D;
      
      private var time:Number;
      
      public function BurningEffect(param1:Pool)
      {
         super(param1);
         this.flame1 = new Sprite3D(FLAME_SIZE,FLAME_SIZE);
         this.flame1.useLight = false;
         this.flame1.useShadowMap = false;
         this.flame1.blendMode = BlendMode.ADD;
         this.flame1.softAttenuation = 200;
         this.flame2 = new Sprite3D(FLAME_SIZE,FLAME_SIZE);
         this.flame2.useLight = false;
         this.flame2.useShadowMap = false;
         this.flame2.blendMode = BlendMode.ADD;
         this.flame2.rotation = Math.PI;
         this.flame2.softAttenuation = 200;
         this.smoke1 = new Sprite3D(SMOKE_SIZE,SMOKE_SIZE);
         this.smoke1.useLight = false;
         this.smoke1.useShadowMap = false;
         this.smoke1.rotation = Math.PI / 2;
         this.smoke1.softAttenuation = 200;
         this.smoke2 = new Sprite3D(SMOKE_SIZE,SMOKE_SIZE);
         this.smoke2.useLight = false;
         this.smoke2.useShadowMap = false;
         this.smoke2.rotation = -Math.PI / 2;
         this.smoke2.softAttenuation = 200;
         this.flame1.alpha = 0.7;
         this.flame2.alpha = 0.7;
         this.smoke1.alpha = 0.7;
         this.smoke2.alpha = 0.7;
      }
      
      public function init(param1:TextureMaterial, param2:TextureMaterial, param3:Object3D, param4:Number) : *
      {
         this.target = param3;
         this.life = param4;
         this.flame1.material = param1;
         this.flame2.material = param1;
         this.smoke1.material = param2;
         this.smoke2.material = param2;
         this.flame2.scaleX = MIN + HALF;
         this.flame2.scaleY = MIN + HALF;
         this.flame2.scaleZ = MIN + HALF;
         this.smoke2.scaleX = MIN + HALF;
         this.smoke2.scaleY = MIN + HALF;
         this.smoke2.scaleZ = MIN + HALF;
         this.time = 0;
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = param1;
         param1.addChild(this.flame1);
         param1.addChild(this.flame2);
         param1.addChild(this.smoke1);
         param1.addChild(this.smoke2);
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
         this.flame1.x = this.target.x + vector.x * FLAME_OFFSET;
         this.flame1.y = this.target.y + vector.y * FLAME_OFFSET;
         this.flame1.z = this.target.z + vector.z * FLAME_OFFSET + 50;
         this.flame2.x = this.flame1.x;
         this.flame2.y = this.flame1.y;
         this.flame2.z = this.flame1.z;
         this.smoke1.x = this.target.x + vector.x * SMOKE_OFFSET;
         this.smoke1.y = this.target.y + vector.y * SMOKE_OFFSET;
         this.smoke1.z = this.target.z + vector.z * SMOKE_OFFSET + 50;
         this.smoke2.x = this.smoke1.x;
         this.smoke2.y = this.smoke1.y;
         this.smoke2.z = this.smoke1.z;
         var _loc4_:Number = _loc3_ * 0.4;
         var _loc5_:Number = this.flame1.scaleX + _loc4_;
         if(_loc5_ > 1)
         {
            _loc5_ = MIN;
         }
         this.flame1.scaleX = _loc5_;
         this.flame1.scaleY = _loc5_;
         this.flame1.scaleZ = _loc5_;
         this.flame1.alpha = 1 - Math.abs(MIN + HALF - _loc5_) / HALF;
         _loc5_ = this.flame2.scaleX + _loc4_;
         if(_loc5_ > 1)
         {
            _loc5_ = MIN;
         }
         this.flame2.scaleX = _loc5_;
         this.flame2.scaleY = _loc5_;
         this.flame2.scaleZ = _loc5_;
         this.flame2.alpha = 1 - Math.abs(MIN + HALF - _loc5_) / HALF;
         _loc5_ = this.smoke1.scaleX - _loc4_;
         if(_loc5_ < MIN)
         {
            _loc5_ = 1;
         }
         this.smoke1.scaleX = _loc5_;
         this.smoke1.scaleY = _loc5_;
         this.smoke1.scaleZ = _loc5_;
         this.smoke1.alpha = 1 - Math.abs(MIN + HALF - _loc5_) / HALF;
         _loc5_ = this.smoke2.scaleX - _loc4_;
         if(_loc5_ < MIN)
         {
            _loc5_ = 1;
         }
         this.smoke2.scaleX = _loc5_;
         this.smoke2.scaleY = _loc5_;
         this.smoke2.scaleZ = _loc5_;
         this.smoke2.alpha = 1 - Math.abs(MIN + HALF - _loc5_) / HALF;
         if(this.time <= FADE)
         {
            _loc6_ = this.time / FADE;
            this.flame1.alpha *= _loc6_;
            this.flame2.alpha *= _loc6_;
            this.smoke1.alpha *= _loc6_;
            this.smoke2.alpha *= _loc6_;
            return true;
         }
         if(this.time <= this.life - FADE)
         {
            _loc6_ = 1;
            this.flame1.alpha *= _loc6_;
            this.flame2.alpha *= _loc6_;
            this.smoke1.alpha *= _loc6_;
            this.smoke2.alpha *= _loc6_;
            return true;
         }
         _loc6_ = 1 - (this.time - this.life + FADE) / FADE;
         this.flame1.alpha *= _loc6_;
         this.flame2.alpha *= _loc6_;
         this.smoke1.alpha *= _loc6_;
         this.smoke2.alpha *= _loc6_;
         if(_loc6_ > 0)
         {
            return true;
         }
         return false;
      }
      
      public function destroy() : void
      {
         this.container.removeChild(this.flame1);
         this.container.removeChild(this.flame2);
         this.container.removeChild(this.smoke1);
         this.container.removeChild(this.smoke2);
         this.flame1.material = null;
         this.flame2.material = null;
         this.smoke2.material = null;
         this.smoke1.material = null;
         this.container = null;
         this.target = null;
         recycle();
      }
      
      public function kill() : void
      {
         this.flame1.alpha = 0;
         this.flame2.alpha = 0;
         this.smoke2.alpha = 0;
         this.smoke1.alpha = 0;
      }
   }
}


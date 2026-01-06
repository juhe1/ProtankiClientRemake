package alternativa.tanks.models.tank.ultimate.mammoth
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
   
   public class FieldEffect extends PooledObject implements GraphicEffect
   {
      
      private static const SHINE_SIZE:int = 600;
      
      public static const SHINE_OFFSET:Number = 300;
      
      private static const HEART_SIZE:int = 250;
      
      public static const HEART_OFFSET:Number = 400;
      
      public static const FADE:Number = 0.5;
      
      public static const MIN:Number = 0.3;
      
      public static const HALF:Number = (1 - MIN) / 2;
      
      private static const vector:Vector3D = new Vector3D();
      
      private var container:Scene3DContainer;
      
      private var target:Object3D;
      
      private var life:Number;
      
      private var shine1:Sprite3D;
      
      private var shine2:Sprite3D;
      
      private var heart:Sprite3D;
      
      private var time:Number;
      
      public function FieldEffect(param1:Pool)
      {
         super(param1);
         this.shine1 = new Sprite3D(SHINE_SIZE,SHINE_SIZE);
         this.shine2 = new Sprite3D(SHINE_SIZE,SHINE_SIZE);
         this.heart = new Sprite3D(HEART_SIZE,HEART_SIZE);
         this.shine1.useLight = false;
         this.shine1.useShadowMap = false;
         this.shine1.blendMode = BlendMode.ADD;
         this.shine1.softAttenuation = 200;
         this.shine2.useLight = false;
         this.shine2.useShadowMap = false;
         this.shine2.blendMode = BlendMode.ADD;
         this.shine2.rotation = Math.PI;
         this.shine2.softAttenuation = 200;
         this.heart.useLight = false;
         this.heart.useShadowMap = false;
         this.heart.blendMode = BlendMode.ADD;
         this.heart.softAttenuation = 200;
      }
      
      public function init(param1:TextureMaterial, param2:TextureMaterial, param3:Object3D, param4:Number) : *
      {
         this.target = param3;
         this.life = param4;
         this.shine1.material = param1;
         this.shine2.material = param1;
         this.heart.material = param2;
         this.shine2.scaleX = MIN + HALF;
         this.shine2.scaleY = MIN + HALF;
         this.shine2.scaleZ = MIN + HALF;
         this.time = 0;
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = param1;
         param1.addChild(this.shine1);
         param1.addChild(this.shine2);
         param1.addChild(this.heart);
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
         this.shine1.x = this.target.x + vector.x * SHINE_OFFSET;
         this.shine1.y = this.target.y + vector.y * SHINE_OFFSET;
         this.shine1.z = this.target.z + vector.z * SHINE_OFFSET + 50;
         this.shine2.x = this.shine1.x;
         this.shine2.y = this.shine1.y;
         this.shine2.z = this.shine1.z;
         this.heart.x = this.target.x + vector.x * HEART_OFFSET;
         this.heart.y = this.target.y + vector.y * HEART_OFFSET;
         this.heart.z = this.target.z + vector.z * HEART_OFFSET + 50;
         var _loc4_:Number = _loc3_ * 0.75;
         var _loc5_:Number = this.shine1.scaleX + _loc4_;
         if(_loc5_ > 1)
         {
            _loc5_ = MIN;
         }
         this.shine1.scaleX = _loc5_;
         this.shine1.scaleY = _loc5_;
         this.shine1.scaleZ = _loc5_;
         this.shine1.alpha = 1 - Math.abs(MIN + HALF - _loc5_) / HALF;
         this.shine1.alpha = Math.sqrt(this.shine1.alpha);
         _loc5_ = this.shine2.scaleX + _loc4_;
         if(_loc5_ > 1)
         {
            _loc5_ = MIN;
         }
         this.shine2.scaleX = _loc5_;
         this.shine2.scaleY = _loc5_;
         this.shine2.scaleZ = _loc5_;
         this.shine2.alpha = 1 - Math.abs(MIN + HALF - _loc5_) / HALF;
         this.shine2.alpha = Math.sqrt(this.shine2.alpha);
         _loc5_ = 0.9 + Math.sin(this.time * 8) / 10;
         this.heart.scaleX = _loc5_;
         this.heart.scaleY = _loc5_;
         this.heart.scaleZ = _loc5_;
         this.heart.alpha = _loc5_;
         if(this.heart.alpha > 1)
         {
            this.heart.alpha = 1;
         }
         if(this.time <= FADE)
         {
            _loc6_ = this.time / FADE;
            this.shine1.alpha *= _loc6_;
            this.shine2.alpha *= _loc6_;
            this.heart.alpha *= _loc6_;
            return true;
         }
         if(this.time <= this.life - FADE)
         {
            _loc6_ = 1;
            this.shine1.alpha *= _loc6_;
            this.shine2.alpha *= _loc6_;
            this.heart.alpha *= _loc6_;
            return true;
         }
         _loc6_ = 1 - (this.time - this.life + FADE) / FADE;
         this.shine1.alpha *= _loc6_;
         this.shine2.alpha *= _loc6_;
         this.heart.alpha *= _loc6_;
         if(_loc6_ > 0)
         {
            return true;
         }
         return false;
      }
      
      public function destroy() : void
      {
         this.container.removeChild(this.shine1);
         this.container.removeChild(this.shine2);
         this.container.removeChild(this.heart);
         this.shine1.material = null;
         this.shine2.material = null;
         this.heart.material = null;
         this.container = null;
         this.target = null;
         recycle();
      }
      
      public function kill() : void
      {
         this.shine1.alpha = 0;
         this.shine2.alpha = 0;
         this.heart.alpha = 0;
      }
   }
}


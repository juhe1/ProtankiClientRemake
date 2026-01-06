package alternativa.tanks.models.tank.ultimate.hunter
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
   
   public class EnergyEffect extends PooledObject implements GraphicEffect
   {
      
      public static const FADE:Number = 0.17;
      
      public static const OFFSET:Number = 300;
      
      public static const MIN:Number = 0.4;
      
      private static const vector:Vector3D = new Vector3D();
      
      private var container:Scene3DContainer;
      
      private var target:Object3D;
      
      private var charging:Number;
      
      private var secondBegin:Number;
      
      private var firstEnd:Number;
      
      private var energy1:Sprite3D;
      
      private var energy2:Sprite3D;
      
      private var time:Number;
      
      public function EnergyEffect(param1:Pool)
      {
         super(param1);
         this.energy1 = new Sprite3D(700,700);
         this.energy1.useLight = false;
         this.energy1.useShadowMap = false;
         this.energy1.blendMode = BlendMode.ADD;
         this.energy1.softAttenuation = 200;
         this.energy2 = new Sprite3D(700,700);
         this.energy2.useLight = false;
         this.energy2.useShadowMap = false;
         this.energy2.blendMode = BlendMode.ADD;
         this.energy2.rotation = Math.PI;
         this.energy2.softAttenuation = 200;
      }
      
      public function init(param1:TextureMaterial, param2:Object3D, param3:Number) : *
      {
         this.target = param2;
         this.charging = param3;
         this.secondBegin = param3 * 0.33;
         this.firstEnd = param3 - param3 * 0.13;
         this.energy1.material = param1;
         this.energy2.material = param1;
         this.time = 0;
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = param1;
         param1.addChild(this.energy1);
         param1.addChild(this.energy2);
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:Number = param1 / 1000;
         this.time += _loc3_;
         vector.x = param2.x - this.target.x;
         vector.y = param2.y - this.target.y;
         vector.z = param2.z - this.target.z + 50;
         vector.normalize();
         this.energy1.x = this.target.x + vector.x * OFFSET;
         this.energy1.y = this.target.y + vector.y * OFFSET;
         this.energy1.z = this.target.z + vector.z * OFFSET + 100;
         this.energy2.x = this.energy1.x;
         this.energy2.y = this.energy1.y;
         this.energy2.z = this.energy1.z;
         if(this.time <= this.charging)
         {
            _loc4_ = this.time / this.firstEnd;
            if(_loc4_ > 1)
            {
               _loc4_ = 1;
            }
            _loc5_ = MIN + (1 - MIN) * _loc4_;
            this.energy1.scaleX = _loc5_;
            this.energy1.scaleY = _loc5_;
            this.energy1.scaleZ = _loc5_;
            this.energy1.alpha = _loc4_;
            _loc4_ = (this.time - this.secondBegin) / (this.charging - this.secondBegin);
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _loc5_ = MIN + (1 - MIN) * _loc4_;
            this.energy2.scaleX = _loc5_;
            this.energy2.scaleY = _loc5_;
            this.energy2.scaleZ = _loc5_;
            this.energy2.alpha = _loc4_;
            return true;
         }
         if(this.time <= this.charging + FADE)
         {
            _loc4_ = 1 - (this.time - this.charging) / FADE;
            this.energy1.alpha = _loc4_;
            this.energy2.alpha = _loc4_;
            return true;
         }
         return false;
      }
      
      public function destroy() : void
      {
         this.container.removeChild(this.energy1);
         this.container.removeChild(this.energy2);
         this.energy1.material = null;
         this.energy2.material = null;
         this.container = null;
         this.target = null;
         recycle();
      }
      
      public function kill() : void
      {
         this.energy1.alpha = 0;
         this.energy2.alpha = 0;
      }
   }
}


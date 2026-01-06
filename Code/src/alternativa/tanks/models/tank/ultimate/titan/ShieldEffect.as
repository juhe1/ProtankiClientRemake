package alternativa.tanks.models.tank.ultimate.titan
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   
   public class ShieldEffect extends PooledObject implements GraphicEffect
   {
      
      private static const BASE_SCALE:int = 6;
      
      private static const PULSATION_FREQ:int = 4;
      
      private static const PULSATION_AMPLITUDE:Number = 0.25;
      
      public static const FADE:Number = 0.5;
      
      private var container:Scene3DContainer;
      
      private var target:Object3D;
      
      private var life:Number;
      
      private var sphere:Mesh = null;
      
      private var time:Number;
      
      public function ShieldEffect(param1:Pool)
      {
         super(param1);
      }
      
      public function init(param1:TextureMaterial, param2:Mesh, param3:Object3D, param4:Number) : *
      {
         this.target = param3;
         this.life = param4;
         if(this.sphere == null)
         {
            this.sphere = param2.clone() as Mesh;
            this.sphere.shadowMapAlphaThreshold = 2;
            this.sphere.depthMapAlphaThreshold = 2;
            this.sphere.useLight = false;
            this.sphere.useShadowMap = false;
            this.sphere.softAttenuation = 200;
         }
         this.sphere.setMaterialToAllFaces(param1);
         this.sphere.scaleX = BASE_SCALE;
         this.sphere.scaleY = BASE_SCALE;
         this.sphere.scaleZ = BASE_SCALE;
         this.time = 0;
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = param1;
         param1.addChild(this.sphere);
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         var _loc3_:Number = param1 / 1000;
         this.time += _loc3_;
         this.sphere.x = this.target.x;
         this.sphere.y = this.target.y;
         this.sphere.z = this.target.z + 50;
         var _loc4_:Number = BASE_SCALE + Math.sin(this.time * PULSATION_FREQ) * PULSATION_AMPLITUDE;
         this.sphere.scaleX = _loc4_;
         this.sphere.scaleY = _loc4_;
         this.sphere.scaleZ = _loc4_;
         if(this.time <= FADE)
         {
            this.sphere.alpha = this.time / FADE;
            return true;
         }
         if(this.time <= this.life - FADE)
         {
            this.sphere.alpha = 1;
            return true;
         }
         this.sphere.alpha = 1 - (this.time - this.life + FADE) / FADE;
         if(this.sphere.alpha > 0)
         {
            return true;
         }
         return false;
      }
      
      public function destroy() : void
      {
         this.container.removeChild(this.sphere);
         this.sphere.setMaterialToAllFaces(null);
         this.container = null;
         this.target = null;
         recycle();
      }
      
      public function kill() : void
      {
         this.sphere.alpha = 0;
      }
   }
}


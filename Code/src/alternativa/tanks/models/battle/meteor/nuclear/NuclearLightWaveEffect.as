package alternativa.tanks.models.battle.meteor.nuclear
{
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import flash.display.BlendMode;
   
   public class NuclearLightWaveEffect extends PooledObject implements GraphicEffect
   {
      
      private var container:Scene3DContainer = null;
      
      private var wave:Mesh = new Mesh();
      
      private var time:Number = 0;
      
      private var epicenter:Vector3 = new Vector3();
      
      public function NuclearLightWaveEffect(param1:Pool)
      {
         super(param1);
      }
      
      public function init(param1:Vector3, param2:TextureMaterial) : void
      {
         this.epicenter.copy(param1);
         var _loc3_:Number = 2000;
         var _loc4_:Vertex = this.wave.addVertex(-_loc3_,_loc3_,0,0,0);
         var _loc5_:Vertex = this.wave.addVertex(-_loc3_,-_loc3_,0,0,1);
         var _loc6_:Vertex = this.wave.addVertex(_loc3_,-_loc3_,0,1,1);
         var _loc7_:Vertex = this.wave.addVertex(_loc3_,_loc3_,0,1,0);
         this.wave.addQuadFace(_loc4_,_loc5_,_loc6_,_loc7_,param2);
         this.wave.addQuadFace(_loc4_,_loc7_,_loc6_,_loc5_,param2);
         this.wave.calculateFacesNormals();
         this.wave.calculateBounds();
         this.wave.useLight = false;
         this.wave.useShadowMap = false;
         this.wave.shadowMapAlphaThreshold = 2;
         this.wave.depthMapAlphaThreshold = 2;
         this.wave.blendMode = BlendMode.ADD;
         this.wave.softAttenuation = 80;
         this.wave.scaleX = 1;
         this.wave.scaleY = 1;
         this.wave.scaleZ = 1;
         this.time = 0;
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = param1;
         param1.addChild(this.wave);
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         var _loc3_:Number = param1 / 1000;
         this.time += _loc3_;
         this.wave.x = this.epicenter.x;
         this.wave.y = this.epicenter.y;
         this.wave.z = this.epicenter.z + 80;
         var _loc4_:Number = NuclearBangEffect.KEY1 / 3;
         var _loc5_:Number = 10 / 60;
         var _loc6_:Number = 20 / 60;
         if(this.time <= _loc4_)
         {
            this.wave.alpha = this.time / _loc5_;
            this.wave.visible = true;
         }
         else if(this.time <= _loc6_)
         {
            this.wave.alpha = 1 - (this.time - _loc5_) / (_loc6_ - _loc5_);
            this.wave.visible = true;
         }
         else
         {
            this.wave.visible = false;
         }
         var _loc7_:Number = _loc3_ * 6;
         this.wave.scaleX += _loc7_;
         this.wave.scaleY += _loc7_;
         return this.wave.visible;
      }
      
      public function destroy() : void
      {
         if(this.container != null)
         {
            this.container.removeChild(this.wave);
            this.container = null;
         }
         this.wave.setMaterialToAllFaces(null);
         recycle();
      }
      
      public function kill() : void
      {
         this.destroy();
      }
   }
}


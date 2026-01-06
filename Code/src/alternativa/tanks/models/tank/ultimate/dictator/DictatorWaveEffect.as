package alternativa.tanks.models.tank.ultimate.dictator
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import flash.display.BlendMode;
   
   public class DictatorWaveEffect extends PooledObject implements GraphicEffect
   {
      
      public static const MID:Number = 30 / 60;
      
      public static const END:Number = 60 / 60;
      
      private static const SIZE:Number = 800;
      
      private static const MIN:Number = 0.3;
      
      private var mesh:Mesh = new Mesh();
      
      private var target:Object3D;
      
      private var container:Scene3DContainer;
      
      private var time:Number;
      
      public function DictatorWaveEffect(param1:Pool)
      {
         super(param1);
         this.mesh = new Mesh();
         var _loc2_:Vertex = this.mesh.addVertex(-SIZE,SIZE,0,0,0);
         var _loc3_:Vertex = this.mesh.addVertex(-SIZE,-SIZE,0,0,1);
         var _loc4_:Vertex = this.mesh.addVertex(SIZE,-SIZE,0,1,1);
         var _loc5_:Vertex = this.mesh.addVertex(SIZE,SIZE,0,1,0);
         this.mesh.addQuadFace(_loc2_,_loc3_,_loc4_,_loc5_);
         this.mesh.addQuadFace(_loc2_,_loc5_,_loc4_,_loc3_);
         this.mesh.calculateFacesNormals();
         this.mesh.calculateBounds();
         this.mesh.useLight = false;
         this.mesh.useShadowMap = false;
         this.mesh.shadowMapAlphaThreshold = 2;
         this.mesh.depthMapAlphaThreshold = 2;
         this.mesh.blendMode = BlendMode.ADD;
         this.mesh.softAttenuation = 80;
      }
      
      public function init(param1:TextureMaterial, param2:Object3D) : void
      {
         this.target = param2;
         this.mesh.setMaterialToAllFaces(param1);
         this.time = 0;
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = param1;
         param1.addChild(this.mesh);
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         this.time += param1 / 1000;
         this.mesh.x = this.target.x;
         this.mesh.y = this.target.y;
         this.mesh.z = this.target.z + 80;
         var _loc3_:Number = MIN + (1 - MIN) * this.time / END;
         if(this.time <= MID)
         {
            this.mesh.scaleX = _loc3_;
            this.mesh.scaleY = _loc3_;
            this.mesh.alpha = this.time / MID;
            return true;
         }
         if(this.time <= END)
         {
            this.mesh.scaleX = _loc3_;
            this.mesh.scaleY = _loc3_;
            this.mesh.alpha = 1 - (this.time - MID) / (END - MID);
            return true;
         }
         return false;
      }
      
      public function destroy() : void
      {
         this.container.removeChild(this.mesh);
         this.mesh.setMaterialToAllFaces(null);
         recycle();
      }
      
      public function kill() : void
      {
         this.mesh.alpha = 0;
      }
   }
}


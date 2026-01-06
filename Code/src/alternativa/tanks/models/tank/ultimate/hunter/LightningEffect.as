package alternativa.tanks.models.tank.ultimate.hunter
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Object3DContainer;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import flash.display.BlendMode;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   
   public class LightningEffect extends PooledObject implements GraphicEffect
   {
      
      public static const MID:Number = 14 / 60;
      
      public static const END:Number = 50 / 60;
      
      public static const SOURCE_Z_OFFSET:Number = 200;
      
      private static const TARGET_Z_OFFSET:int = 20;
      
      private static const SIZE:Number = 400;
      
      private static const vector:Vector3D = new Vector3D();
      
      private var container:Scene3DContainer;
      
      private var target:Object3D;
      
      private var source:Object3D;
      
      private var meshContainer:Object3DContainer;
      
      private var mesh:Mesh;
      
      private var time:Number;
      
      public function LightningEffect(param1:Pool)
      {
         super(param1);
         this.meshContainer = new Object3DContainer();
         this.mesh = new Mesh();
         var _loc2_:Vertex = this.mesh.addVertex(-SIZE / 2,0,SIZE,0,0);
         var _loc3_:Vertex = this.mesh.addVertex(-SIZE / 2,0,0,0,1);
         var _loc4_:Vertex = this.mesh.addVertex(SIZE / 2,0,0,1,1);
         var _loc5_:Vertex = this.mesh.addVertex(SIZE / 2,0,SIZE,1,0);
         this.mesh.addQuadFace(_loc2_,_loc3_,_loc4_,_loc5_);
         this.mesh.calculateFacesNormals();
         this.mesh.calculateBounds();
         this.mesh.useLight = false;
         this.mesh.useShadowMap = false;
         this.mesh.shadowMapAlphaThreshold = 2;
         this.mesh.depthMapAlphaThreshold = 2;
         this.mesh.blendMode = BlendMode.ADD;
         this.mesh.softAttenuation = 20;
         this.meshContainer.addChild(this.mesh);
      }
      
      public function init(param1:TextureMaterial, param2:Object3D, param3:Object3D) : *
      {
         this.source = param2;
         this.target = param3;
         this.mesh.setMaterialToAllFaces(param1);
         this.time = 0;
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = param1;
         param1.addChild(this.meshContainer);
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         var _loc3_:Number = param1 / 1000;
         this.time += _loc3_;
         this.turnToCamera(param2);
         if(this.time <= MID)
         {
            this.mesh.alpha = this.time / MID;
            return true;
         }
         if(this.time <= END)
         {
            this.mesh.alpha = 1 - (this.time - MID) / (END - MID);
            return true;
         }
         return false;
      }
      
      private function turnToCamera(param1:GameCamera) : void
      {
         this.meshContainer.x = this.source.x;
         this.meshContainer.y = this.source.y;
         this.meshContainer.z = this.source.z + SOURCE_Z_OFFSET;
         vector.x = this.target.x - this.source.x;
         vector.y = this.target.y - this.source.y;
         vector.z = this.target.z + TARGET_Z_OFFSET - this.source.z;
         vector.scaleBy(0.9);
         this.mesh.scaleZ = vector.length / SIZE;
         this.meshContainer.rotationX = Math.atan2(vector.z,Math.sqrt(vector.x * vector.x + vector.y * vector.y)) - Math.PI / 2;
         this.meshContainer.rotationY = 0;
         this.meshContainer.rotationZ = -Math.atan2(vector.x,vector.y);
         var _loc2_:Matrix3D = this.meshContainer.concatenatedMatrix;
         _loc2_.invert();
         _loc2_.prepend(param1.concatenatedMatrix);
         var _loc3_:Vector3D = _loc2_.transformVector(new Vector3D());
         this.mesh.rotationZ = Math.atan2(_loc3_.x,-_loc3_.y);
      }
      
      public function destroy() : void
      {
         this.container.removeChild(this.meshContainer);
         this.mesh.setMaterialToAllFaces(null);
         this.container = null;
         this.target = null;
         recycle();
      }
      
      public function kill() : void
      {
         this.mesh.alpha = 0;
      }
   }
}


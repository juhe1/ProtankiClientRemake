package alternativa.tanks.models.tank.ultimate.dictator
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import flash.display.BlendMode;
   import flash.geom.Vector3D;
   
   public class DictatorStreamEffect extends PooledObject implements GraphicEffect
   {
      
      public static const OFFSET:Number = 150;
      
      public static const MID:Number = 30 / 60;
      
      public static const KEY1:Number = 40 / 60;
      
      public static const KEY2:Number = 60 / 60;
      
      public static const END:Number = 100 / 60;
      
      private static const SIZE:Number = 300;
      
      private static const DX:Number = 15;
      
      private static const MAX:Number = 4;
      
      private static const TOP:Number = 800;
      
      private static const D:Number = 40;
      
      private static const H:Number = 150;
      
      private static const vector:Vector3D = new Vector3D();
      
      private var beam:Mesh;
      
      private var center:Mesh;
      
      private var star1:Sprite3D;
      
      private var star2:Sprite3D;
      
      private var star3:Sprite3D;
      
      private var star4:Sprite3D;
      
      private var origin1:Vector3D;
      
      private var origin2:Vector3D;
      
      private var origin3:Vector3D;
      
      private var origin4:Vector3D;
      
      private var time:Number;
      
      private var container:Scene3DContainer;
      
      private var targetObject:Object3D;
      
      private var scale:Number;
      
      public function DictatorStreamEffect(param1:Pool)
      {
         super(param1);
         this.beam = new Mesh();
         var _loc2_:Vertex = this.beam.addVertex(-SIZE / 2 - DX,0,SIZE,0,0);
         var _loc3_:Vertex = this.beam.addVertex(-SIZE / 2 - DX,0,0,0,1);
         var _loc4_:Vertex = this.beam.addVertex(SIZE / 2 - DX,0,0,1,1);
         var _loc5_:Vertex = this.beam.addVertex(SIZE / 2 - DX,0,SIZE,1,0);
         this.beam.addQuadFace(_loc2_,_loc3_,_loc4_,_loc5_);
         _loc2_ = this.beam.addVertex(-SIZE / 2 + DX,0,SIZE,0,0);
         _loc3_ = this.beam.addVertex(-SIZE / 2 + DX,0,0,0,1);
         _loc4_ = this.beam.addVertex(SIZE / 2 + DX,0,0,1,1);
         _loc5_ = this.beam.addVertex(SIZE / 2 + DX,0,SIZE,1,0);
         this.beam.addQuadFace(_loc2_,_loc3_,_loc4_,_loc5_);
         this.beam.calculateFacesNormals();
         this.beam.calculateBounds();
         this.beam.useLight = false;
         this.beam.useShadowMap = false;
         this.beam.shadowMapAlphaThreshold = 2;
         this.beam.depthMapAlphaThreshold = 2;
         this.beam.blendMode = BlendMode.ADD;
         this.beam.softAttenuation = 150;
         this.center = new Mesh();
         _loc2_ = this.center.addVertex(-SIZE / 2 * 1.4,0,SIZE,0,0);
         _loc3_ = this.center.addVertex(-SIZE / 2 * 1.4,0,0,0,1);
         _loc4_ = this.center.addVertex(SIZE / 2 * 1.4,0,0,1,1);
         _loc5_ = this.center.addVertex(SIZE / 2 * 1.4,0,SIZE,1,0);
         this.center.addQuadFace(_loc2_,_loc3_,_loc4_,_loc5_);
         this.center.calculateFacesNormals();
         this.center.calculateBounds();
         this.center.useLight = false;
         this.center.useShadowMap = false;
         this.center.shadowMapAlphaThreshold = 2;
         this.center.depthMapAlphaThreshold = 2;
         this.center.blendMode = BlendMode.ADD;
         this.center.softAttenuation = 150;
         this.origin1 = new Vector3D(-D,D,0);
         this.origin2 = new Vector3D(-D,-D,H);
         this.origin3 = new Vector3D(D,-D,H + H);
         this.origin4 = new Vector3D(D,D,H + H + H);
         this.star1 = new Sprite3D(100,100);
         this.star1.useLight = false;
         this.star1.useShadowMap = false;
         this.star1.blendMode = BlendMode.ADD;
         this.star1.softAttenuation = 150;
         this.star2 = this.star1.clone() as Sprite3D;
         this.star3 = this.star1.clone() as Sprite3D;
         this.star4 = this.star1.clone() as Sprite3D;
      }
      
      public function init(param1:TextureMaterial, param2:TextureMaterial, param3:Object3D, param4:Number) : *
      {
         this.targetObject = param3;
         this.scale = param4;
         this.beam.setMaterialToAllFaces(param1);
         this.center.setMaterialToAllFaces(param1);
         this.star1.material = param2;
         this.star1.scaleX = param4;
         this.star1.scaleY = param4;
         this.star1.scaleZ = param4;
         this.star2.material = param2;
         this.star2.scaleX = param4;
         this.star2.scaleY = param4;
         this.star2.scaleZ = param4;
         this.star3.material = param2;
         this.star3.scaleX = param4;
         this.star3.scaleY = param4;
         this.star3.scaleZ = param4;
         this.star4.material = param2;
         this.star4.scaleX = param4;
         this.star4.scaleY = param4;
         this.star4.scaleZ = param4;
         this.time = 0;
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = param1;
         param1.addChild(this.beam);
         param1.addChild(this.center);
         param1.addChild(this.star1);
         param1.addChild(this.star2);
         param1.addChild(this.star3);
         param1.addChild(this.star4);
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         var _loc4_:Number = NaN;
         this.time += param1 / 1000;
         var _loc3_:Number = 150;
         vector.x = param2.x - this.targetObject.x;
         vector.y = param2.y - this.targetObject.y;
         vector.z = param2.z - this.targetObject.z + _loc3_;
         vector.normalize();
         this.beam.x = this.targetObject.x + vector.x * OFFSET;
         this.beam.y = this.targetObject.y + vector.y * OFFSET;
         this.beam.z = this.targetObject.z + vector.z * OFFSET + _loc3_;
         this.beam.rotationZ = Math.atan2(param2.y - this.targetObject.y,param2.x - this.targetObject.x) + Math.PI / 2;
         this.center.x = this.beam.x;
         this.center.y = this.beam.y;
         this.center.z = this.beam.z;
         this.center.rotationZ = this.beam.rotationZ;
         this.beam.scaleX = this.scale;
         this.beam.scaleY = this.scale;
         this.center.scaleX = this.scale;
         this.center.scaleY = this.scale;
         this.center.scaleZ = this.scale;
         if(this.time <= KEY2)
         {
            _loc4_ = TOP * this.time / KEY2 * this.scale;
            this.star1.x = this.targetObject.x + this.origin1.x * this.scale;
            this.star1.y = this.targetObject.y + this.origin1.y * this.scale;
            this.star1.z = this.targetObject.z + this.origin1.z * this.scale + _loc3_ + _loc4_;
            this.star2.x = this.targetObject.x + this.origin2.x * this.scale;
            this.star2.y = this.targetObject.y + this.origin2.y * this.scale;
            this.star2.z = this.targetObject.z + this.origin2.z * this.scale + _loc3_ + _loc4_;
            this.star3.x = this.targetObject.x + this.origin3.x * this.scale;
            this.star3.y = this.targetObject.y + this.origin3.y * this.scale;
            this.star3.z = this.targetObject.z + this.origin3.z * this.scale + _loc3_ + _loc4_;
            this.star4.x = this.targetObject.x + this.origin4.x * this.scale;
            this.star4.y = this.targetObject.y + this.origin4.y * this.scale;
            this.star4.z = this.targetObject.z + this.origin4.z * this.scale + _loc3_ + _loc4_;
            if(this.time <= MID)
            {
               this.star1.alpha = this.time / MID;
            }
            else
            {
               this.star1.alpha = 1 - (this.time - MID) / (KEY2 - MID);
            }
            this.star2.alpha = this.star1.alpha;
            this.star3.alpha = this.star1.alpha;
            this.star4.alpha = this.star1.alpha;
            this.star1.visible = true;
            this.star2.visible = true;
            this.star3.visible = true;
            this.star4.visible = true;
         }
         else
         {
            this.star1.visible = false;
            this.star2.visible = false;
            this.star3.visible = false;
            this.star4.visible = false;
         }
         if(this.time <= KEY1)
         {
            _loc4_ = this.time / KEY1;
            this.beam.scaleZ = (1 + (MAX - 1) * _loc4_) * this.scale;
            this.beam.alpha = _loc4_;
            this.center.alpha = this.beam.alpha;
            return true;
         }
         if(this.time <= END)
         {
            if(this.time <= KEY2)
            {
               this.beam.alpha = 1;
            }
            else
            {
               this.beam.alpha = 1 - (this.time - KEY2) / (END - KEY2);
            }
            this.center.alpha = 1 - (this.time - KEY1) / (END - KEY1);
            return true;
         }
         return false;
      }
      
      public function destroy() : void
      {
         this.container.removeChild(this.beam);
         this.container.removeChild(this.center);
         this.container.removeChild(this.star1);
         this.container.removeChild(this.star2);
         this.container.removeChild(this.star3);
         this.container.removeChild(this.star4);
         this.beam.setMaterialToAllFaces(null);
         this.center.setMaterialToAllFaces(null);
         this.star1.material = null;
         this.star1.scaleX = 0;
         this.star1.scaleY = 0;
         this.star1.scaleZ = 0;
         this.star2.material = null;
         this.star2.scaleX = 0;
         this.star2.scaleY = 0;
         this.star2.scaleZ = 0;
         this.star3.material = null;
         this.star3.scaleX = 0;
         this.star3.scaleY = 0;
         this.star3.scaleZ = 0;
         this.star4.material = null;
         this.star4.scaleX = 0;
         this.star4.scaleY = 0;
         this.star4.scaleZ = 0;
         this.container = null;
         recycle();
      }
      
      public function kill() : void
      {
         this.beam.alpha = 0;
         this.center.alpha = 0;
         this.star1.alpha = 0;
         this.star2.alpha = 0;
         this.star3.alpha = 0;
         this.star4.alpha = 0;
      }
   }
}


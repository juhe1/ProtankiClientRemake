package alternativa.tanks.bonuses
{
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.core.Wrapper;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class Cords extends BonusObject3DBase
   {
      
      private static const meshMatrix:Matrix4 = new Matrix4();
      
      private var topVertices:Vector.<Vertex>;
      
      private var topLocalPoints:Vector.<Vector3>;
      
      private var boxVertex:Vertex;
      
      private var boxLocalPoint:Vector3;
      
      private var numStraps:int;
      
      private var bonusMesh:BonusObject3DBase;
      
      private var parachute:Parachute;
      
      private var mesh:Mesh;
      
      public function Cords(param1:Number, param2:Number, param3:int, param4:Material)
      {
         super();
         this.numStraps = param3;
         this.mesh = new Mesh();
         object = this.mesh;
         this.topVertices = new Vector.<Vertex>(2 * param3);
         this.topLocalPoints = new Vector.<Vector3>(param3);
         this.createGeometry(param1,param2);
         this.mesh.setMaterialToAllFaces(param4);
         this.mesh.shadowMapAlphaThreshold = 2;
         this.mesh.depthMapAlphaThreshold = 2;
      }
      
      public function init(param1:BonusObject3DBase, param2:Parachute) : void
      {
         this.bonusMesh = param1;
         this.parachute = param2;
         this.mesh.scaleX = 1;
         this.mesh.scaleY = 1;
         this.mesh.scaleZ = 1;
         setAlpha(1);
         setAlphaMultiplier(1);
      }
      
      public function recycle() : void
      {
         removeFromScene();
         this.bonusMesh = null;
         this.parachute = null;
         BonusCache.putCords(this);
      }
      
      public function updateVertices() : void
      {
         var _loc1_:Vector3 = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Vertex = null;
         this.parachute.readTransform(meshMatrix);
         var _loc2_:int = 0;
         while(_loc2_ < this.numStraps)
         {
            _loc1_ = this.topLocalPoints[_loc2_];
            _loc3_ = _loc1_.x * meshMatrix.m00 + _loc1_.y * meshMatrix.m01 + _loc1_.z * meshMatrix.m02 + meshMatrix.m03;
            _loc4_ = _loc1_.x * meshMatrix.m10 + _loc1_.y * meshMatrix.m11 + _loc1_.z * meshMatrix.m12 + meshMatrix.m13;
            _loc5_ = _loc1_.x * meshMatrix.m20 + _loc1_.y * meshMatrix.m21 + _loc1_.z * meshMatrix.m22 + meshMatrix.m23;
            _loc6_ = this.topVertices[2 * _loc2_];
            _loc6_.x = _loc3_;
            _loc6_.y = _loc4_;
            _loc6_.z = _loc5_;
            _loc6_ = this.topVertices[2 * _loc2_ + 1];
            _loc6_.x = _loc3_;
            _loc6_.y = _loc4_;
            _loc6_.z = _loc5_;
            _loc2_++;
         }
         this.bonusMesh.readTransform(meshMatrix);
         _loc1_ = this.boxLocalPoint;
         this.boxVertex.x = _loc1_.x * meshMatrix.m00 + _loc1_.y * meshMatrix.m01 + _loc1_.z * meshMatrix.m02 + meshMatrix.m03;
         this.boxVertex.y = _loc1_.x * meshMatrix.m10 + _loc1_.y * meshMatrix.m11 + _loc1_.z * meshMatrix.m12 + meshMatrix.m13;
         this.boxVertex.z = _loc1_.x * meshMatrix.m20 + _loc1_.y * meshMatrix.m21 + _loc1_.z * meshMatrix.m22 + meshMatrix.m23;
         this.mesh.calculateBounds();
         this.mesh.calculateFacesNormals();
      }
      
      private function createGeometry(param1:Number, param2:Number) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Vector3 = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         this.boxLocalPoint = new Vector3(0,0,param2);
         this.boxVertex = this.createVertex(0,0,param2,0,1);
         var _loc3_:Number = 2 * Math.PI / this.numStraps;
         var _loc4_:int = 0;
         while(_loc4_ < this.numStraps)
         {
            _loc6_ = _loc4_ * _loc3_;
            _loc7_ = new Vector3(param1 * Math.cos(_loc6_),param1 * Math.sin(_loc6_),0);
            this.topLocalPoints[_loc4_] = _loc7_;
            this.topVertices[2 * _loc4_] = this.createVertex(_loc7_.x,_loc7_.y,_loc7_.z,0,0);
            this.topVertices[2 * _loc4_ + 1] = this.createVertex(_loc7_.x,_loc7_.y,_loc7_.z,1,1);
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < this.numStraps)
         {
            _loc8_ = 2 * _loc5_;
            _loc9_ = _loc8_ + 3;
            if(_loc9_ >= 2 * this.numStraps)
            {
               _loc9_ -= 2 * this.numStraps;
            }
            this.createTriFace(this.boxVertex,this.topVertices[_loc8_],this.topVertices[_loc9_]);
            this.createTriFace(this.boxVertex,this.topVertices[_loc9_],this.topVertices[_loc8_]);
            _loc5_++;
         }
      }
      
      private function createVertex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Vertex
      {
         var _loc6_:Vertex = new Vertex();
         _loc6_.next = this.mesh.vertexList;
         this.mesh.vertexList = _loc6_;
         _loc6_.x = param1;
         _loc6_.y = param2;
         _loc6_.z = param3;
         _loc6_.u = param4;
         _loc6_.v = param5;
         return _loc6_;
      }
      
      private function createTriFace(param1:Vertex, param2:Vertex, param3:Vertex) : Face
      {
         var _loc4_:Face = new Face();
         _loc4_.next = this.mesh.faceList;
         this.mesh.faceList = _loc4_;
         _loc4_.wrapper = new Wrapper();
         _loc4_.wrapper.vertex = param1;
         _loc4_.wrapper.next = new Wrapper();
         _loc4_.wrapper.next.vertex = param2;
         _loc4_.wrapper.next.next = new Wrapper();
         _loc4_.wrapper.next.next.vertex = param3;
         return _loc4_;
      }
   }
}


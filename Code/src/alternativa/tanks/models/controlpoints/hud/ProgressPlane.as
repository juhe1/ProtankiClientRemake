package alternativa.tanks.models.controlpoints.hud
{
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.core.Wrapper;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.tanks.utils.MathUtils;
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import alternativa.engine3d.alternativa3d;

   use namespace alternativa3d;
   
   public class ProgressPlane extends Mesh
   {
      
      private static const MAX_PROGRESS:Number = 100;
      
      private var progress:Number = 0;
      
      private var emptyMaterial:Material;
      
      private var blueFillingMaterial:Material;
      
      private var blueFullMaterial:Material;
      
      private var redFillingMaterial:Material;
      
      private var redFullMaterial:Material;
      
      private var _faces:Vector.<Face>;
      
      private var uvs:Vector.<Point> = new Vector.<Point>();
      
      private var verts:Vector.<Vector3D> = new Vector.<Vector3D>();
      
      public function ProgressPlane(param1:Number, param2:Number, param3:Material, param4:Material, param5:Material, param6:Material, param7:Material)
      {
         super();
         this.emptyMaterial = param3;
         this.blueFillingMaterial = param4;
         this.blueFullMaterial = param5;
         this.redFillingMaterial = param6;
         this.redFullMaterial = param7;
         useShadowMap = false;
         useLight = false;
         shadowMapAlphaThreshold = 2;
         depthMapAlphaThreshold = 2;
         this.createGeometry(param1,param2);
      }
      
      private function createGeometry(param1:Number, param2:Number) : void
      {
         var _loc3_:Vertex = null;
         var _loc4_:Vertex = null;
         var _loc5_:Vertex = null;
         var _loc6_:Number = param1 * 0.5;
         var _loc7_:Number = param2 * 0.5;
         this.verts[0] = new Vector3D(0,_loc7_,0);
         this.verts[1] = new Vector3D(-_loc6_,0,0);
         this.verts[2] = new Vector3D(0,-_loc7_,0);
         this.verts[3] = new Vector3D(_loc6_,0,0);
         this.uvs[0] = new Point(0.5,-0.5);
         this.uvs[1] = new Point(-0.5,0.5);
         this.uvs[2] = new Point(0.5,1.5);
         this.uvs[3] = new Point(1.5,0.5);
         this._faces = new Vector.<Face>();
         _loc3_ = this.createVertex(-_loc6_,0,0,-0.5,0.5);
         _loc4_ = this.createVertex(0,0,0,0.5,0.5);
         _loc5_ = this.createVertex(0,_loc7_,0,0.5,-0.5);
         this._faces[0] = this.createFace(_loc3_,_loc4_,_loc5_,this.emptyMaterial);
         _loc3_ = this.createVertex(0,-_loc7_,0,0.5,1.5);
         _loc4_ = this.createVertex(0,0,0,0.5,0.5);
         _loc5_ = this.createVertex(-_loc6_,0,0,-0.5,0.5);
         this._faces[1] = this.createFace(_loc3_,_loc4_,_loc5_,this.emptyMaterial);
         _loc3_ = this.createVertex(_loc6_,0,0,1.5,0.5);
         _loc4_ = this.createVertex(0,0,0,0.5,0.5);
         _loc5_ = this.createVertex(0,-_loc7_,0,0.5,1.5);
         this._faces[2] = this.createFace(_loc3_,_loc4_,_loc5_,this.emptyMaterial);
         _loc3_ = this.createVertex(0,_loc7_,0,0.5,-0.5);
         _loc4_ = this.createVertex(0,0,0,0.5,0.5);
         _loc5_ = this.createVertex(_loc6_,0,0,1.5,0.5);
         this._faces[3] = this.createFace(_loc3_,_loc4_,_loc5_,this.emptyMaterial);
         _loc3_ = this.createVertex(0,0,0,0,0);
         _loc4_ = this.createVertex(0,0,0,0.5,0.5);
         _loc5_ = this.createVertex(0,0,0,0,0);
         this._faces[4] = this.createFace(_loc3_,_loc4_,_loc5_,this.emptyMaterial);
      }
      
      private function createVertex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Vertex
      {
         var _loc6_:Vertex = new Vertex();
         _loc6_.x = param1;
         _loc6_.y = param2;
         _loc6_.z = param3;
         _loc6_.u = param4;
         _loc6_.v = param5;
         _loc6_.next = vertexList;
         vertexList = _loc6_;
         return _loc6_;
      }
      
      private function createFace(param1:Vertex, param2:Vertex, param3:Vertex, param4:Material) : Face
      {
         var _loc5_:Face = null;
         _loc5_ = new Face();
         _loc5_.material = param4;
         _loc5_.wrapper = new Wrapper();
         _loc5_.wrapper.vertex = param1;
         _loc5_.wrapper.next = new Wrapper();
         _loc5_.wrapper.next.vertex = param2;
         _loc5_.wrapper.next.next = new Wrapper();
         _loc5_.wrapper.next.next.vertex = param3;
         _loc5_.normalX = 0;
         _loc5_.normalY = 0;
         _loc5_.normalZ = 1;
         _loc5_.offset = 0;
         _loc5_.next = faceList;
         faceList = _loc5_;
         return _loc5_;
      }
      
      public function updateRotation(param1:Camera3D) : void
      {
         rotationX = param1.rotationX - Math.PI;
         rotationY = 0;
         rotationZ = param1.rotationZ;
      }
      
      public function setProgress(param1:Number) : void
      {
         var _loc2_:Number = MathUtils.clamp(param1,-MAX_PROGRESS,MAX_PROGRESS);
         if(this.progress != _loc2_)
         {
            this.progress = _loc2_;
            this.update();
         }
      }
      
      private function update() : void
      {
         var _loc5_:Face = null;
         var _loc6_:Vertex = null;
         var _loc7_:Vertex = null;
         var _loc8_:Vector3D = null;
         var _loc9_:Vector3D = null;
         var _loc10_:Point = null;
         var _loc11_:Point = null;
         var _loc12_:Face = null;
         var _loc16_:int = 0;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc1_:Number = this.progress / MAX_PROGRESS;
         var _loc2_:Number = Math.abs(_loc1_);
         var _loc3_:int = 4 * _loc2_;
         var _loc4_:int = (_loc3_ + 1) % 4;
         var _loc13_:Material = _loc1_ < 0 ? this.redFillingMaterial : this.blueFillingMaterial;
         var _loc14_:Material = _loc1_ < 0 ? this.redFullMaterial : this.blueFullMaterial;
         var _loc15_:int = 0;
         while(_loc15_ < 4)
         {
            _loc5_ = this._faces[_loc15_];
            if(_loc15_ < _loc3_)
            {
               _loc5_.material = _loc2_ == 1 ? _loc14_ : _loc13_;
            }
            else if(_loc15_ > _loc3_)
            {
               _loc5_.material = this.emptyMaterial;
            }
            _loc6_ = _loc5_.wrapper.vertex;
            _loc16_ = (_loc15_ + 1) % 4;
            _loc9_ = this.verts[_loc16_];
            _loc11_ = this.uvs[_loc16_];
            _loc6_.x = _loc9_.x;
            _loc6_.y = _loc9_.y;
            _loc6_.u = _loc11_.x;
            _loc6_.v = _loc11_.y;
            _loc15_++;
         }
         _loc12_ = this._faces[4];
         if(_loc2_ == 1)
         {
            _loc7_ = _loc12_.wrapper.next.next.vertex;
            _loc7_.x = 0;
            _loc7_.y = 0;
            _loc7_.u = 0;
            _loc7_.v = 0;
            _loc7_ = _loc12_.wrapper.vertex;
            _loc7_.x = 0;
            _loc7_.y = 0;
            _loc7_.u = 0;
            _loc7_.v = 0;
         }
         else
         {
            _loc5_ = this._faces[_loc3_];
            _loc5_.material = _loc13_;
            _loc8_ = this.verts[0];
            _loc10_ = this.uvs[0];
            _loc9_ = this.verts[_loc4_];
            _loc11_ = this.uvs[_loc4_];
            _loc6_ = _loc5_.wrapper.vertex;
            _loc17_ = 2 * _loc2_ * Math.PI;
            _loc18_ = Math.cos(_loc17_);
            _loc19_ = Math.sin(_loc17_);
            _loc6_.x = _loc8_.x * _loc18_ - _loc8_.y * _loc19_;
            _loc6_.y = _loc8_.x * _loc19_ + _loc8_.y * _loc18_;
            _loc19_ = -_loc19_;
            _loc6_.u = 0.5 + (_loc10_.x - 0.5) * _loc18_ - (_loc10_.y - 0.5) * _loc19_;
            _loc6_.v = 0.5 + (_loc10_.x - 0.5) * _loc19_ + (_loc10_.y - 0.5) * _loc18_;
            _loc7_ = _loc12_.wrapper.vertex;
            _loc7_.x = _loc9_.x;
            _loc7_.y = _loc9_.y;
            _loc7_.u = _loc11_.x;
            _loc7_.v = _loc11_.y;
            _loc7_ = _loc12_.wrapper.next.next.vertex;
            _loc7_.x = _loc6_.x;
            _loc7_.y = _loc6_.y;
            _loc7_.u = _loc6_.u;
            _loc7_.v = _loc6_.v;
         }
      }
   }
}


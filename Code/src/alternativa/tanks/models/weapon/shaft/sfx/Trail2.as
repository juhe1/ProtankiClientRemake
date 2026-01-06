package alternativa.tanks.models.weapon.shaft.sfx
{
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.core.Sorting;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.core.Wrapper;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.objects.Mesh;
   
   internal class Trail2 extends Mesh
   {
      
      private var a:Vertex;
      
      private var b:Vertex;
      
      private var c:Vertex;
      
      private var d:Vertex;
      
      private var face:Face;
      
      public function Trail2()
      {
         super();
         this.a = this.createVertex(-1,0,0,0,0.5);
         this.b = this.createVertex(1,0,0,1,0.5);
         this.c = this.createVertex(1,1,0,1,1);
         this.d = this.createVertex(-1,1,0,0,1);
         this.face = this.createQuad(this.a,this.b,this.c,this.d);
         calculateFacesNormals();
         sorting = Sorting.DYNAMIC_BSP;
         shadowMapAlphaThreshold = 2;
         depthMapAlphaThreshold = 2;
         useShadowMap = false;
         useLight = false;
      }
      
      public function init(param1:Number, param2:Number, param3:Number, param4:Material) : void
      {
         alpha = 1;
         var _loc5_:Number = param1 / 2;
         boundMinX = this.a.x = this.d.x = -_loc5_;
         boundMaxX = this.b.x = this.c.x = _loc5_;
         boundMinY = this.c.y = this.d.y = param2;
         boundMaxY = 0;
         boundMinZ = boundMaxZ = 0;
         this.a.v = this.b.v = param3;
         this.face.material = param4;
      }
      
      public function set width(param1:Number) : void
      {
         var _loc2_:Number = param1 / 2;
         boundMinX = this.a.x = this.d.x = -_loc2_;
         boundMaxX = this.b.x = this.c.x = _loc2_;
      }
      
      public function get length() : Number
      {
         return this.d.y;
      }
      
      public function set length(param1:Number) : void
      {
         if(param1 < 10)
         {
            param1 = 10;
         }
         boundMaxY = this.c.y = this.d.y = param1;
      }
      
      private function createVertex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Vertex
      {
         var _loc6_:Vertex = new Vertex();
         _loc6_.next = vertexList;
         vertexList = _loc6_;
         _loc6_.x = param1;
         _loc6_.y = param2;
         _loc6_.z = param3;
         _loc6_.u = param4;
         _loc6_.v = param5;
         return _loc6_;
      }
      
      private function createQuad(param1:Vertex, param2:Vertex, param3:Vertex, param4:Vertex) : Face
      {
         var _loc5_:Face = new Face();
         _loc5_.next = faceList;
         faceList = _loc5_;
         _loc5_.wrapper = new Wrapper();
         _loc5_.wrapper.vertex = param1;
         _loc5_.wrapper.next = new Wrapper();
         _loc5_.wrapper.next.vertex = param2;
         _loc5_.wrapper.next.next = new Wrapper();
         _loc5_.wrapper.next.next.vertex = param3;
         _loc5_.wrapper.next.next.next = new Wrapper();
         _loc5_.wrapper.next.next.next.vertex = param4;
         return _loc5_;
      }
   }
}


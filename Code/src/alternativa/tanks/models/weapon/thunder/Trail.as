package alternativa.tanks.models.weapon.thunder
{
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.core.Wrapper;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.objects.Mesh;
   import flash.display.BlendMode;
   import alternativa.engine3d.alternativa3d;

   use namespace alternativa3d;
   
   internal class Trail extends Mesh
   {
      
      public function Trail(param1:Number, param2:Material)
      {
         super();
         var _loc3_:Number = 4;
         var _loc4_:Number = 240 * param1;
         var _loc5_:Vertex = this.createVertex(-_loc3_,0,0,0,0);
         var _loc6_:Vertex = this.createVertex(_loc3_,0,0,0,1);
         var _loc7_:Vertex = this.createVertex(0,_loc4_,0,1,0.5);
         this.createFace(_loc5_,_loc6_,_loc7_).material = param2;
         this.createFace(_loc7_,_loc6_,_loc5_).material = param2;
         calculateFacesNormals(true);
         calculateBounds();
         blendMode = BlendMode.SCREEN;
         alpha = 0.3;
         shadowMapAlphaThreshold = 2;
         depthMapAlphaThreshold = 2;
         useShadowMap = false;
         useLight = false;
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
      
      private function createFace(param1:Vertex, param2:Vertex, param3:Vertex) : Face
      {
         var _loc4_:Face = new Face();
         _loc4_.next = faceList;
         faceList = _loc4_;
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


package alternativa.tanks.models.controlpoints.sfx
{
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.core.Sorting;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   
   internal class AnimatedBeam extends Mesh
   {
      
      public var animationSpeed:Number;
      
      private var a:Vertex;
      
      private var b:Vertex;
      
      private var c:Vertex;
      
      private var d:Vertex;
      
      private var e:Vertex;
      
      private var f:Vertex;
      
      private var g:Vertex;
      
      private var h:Vertex;
      
      private var i:Vertex;
      
      private var j:Vertex;
      
      private var k:Vertex;
      
      private var l:Vertex;
      
      private var unitLength:Number;
      
      private var vOffset:Number = 0;
      
      public function AnimatedBeam(param1:Number, param2:Number, param3:Number, param4:Number)
      {
         super();
         this.unitLength = param3;
         this.animationSpeed = param4;
         useShadowMap = false;
         useLight = false;
         shadowMapAlphaThreshold = 2;
         depthMapAlphaThreshold = 2;
         var _loc5_:Number = param1 / 2;
         var _loc6_:Vector.<Number> = Vector.<Number>([-_loc5_,0,0,_loc5_,0,0,_loc5_,param2,0,-_loc5_,param2,0,-_loc5_,param2,0,_loc5_,param2,0,_loc5_,param2 + 1,0,-_loc5_,param2 + 1,0,-_loc5_,param2 + 1,0,_loc5_,param2 + 1,0,_loc5_,2 * param2 + 1,0,-_loc5_,2 * param2 + 1,0]);
         var _loc7_:Vector.<Number> = Vector.<Number>([0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,0,1,0,1,1,0,1]);
         var _loc8_:Vector.<int> = Vector.<int>([4,0,1,2,3,4,4,5,6,7,4,8,9,10,11]);
         addVerticesAndFaces(_loc6_,_loc7_,_loc8_,true);
         sorting = Sorting.DYNAMIC_BSP;
         this.writeVertices();
         calculateFacesNormals();
         this.updateV();
         boundMinX = -_loc5_;
         boundMaxX = _loc5_;
         boundMinY = 0;
         boundMaxY = length;
         boundMinZ = 0;
         boundMaxZ = 0;
      }
      
      public function setMaterials(param1:TextureMaterial, param2:TextureMaterial) : void
      {
         var _loc3_:Face = faceList;
         _loc3_.material = param1;
         _loc3_.next.material = param2;
         _loc3_.next.next.material = param1;
      }
      
      private function writeVertices() : void
      {
         var _loc1_:Vector.<Vertex> = this.vertices;
         this.a = _loc1_[0];
         this.b = _loc1_[1];
         this.c = _loc1_[2];
         this.d = _loc1_[3];
         this.e = _loc1_[4];
         this.f = _loc1_[5];
         this.g = _loc1_[6];
         this.h = _loc1_[7];
         this.i = _loc1_[8];
         this.j = _loc1_[9];
         this.k = _loc1_[10];
         this.l = _loc1_[11];
      }
      
      private function updateV() : void
      {
         this.e.v = this.vOffset;
         this.f.v = this.vOffset;
         var _loc1_:Number = (this.g.y - this.f.y) / this.unitLength + this.vOffset;
         this.g.v = _loc1_;
         this.h.v = _loc1_;
      }
      
      public function clear() : void
      {
         setMaterialToAllFaces(null);
      }
      
      public function setTipLength(param1:Number) : void
      {
         var _loc2_:Number = Number(this.c.y);
         this.c.y = param1;
         this.d.y = param1;
         this.e.y = param1;
         this.f.y = param1;
         this.setLength(this.k.y + param1 - _loc2_);
      }
      
      public function resize(param1:Number, param2:Number) : void
      {
         this.setWidth(param1);
         this.setLength(param2);
      }
      
      public function setWidth(param1:Number) : void
      {
         var _loc2_:Number = param1 / 2;
         boundMinX = -_loc2_;
         boundMaxX = _loc2_;
         this.a.x = -_loc2_;
         this.d.x = -_loc2_;
         this.e.x = -_loc2_;
         this.h.x = -_loc2_;
         this.i.x = -_loc2_;
         this.l.x = -_loc2_;
         this.b.x = _loc2_;
         this.c.x = _loc2_;
         this.f.x = _loc2_;
         this.g.x = _loc2_;
         this.j.x = _loc2_;
         this.k.x = _loc2_;
      }
      
      public function setLength(param1:Number) : void
      {
         if(param1 < 1 + 2 * this.c.y)
         {
            visible = false;
         }
         else
         {
            visible = true;
            boundMaxY = param1;
            this.g.y = param1 - this.c.y;
            this.h.y = this.g.y;
            this.i.y = this.g.y;
            this.j.y = this.g.y;
            this.k.y = param1;
            this.l.y = param1;
            this.updateV();
         }
      }
      
      public function setURange(param1:Number) : void
      {
         this.a.u = 0.5 * (1 - param1);
         this.d.u = this.a.u;
         this.e.u = this.a.u;
         this.h.u = this.a.u;
         this.i.u = this.a.u;
         this.l.u = this.a.u;
         this.b.u = 0.5 * (1 + param1);
         this.c.u = this.b.u;
         this.f.u = this.b.u;
         this.g.u = this.b.u;
         this.j.u = this.b.u;
         this.k.u = this.b.u;
      }
      
      public function update(param1:Number) : void
      {
         this.vOffset += this.animationSpeed * param1;
         if(this.vOffset < 0)
         {
            this.vOffset += 1;
         }
         else if(this.vOffset > 1)
         {
            this.vOffset -= 1;
         }
         this.updateV();
      }
      
      public function setUnitLength(param1:Number) : void
      {
         this.unitLength = param1;
         this.updateV();
      }
   }
}


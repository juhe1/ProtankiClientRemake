package alternativa.tanks.models.weapon.railgun
{
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.core.Sorting;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   
   internal class ShotSmoke extends Mesh
   {
      
      private static const GAP:Number = 10;
      
      private static const THRESHOLD:Number = 5;
      
      private var a:Vertex;
      
      private var b:Vertex;
      
      private var c:Vertex;
      
      private var d:Vertex;
      
      private var face1:Face;
      
      private var e:Vertex;
      
      private var f:Vertex;
      
      private var g:Vertex;
      
      private var h:Vertex;
      
      private var face2:Face;
      
      private var length:Number;
      
      private var middle:Number;
      
      private var segment:Number;
      
      private var moveDistance:Number;
      
      private var material:Material;
      
      public function ShotSmoke()
      {
         super();
         this.a = addVertex(-1,1,-GAP);
         this.b = addVertex(-1,0,-GAP);
         this.c = addVertex(1,0,-GAP);
         this.d = addVertex(1,1,-GAP);
         this.face1 = addQuadFace(this.a,this.b,this.c,this.d);
         this.e = addVertex(-1,1,-GAP);
         this.f = addVertex(-1,0,-GAP);
         this.g = addVertex(1,0,-GAP);
         this.h = addVertex(1,1,-GAP);
         this.face2 = addQuadFace(this.e,this.f,this.g,this.h);
         calculateFacesNormals();
         sorting = Sorting.DYNAMIC_BSP;
         softAttenuation = 80;
         shadowMapAlphaThreshold = 2;
         depthMapAlphaThreshold = 2;
         useShadowMap = false;
         useLight = false;
      }
      
      public function init(param1:Number, param2:Number, param3:Material, param4:Number) : void
      {
         this.length = param2;
         this.material = param3;
         this.moveDistance = param4;
         var _loc5_:TextureMaterial = param3 as TextureMaterial;
         if(_loc5_ != null && _loc5_.texture != null)
         {
            this.segment = param1 * _loc5_.texture.height * 2 / _loc5_.texture.width;
            this.middle = param2 - this.segment;
         }
         else
         {
            this.segment = param1 / 2;
            this.middle = 0;
         }
         this.segment *= 1.25;
         var _loc6_:Number = param1 * 0.5;
         this.a.x = -_loc6_;
         this.a.y = param2;
         this.a.u = 0;
         this.b.x = -_loc6_;
         this.b.u = 0;
         this.c.x = _loc6_;
         this.c.u = 0.5;
         this.d.x = _loc6_;
         this.d.y = param2;
         this.d.u = 0.5;
         this.e.x = -_loc6_;
         this.e.u = 0.5;
         this.e.v = 0;
         this.f.x = -_loc6_;
         this.f.y = 0;
         this.f.u = 0.5;
         this.g.x = _loc6_;
         this.g.y = 0;
         this.g.u = 1;
         this.h.x = _loc6_;
         this.h.u = 1;
         this.h.v = 0;
         boundMinX = -_loc6_;
         boundMinY = 0;
         boundMinZ = 0;
         boundMaxX = _loc6_;
         boundMaxY = param2;
         boundMaxZ = 0;
      }
      
      public function clear() : void
      {
         this.face1.material = null;
         this.face2.material = null;
         this.material = null;
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = this.middle + this.moveDistance * param1;
         if(_loc3_ < THRESHOLD)
         {
            _loc2_ = _loc3_ < 0 ? 0 : _loc3_;
            this.b.y = _loc2_;
            this.c.y = _loc2_;
            this.a.v = 1 - (this.length - _loc3_) / this.segment;
            this.d.v = this.a.v;
            this.b.v = this.a.v + (this.length - _loc2_) / this.segment;
            this.c.v = this.b.v;
            this.e.y = THRESHOLD;
            this.h.y = THRESHOLD;
            this.face1.material = this.material;
            this.face2.material = null;
         }
         else if(_loc3_ > this.length - THRESHOLD)
         {
            _loc2_ = _loc3_ > this.length ? this.length : _loc3_;
            this.e.y = _loc2_;
            this.h.y = _loc2_;
            this.e.v = -(_loc3_ - _loc2_) / this.segment;
            this.h.v = this.e.v;
            this.f.v = this.e.v + _loc3_ / this.segment;
            this.g.v = this.f.v;
            this.b.y = this.length - THRESHOLD;
            this.b.y = this.length - THRESHOLD;
            this.face1.material = null;
            this.face2.material = this.material;
         }
         else
         {
            this.a.v = 1 - (this.length - _loc3_) / this.segment;
            this.d.v = this.a.v;
            this.b.y = _loc3_;
            this.c.y = _loc3_;
            this.e.y = _loc3_;
            this.h.y = _loc3_;
            this.b.v = 1;
            this.c.v = 1;
            this.e.v = 0;
            this.f.v = _loc3_ / this.segment;
            this.g.v = _loc3_ / this.segment;
            this.h.v = 0;
            this.face1.material = this.material;
            this.face2.material = this.material;
         }
      }
   }
}


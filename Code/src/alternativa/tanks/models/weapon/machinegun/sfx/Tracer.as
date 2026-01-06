package alternativa.tanks.models.weapon.machinegun.sfx
{
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import flash.display.BlendMode;
   
   public class Tracer extends Mesh
   {
      
      private static const SPEED:Number = 15000;
      
      private var a:Vertex;
      
      private var b:Vertex;
      
      private var c:Vertex;
      
      private var d:Vertex;
      
      private var segment:Number;
      
      private var offset:Number = 0;
      
      public function Tracer()
      {
         super();
         var _loc1_:Number = -5;
         this.a = addVertex(-1,1,_loc1_);
         this.b = addVertex(-1,0,_loc1_);
         this.c = addVertex(1,0,_loc1_);
         this.d = addVertex(1,1,_loc1_);
         addQuadFace(this.a,this.b,this.c,this.d);
         calculateFacesNormals();
         blendMode = BlendMode.ADD;
         useLight = false;
         shadowMapAlphaThreshold = 2;
         depthMapAlphaThreshold = 2;
         useShadowMap = false;
      }
      
      public function init(param1:TextureMaterial) : void
      {
         param1.repeat = true;
         var _loc2_:Number = 30;
         var _loc3_:Number = _loc2_ * 0.5;
         this.a.x = -_loc3_;
         this.a.u = 0;
         this.b.x = -_loc3_;
         this.b.u = 0;
         this.c.x = _loc3_;
         this.c.u = 1;
         this.d.x = _loc3_;
         this.d.u = 1;
         this.segment = 4 * _loc2_ * param1.texture.height / param1.texture.width;
         setMaterialToAllFaces(param1);
         this.offset = 0;
      }
      
      public function update(param1:int, param2:Number = 512) : void
      {
         this.offset += SPEED * param1 / 1000;
         this.a.y = param2;
         this.d.y = param2;
         this.b.v = 1 + this.offset / this.segment;
         this.c.v = this.b.v;
         this.a.v = this.b.v - param2 / this.segment;
         this.d.v = this.a.v;
      }
   }
}


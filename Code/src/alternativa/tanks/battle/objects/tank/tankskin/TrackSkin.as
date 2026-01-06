package alternativa.tanks.battle.objects.tank.tankskin
{
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.UVMatrixProvider;
   import alternativa.tanks.materials.TrackMaterial;
   import flash.geom.Matrix;
   import flash.utils.Dictionary;
   
   public class TrackSkin
   {
      
      private var uvsProvider:UVMatrixProvider;
      
      private var faces:Vector.<Face> = new Vector.<Face>();
      
      private var vertices:Vector.<Vertex>;
      
      private var ratio:Number;
      
      private var distance:Number = 0;
      
      public function TrackSkin()
      {
         super();
      }
      
      private static function getRatio(param1:Face) : Number
      {
         var _loc2_:Vector.<Vertex> = param1.vertices;
         return getRatioForVertices(_loc2_[0],_loc2_[1]);
      }
      
      private static function getRatioForVertices(param1:Vertex, param2:Vertex) : Number
      {
         var _loc3_:Number = param1.x - param2.x;
         var _loc4_:Number = param1.y - param2.y;
         var _loc5_:Number = param1.z - param2.z;
         var _loc6_:Number = Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_ + _loc5_ * _loc5_);
         var _loc7_:Number = param1.u - param2.u;
         var _loc8_:Number = param1.v - param2.v;
         var _loc9_:Number = Math.sqrt(_loc7_ * _loc7_ + _loc8_ * _loc8_);
         return _loc9_ / _loc6_;
      }
      
      public function addFace(param1:Face) : void
      {
         this.faces.push(param1);
      }
      
      public function init() : void
      {
         var _loc3_:Face = null;
         var _loc4_:* = undefined;
         var _loc5_:Vertex = null;
         var _loc1_:Number = 0;
         var _loc2_:Dictionary = new Dictionary();
         for each(_loc3_ in this.faces)
         {
            for each(_loc5_ in _loc3_.vertices)
            {
               _loc2_[_loc5_] = true;
            }
            _loc1_ += getRatio(_loc3_);
         }
         this.ratio = _loc1_ / this.faces.length;
         this.vertices = new Vector.<Vertex>();
         for(_loc4_ in _loc2_)
         {
            this.vertices.push(_loc4_);
         }
      }
      
      public function move(param1:Number) : void
      {
         var _loc2_:Matrix = null;
         this.distance += param1 * this.ratio;
         if(this.uvsProvider != null)
         {
            _loc2_ = this.uvsProvider.getMatrix();
            _loc2_.tx = this.distance;
         }
      }
      
      public function setMaterial(param1:Material) : void
      {
         var _loc2_:Face = null;
         var _loc3_:TrackMaterial = null;
         for each(_loc2_ in this.faces)
         {
            _loc2_.material = param1;
         }
         if(param1 is TrackMaterial)
         {
            _loc3_ = param1 as TrackMaterial;
            this.uvsProvider = _loc3_.uvMatrixProvider;
         }
      }
   }
}


package alternativa.tanks.battle.objects.tank.tankskin.dynamic
{
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.materials.Material;
   import flash.geom.Point;
   
   public class CommonDynamicSkin implements DynamicSkin
   {
      
      protected var faces:Vector.<Face> = new Vector.<Face>();
      
      protected var rotation:Number;
      
      protected var vertices:Vector.<Vertex> = new Vector.<Vertex>();
      
      protected var originalUVs:Vector.<Point> = new Vector.<Point>();
      
      public function CommonDynamicSkin()
      {
         super();
         this.rotation = 0;
      }
      
      public function addFace(param1:Face) : void
      {
         this.faces.push(param1);
      }
      
      public function init() : void
      {
         var _loc1_:Face = null;
         var _loc2_:Vertex = null;
         for each(_loc1_ in this.faces)
         {
            for each(_loc2_ in _loc1_.vertices)
            {
               this.vertices.push(_loc2_);
               this.originalUVs.push(new Point(_loc2_.u,_loc2_.v));
            }
         }
      }
      
      public function setMaterial(param1:Material) : void
      {
         var _loc2_:Face = null;
         for each(_loc2_ in this.faces)
         {
            _loc2_.material = param1;
         }
      }
      
      public function rotate(param1:Number) : void
      {
         this.rotation += param1;
      }
      
      public function reset() : void
      {
         this.rotation = 0;
      }
   }
}


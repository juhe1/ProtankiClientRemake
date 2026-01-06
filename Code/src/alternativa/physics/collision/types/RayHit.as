package alternativa.physics.collision.types
{
   import alternativa.math.Vector3;
   import alternativa.physics.collision.CollisionShape;
   
   public class RayHit
   {
      
      public var shape:CollisionShape;
      
      public var position:Vector3 = new Vector3();
      
      public var normal:Vector3 = new Vector3();
      
      public var t:Number = 0;
      
      public var staticHit:Boolean;
      
      public function RayHit()
      {
         super();
      }
      
      public function copy(param1:RayHit) : void
      {
         this.shape = param1.shape;
         this.position.copy(param1.position);
         this.normal.copy(param1.normal);
         this.t = param1.t;
         this.staticHit = param1.staticHit;
      }
      
      public function clear() : void
      {
         this.shape = null;
      }
      
      public function clone() : RayHit
      {
         var _loc1_:RayHit = new RayHit();
         _loc1_.copy(this);
         return _loc1_;
      }
   }
}


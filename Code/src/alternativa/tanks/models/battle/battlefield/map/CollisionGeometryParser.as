package alternativa.tanks.models.battle.battlefield.map
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.PhysicsMaterial;
   import alternativa.physics.collision.CollisionShape;
   import alternativa.physics.collision.primitives.CollisionBox;
   import alternativa.physics.collision.primitives.CollisionRect;
   import alternativa.physics.collision.primitives.CollisionTriangle;
   
   public class CollisionGeometryParser
   {
      
      private static const MATERIAL:PhysicsMaterial = new PhysicsMaterial(0,1);
      
      private static const STATIC_COLLISION_GROUP:int = 255;
      
      private static const halfSize:Vector3 = new Vector3();
      
      private static const position:Vector3 = new Vector3();
      
      private static const rotation:Vector3 = new Vector3();
      
      private static const rotationMatrix:Matrix3 = new Matrix3();
      
      public function CollisionGeometryParser()
      {
         super();
      }
      
      public static function parse(param1:XML) : Vector.<CollisionShape>
      {
         var _loc2_:Vector.<CollisionShape> = new Vector.<CollisionShape>();
         putAll(parseCollisionPlanes(param1),_loc2_);
         putAll(parseCollisionBoxes(param1),_loc2_);
         putAll(parseCollisionTrinagles(param1),_loc2_);
         return _loc2_;
      }
      
      private static function putAll(param1:Vector.<CollisionShape>, param2:Vector.<CollisionShape>) : void
      {
         var _loc3_:CollisionShape = null;
         for each(_loc3_ in param1)
         {
            param2.push(_loc3_);
         }
      }
      
      private static function parseCollisionPlanes(param1:XML) : Vector.<CollisionShape>
      {
         var _loc4_:XML = null;
         var _loc5_:CollisionShape = null;
         var _loc2_:Vector.<CollisionShape> = new Vector.<CollisionShape>();
         var _loc3_:XMLList = param1.elements("collision-geometry")[0].elements("collision-plane");
         for each(_loc4_ in _loc3_)
         {
            halfSize.x = 0.5 * Number(_loc4_.width);
            halfSize.y = 0.5 * Number(_loc4_.length);
            halfSize.z = 0;
            _loc5_ = new CollisionRect(halfSize,STATIC_COLLISION_GROUP,MATERIAL);
            setCollisionPrimitiveOrientation(_loc5_,_loc4_);
            _loc2_.push(_loc5_);
         }
         return _loc2_;
      }
      
      private static function parseCollisionBoxes(param1:XML) : Vector.<CollisionShape>
      {
         var _loc4_:XML = null;
         var _loc5_:CollisionShape = null;
         var _loc2_:Vector.<CollisionShape> = new Vector.<CollisionShape>();
         var _loc3_:XMLList = param1.elements("collision-geometry")[0].elements("collision-box");
         for each(_loc4_ in _loc3_)
         {
            readVector3(_loc4_.size,halfSize);
            halfSize.scale(0.5);
            _loc5_ = new CollisionBox(halfSize,STATIC_COLLISION_GROUP,MATERIAL);
            setCollisionPrimitiveOrientation(_loc5_,_loc4_);
            _loc2_.push(_loc5_);
         }
         return _loc2_;
      }
      
      private static function parseCollisionTrinagles(param1:XML) : Vector.<CollisionShape>
      {
         var _loc7_:XML = null;
         var _loc8_:CollisionShape = null;
         var _loc2_:Vector.<CollisionShape> = new Vector.<CollisionShape>();
         var _loc3_:Vector3 = new Vector3();
         var _loc4_:Vector3 = new Vector3();
         var _loc5_:Vector3 = new Vector3();
         var _loc6_:XMLList = param1.elements("collision-geometry")[0].elements("collision-triangle");
         for each(_loc7_ in _loc6_)
         {
            readVector3(_loc7_.v0,_loc3_);
            readVector3(_loc7_.v1,_loc4_);
            readVector3(_loc7_.v2,_loc5_);
            _loc8_ = new CollisionTriangle(_loc3_,_loc4_,_loc5_,STATIC_COLLISION_GROUP,MATERIAL);
            setCollisionPrimitiveOrientation(_loc8_,_loc7_);
            _loc2_.push(_loc8_);
         }
         return _loc2_;
      }
      
      private static function setCollisionPrimitiveOrientation(param1:CollisionShape, param2:XML) : void
      {
         readVector3(param2.position,position);
         readVector3(param2.rotation,rotation);
         rotationMatrix.setRotationMatrix(rotation.x,rotation.y,rotation.z);
         param1.transform.setFromMatrix3(rotationMatrix,position);
      }
      
      private static function readVector3(param1:XMLList, param2:Vector3) : void
      {
         var _loc3_:XML = null;
         if(param1.length() > 0)
         {
            _loc3_ = param1[0];
            param2.x = parseFloat(_loc3_.x);
            param2.y = parseFloat(_loc3_.y);
            param2.z = parseFloat(_loc3_.z);
         }
         else
         {
            param2.reset(0,0,0);
         }
      }
   }
}


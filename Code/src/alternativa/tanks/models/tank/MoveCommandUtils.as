package alternativa.tanks.models.tank
{
   import alternativa.math.Vector3;
   import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   public class MoveCommandUtils
   {
      
      private static const nearDistance:Number = 30;
      
      private static const nearDistanceSqr:Number = nearDistance * nearDistance;
      
      private static const nearVelocity:Number = 50;
      
      private static const nearVelocitySqr:Number = nearVelocity * nearVelocity;
      
      private static const nearOrientationDegrees:Number = 4;
      
      private static const nearOrientationRad:Number = nearOrientationDegrees / 180 * Math.PI;
      
      private static const nearRotationDirDegrees:Number = 10;
      
      private static const nearRotationDirRad:Number = nearRotationDirDegrees / 180 * Math.PI;
      
      public function MoveCommandUtils()
      {
         super();
      }
      
      public static function copyMoveCommand(param1:MoveCommand, param2:MoveCommand) : void
      {
         copyVector3d(param1.angularVelocity,param2.angularVelocity);
         copyVector3d(param1.linearVelocity,param2.linearVelocity);
         copyVector3d(param1.orientation,param2.orientation);
         copyVector3d(param1.position,param2.position);
         param2.control = param1.control;
         param2.turnSpeedNumber = param1.turnSpeedNumber;
      }
      
      public static function copyVector3d(param1:Vector3d, param2:Vector3d) : void
      {
         param2.x = param1.x;
         param2.y = param1.y;
         param2.z = param1.z;
      }
      
      public static function calculateDistanceSqr(param1:Vector3, param2:Vector3d) : Number
      {
         var _loc3_:Number = param1.x - param2.x;
         var _loc4_:Number = param1.y - param2.y;
         var _loc5_:Number = param1.z - param2.z;
         return _loc3_ * _loc3_ + _loc4_ * _loc4_ + _loc5_ * _loc5_;
      }
      
      public static function isMoveCommandsAlmostEquals(param1:MoveCommand, param2:MoveCommand) : Boolean
      {
         return checkDistance(param1,param2) && checkOrientation(param1,param2) && checkLinearVelocity(param1,param2) && checkAngularVelocity(param1,param2);
      }
      
      private static function checkDistance(param1:MoveCommand, param2:MoveCommand) : Boolean
      {
         return diffSqr(param1.position,param2.position) < nearDistanceSqr;
      }
      
      private static function checkLinearVelocity(param1:MoveCommand, param2:MoveCommand) : Boolean
      {
         return diffSqr(param1.linearVelocity,param2.linearVelocity) < nearVelocitySqr;
      }
      
      private static function checkOrientation(param1:MoveCommand, param2:MoveCommand) : Boolean
      {
         var _loc3_:Vector3d = param2.orientation;
         var _loc4_:Vector3d = param1.orientation;
         return Math.abs(_loc4_.x - _loc3_.x) < nearOrientationRad && Math.abs(_loc4_.y - _loc3_.y) < nearOrientationRad && Math.abs(_loc4_.z - _loc3_.z) < nearOrientationRad;
      }
      
      private static function checkAngularVelocity(param1:MoveCommand, param2:MoveCommand) : Boolean
      {
         var _loc3_:Vector3d = param2.angularVelocity;
         var _loc4_:Vector3d = param1.angularVelocity;
         return Math.abs(_loc4_.x - _loc3_.x) < nearRotationDirRad && Math.abs(_loc4_.y - _loc3_.y) < nearRotationDirRad && Math.abs(_loc4_.z - _loc3_.z) < nearRotationDirRad;
      }
      
      private static function diffSqr(param1:Vector3d, param2:Vector3d) : Number
      {
         var _loc3_:Number = param1.x - param2.x;
         var _loc4_:Number = param1.y - param2.y;
         var _loc5_:Number = param1.z - param2.z;
         return _loc3_ * _loc3_ + _loc4_ * _loc4_ + _loc5_ * _loc5_;
      }
      
      private static function cosAngleBetween(param1:Vector3d, param2:Vector3d) : Number
      {
         var _loc3_:Number = length(param1);
         var _loc4_:Number = length(param2);
         return (param1.x * param2.x + param1.y * param2.y + param1.z * param2.z) / _loc3_ / _loc4_;
      }
      
      private static function length(param1:Vector3d) : Number
      {
         return Math.sqrt(param1.x * param1.x + param1.y * param1.y + param1.z * param1.z);
      }
      
      public static function getDiffs(param1:MoveCommand, param2:MoveCommand) : String
      {
         return dumpDistance(param1,param2) + " " + dumpOrientation(param1,param2) + " " + dumpLinearVelocity(param1,param2) + " " + dumpAngularVelocity(param1,param2) + " " + dumpBooleans(param1,param2);
      }
      
      private static function dumpBooleans(param1:MoveCommand, param2:MoveCommand) : String
      {
         return (checkDistance(param1,param2) ? "T" : "F") + (checkOrientation(param1,param2) ? "T" : "F") + (checkLinearVelocity(param1,param2) ? "T" : "F") + (checkAngularVelocity(param1,param2) ? "T" : "F");
      }
      
      private static function dumpDistance(param1:MoveCommand, param2:MoveCommand) : String
      {
         return "dist: [" + diffSqr(param1.position,param2.position) + "/" + nearDistanceSqr + "]";
      }
      
      private static function dumpOrientation(param1:MoveCommand, param2:MoveCommand) : String
      {
         var _loc3_:Vector3d = param2.orientation;
         var _loc4_:Vector3d = param1.orientation;
         return "ori: [X:" + Math.abs(_loc4_.x - _loc3_.x) + "/" + nearOrientationRad + "];[Y:" + Math.abs(_loc4_.x - _loc3_.x) + "/" + nearOrientationRad + "];[Z:" + Math.abs(_loc4_.x - _loc3_.x) + "/" + nearOrientationRad + "]";
      }
      
      private static function dumpLinearVelocity(param1:MoveCommand, param2:MoveCommand) : String
      {
         return "lV: [" + diffSqr(param1.linearVelocity,param2.linearVelocity) + "/" + nearVelocitySqr + "]";
      }
      
      private static function dumpAngularVelocity(param1:MoveCommand, param2:MoveCommand) : String
      {
         var _loc3_:Vector3d = param2.angularVelocity;
         var _loc4_:Vector3d = param1.angularVelocity;
         return "oV: [X:" + Math.abs(_loc4_.x - _loc3_.x) + "/" + nearRotationDirRad + "];[Y:" + Math.abs(_loc4_.x - _loc3_.x) + "/" + nearRotationDirRad + "];[Z:" + Math.abs(_loc4_.x - _loc3_.x) + "/" + nearRotationDirRad + "]";
      }
   }
}


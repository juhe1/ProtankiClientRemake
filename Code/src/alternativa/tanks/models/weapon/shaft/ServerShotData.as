
package alternativa.tanks.models.weapon.shaft
{
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   internal class ServerShotData
   {
      
      public var staticHitPoint:Vector3d;
      
      public var hitPoints:Vector.<Vector3d>;
      
      public var tanks:Vector.<IGameObject>;
      
      public var incarnations:Vector.<int>;
      
      public var tankPositions:Vector.<Vector3d>;
      
      public var targetPositionsGlobal:Vector.<Vector3d>;
      
      public function ServerShotData(param1:Vector3d, param2:Vector.<Vector3d>, param3:Vector.<IGameObject>, param4:Vector.<int>, param5:Vector.<Vector3d>, param6:Vector.<Vector3d>)
      {
         super();
         this.staticHitPoint = param1;
         this.hitPoints = param2;
         this.tanks = param3;
         this.incarnations = param4;
         this.tankPositions = param5;
         this.targetPositionsGlobal = param6;
      }
   }
}

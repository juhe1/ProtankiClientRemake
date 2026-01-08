package alternativa.tanks.models.tank.hullcommon
{
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.armor.common.HullCommonCC;
   import projects.tanks.client.battlefield.models.tankparts.armor.common.HullCommonModelBase;
   import projects.tanks.client.battlefield.models.tankparts.armor.common.IHullCommonModelBase;
   
   [ModelInfo]
   public class HullCommonModel extends HullCommonModelBase implements IHullCommonModelBase, HullCommon
   {
      
      public function HullCommonModel()
      {
         super();
      }
      
      public function getDeadColoring() : ImageResource
      {
         return getInitParam().deadColoring;
      }
      
      public function getCC() : HullCommonCC
      {
         return getInitParam();
      }
      
      public function getMass() : Number
      {
         return getInitParam().mass;
      }
      
      public function getDamping() : Number
      {
         return getInitParam().damping;
      }
      
      public function setTankObject(param1:IGameObject) : void
      {
         putData(IGameObject,param1);
      }
      
      public function getTankObject() : IGameObject
      {
         return IGameObject(getData(IGameObject));
      }
   }
}


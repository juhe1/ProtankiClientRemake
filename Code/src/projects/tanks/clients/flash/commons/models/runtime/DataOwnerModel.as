package projects.tanks.clients.flash.commons.models.runtime
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.commons.models.runtime.DataOwnerModelBase;
   import projects.tanks.client.commons.models.runtime.IDataOwnerModelBase;
   
   [ModelInfo]
   public class DataOwnerModel extends DataOwnerModelBase implements IDataOwnerModelBase, DataOwner
   {
      
      public function DataOwnerModel()
      {
         super();
      }
      
      public function equals(param1:IGameObject) : Boolean
      {
         var _loc2_:Long = this.getDataOwnerId();
         var _loc3_:Long = this.getDataOwnerIdFor(param1);
         return _loc2_.high == _loc3_.high && _loc2_.low == _loc3_.low;
      }
      
      public function getDataOwnerId() : Long
      {
         return getInitParam().dataOwnerId;
      }
      
      private function getDataOwnerIdFor(param1:IGameObject) : Long
      {
         var _loc2_:Long = null;
         Model.object = param1;
         _loc2_ = getInitParam().dataOwnerId;
         Model.popObject();
         return _loc2_;
      }
   }
}


package alternativa.tanks.models.tank.hullcommon
{
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.armor.common.HullCommonCC;
   
   public class HullCommonAdapt implements HullCommon
   {
      
      private var object:IGameObject;
      
      private var impl:HullCommon;
      
      public function HullCommonAdapt(param1:IGameObject, param2:HullCommon)
      {
         super();
         this.object = param1;
         this.impl = param2;
      }
      
      public function getCC() : HullCommonCC
      {
         var result:HullCommonCC = null;
         try
         {
            Model.object = this.object;
            result = this.impl.getCC();
         }
         finally
         {
            Model.popObject();
         }
         return result;
      }
      
      public function getDeadColoring() : ImageResource
      {
         var result:ImageResource = null;
         try
         {
            Model.object = this.object;
            result = this.impl.getDeadColoring();
         }
         finally
         {
            Model.popObject();
         }
         return result;
      }
      
      public function getMass() : Number
      {
         var result:Number = NaN;
         try
         {
            Model.object = this.object;
            result = Number(this.impl.getMass());
         }
         finally
         {
            Model.popObject();
         }
         return result;
      }
      
      public function getDamping() : Number
      {
         var result:Number = NaN;
         try
         {
            Model.object = this.object;
            result = Number(this.impl.getDamping());
         }
         finally
         {
            Model.popObject();
         }
         return result;
      }
      
      public function setTankObject(param1:IGameObject) : void
      {
         var tank:IGameObject = param1;
         try
         {
            Model.object = this.object;
            this.impl.setTankObject(tank);
         }
         finally
         {
            Model.popObject();
         }
      }
      
      public function getTankObject() : IGameObject
      {
         var result:IGameObject = null;
         try
         {
            Model.object = this.object;
            result = this.impl.getTankObject();
         }
         finally
         {
            Model.popObject();
         }
         return result;
      }
   }
}


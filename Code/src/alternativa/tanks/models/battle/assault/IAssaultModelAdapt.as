package alternativa.tanks.models.battle.assault
{
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class IAssaultModelAdapt implements IAssaultModel
   {
      
      private var object:IGameObject;
      
      private var impl:IAssaultModel;
      
      public function IAssaultModelAdapt(param1:IGameObject, param2:IAssaultModel)
      {
         super();
         this.object = param1;
         this.impl = param2;
      }
      
      public function onEnterFlagBaseZone() : void
      {
         try
         {
            Model.object = this.object;
            this.impl.onEnterFlagBaseZone();
         }
         finally
         {
            Model.popObject();
         }
      }
      
      public function onLeaveFlagBaseZone() : void
      {
         try
         {
            Model.object = this.object;
            this.impl.onLeaveFlagBaseZone();
         }
         finally
         {
            Model.popObject();
         }
      }
      
      public function onFlagTouch(param1:int) : void
      {
         var flagId:int = param1;
         try
         {
            Model.object = this.object;
            this.impl.onFlagTouch(flagId);
         }
         finally
         {
            Model.popObject();
         }
      }
      
      public function onPickupTimeoutPassed(param1:int) : void
      {
         var flagId:int = param1;
         try
         {
            Model.object = this.object;
            this.impl.onPickupTimeoutPassed(flagId);
         }
         finally
         {
            Model.popObject();
         }
      }
   }
}


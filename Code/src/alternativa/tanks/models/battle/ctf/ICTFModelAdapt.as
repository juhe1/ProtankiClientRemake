package alternativa.tanks.models.battle.ctf
{
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class ICTFModelAdapt implements ICTFModel
   {
      
      private var object:IGameObject;
      
      private var impl:ICTFModel;
      
      public function ICTFModelAdapt(param1:IGameObject, param2:ICTFModel)
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
      
      public function onFlagTouch(param1:CTFFlag) : void
      {
         var flag:CTFFlag = param1;
         try
         {
            Model.object = this.object;
            this.impl.onFlagTouch(flag);
         }
         finally
         {
            Model.popObject();
         }
      }
      
      public function onPickupTimeoutPassed() : void
      {
         try
         {
            Model.object = this.object;
            this.impl.onPickupTimeoutPassed();
         }
         finally
         {
            Model.popObject();
         }
      }
   }
}


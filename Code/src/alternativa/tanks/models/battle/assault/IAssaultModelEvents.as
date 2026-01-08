package alternativa.tanks.models.battle.assault
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class IAssaultModelEvents implements IAssaultModel
   {
      
      private var object:IGameObject;
      
      private var impl:Vector.<IAssaultModel>;
      
      public function IAssaultModelEvents(param1:IGameObject, param2:Vector.<IModel>)
      {
         super();
         this.object = param1;
         this.impl = new Vector.<IAssaultModel>();
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            this.impl.push(param2[_loc3_]);
            _loc3_++;
         }
      }
      
      public function onEnterFlagBaseZone() : void
      {
         var i:int = 0;
         var m:IAssaultModel = null;
         try
         {
            Model.object = this.object;
            i = 0;
            while(i < this.impl.length)
            {
               m = this.impl[i];
               m.onEnterFlagBaseZone();
               i++;
            }
         }
         finally
         {
            Model.popObject();
         }
      }
      
      public function onLeaveFlagBaseZone() : void
      {
         var i:int = 0;
         var m:IAssaultModel = null;
         try
         {
            Model.object = this.object;
            i = 0;
            while(i < this.impl.length)
            {
               m = this.impl[i];
               m.onLeaveFlagBaseZone();
               i++;
            }
         }
         finally
         {
            Model.popObject();
         }
      }
      
      public function onFlagTouch(param1:int) : void
      {
         var i:int = 0;
         var m:IAssaultModel = null;
         var flagId:int = param1;
         try
         {
            Model.object = this.object;
            i = 0;
            while(i < this.impl.length)
            {
               m = this.impl[i];
               m.onFlagTouch(flagId);
               i++;
            }
         }
         finally
         {
            Model.popObject();
         }
      }
      
      public function onPickupTimeoutPassed(param1:int) : void
      {
         var i:int = 0;
         var m:IAssaultModel = null;
         var flagId:int = param1;
         try
         {
            Model.object = this.object;
            i = 0;
            while(i < this.impl.length)
            {
               m = this.impl[i];
               m.onPickupTimeoutPassed(flagId);
               i++;
            }
         }
         finally
         {
            Model.popObject();
         }
      }
   }
}


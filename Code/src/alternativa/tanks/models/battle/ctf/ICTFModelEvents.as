package alternativa.tanks.models.battle.ctf
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class ICTFModelEvents implements ICTFModel
   {
      
      private var object:IGameObject;
      
      private var impl:Vector.<ICTFModel>;
      
      public function ICTFModelEvents(param1:IGameObject, param2:Vector.<IModel>)
      {
         super();
         this.object = param1;
         this.impl = new Vector.<ICTFModel>();
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
         var m:ICTFModel = null;
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
         var m:ICTFModel = null;
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
      
      public function onFlagTouch(param1:CTFFlag) : void
      {
         var i:int = 0;
         var m:ICTFModel = null;
         var flag:CTFFlag = param1;
         try
         {
            Model.object = this.object;
            i = 0;
            while(i < this.impl.length)
            {
               m = this.impl[i];
               m.onFlagTouch(flag);
               i++;
            }
         }
         finally
         {
            Model.popObject();
         }
      }
      
      public function onPickupTimeoutPassed() : void
      {
         var i:int = 0;
         var m:ICTFModel = null;
         try
         {
            Model.object = this.object;
            i = 0;
            while(i < this.impl.length)
            {
               m = this.impl[i];
               m.onPickupTimeoutPassed();
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


package alternativa.tanks.models.sfx.bcsh
{
   import flash.filters.BitmapFilter;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class IBcshAdapt implements IBcsh
   {
      
      private var object:IGameObject;
      
      private var impl:IBcsh;
      
      public function IBcshAdapt(param1:IGameObject, param2:IBcsh)
      {
         super();
         this.object = param1;
         this.impl = param2;
      }
      
      public function createFilter(param1:String) : BitmapFilter
      {
         var result:BitmapFilter = null;
         var key:String = param1;
         try
         {
            Model.object = this.object;
            result = this.impl.createFilter(key);
         }
         finally
         {
            Model.popObject();
         }
         return result;
      }
   }
}


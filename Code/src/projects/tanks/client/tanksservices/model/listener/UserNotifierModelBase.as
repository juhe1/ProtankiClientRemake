package projects.tanks.client.tanksservices.model.listener
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.impl.Model;
   
   public class UserNotifierModelBase extends Model
   {
      protected var server:UserNotifierModelServer = new UserNotifierModelServer(this);
      
      private var client:IUserNotifierModelBase = IUserNotifierModelBase(this);
      
      static public var modelId:Long = Long.getLong(1490830385,-2144376380);
      
      public function UserNotifierModelBase()
      {
         super();
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}


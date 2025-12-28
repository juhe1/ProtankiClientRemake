package projects.tanks.client.entrance.model.entrance.registration
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.model.IModel;
   
   public class RegistrationModelBase extends Model
   {
      protected var server:RegistrationModelServer = new RegistrationModelServer(IModel(this));
      
      private var client:IRegistrationModelBase = IRegistrationModelBase(this);
      
      static public var modelId:Long = Long.getLong(576129845,453074872);

      public function RegistrationModelBase()
      {
         super();
      }
      
      protected function getInitParam() : RegistrationModelCC
      {
         return RegistrationModelCC(initParams[platform.client.fp10.core.model.impl.Model.currentObject]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}


package projects.tanks.client.entrance.model.entrance.partners
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class CompositePartnerModelBase extends Model
   {
      protected var server:CompositePartnerModelServer;
      
      private var client:ICompositePartnerModelBase = ICompositePartnerModelBase(this);
      
      public static var modelId:Long = Long.getLong(119483168,-902850894);
      
      public function CompositePartnerModelBase()
      {
         super();
         this.initCodecs();
      }
      
      protected function initCodecs() : void
      {
         this.server = new CompositePartnerModelServer(IModel(this));
      }
      
      protected function getInitParam() : CompositePartnerCC
      {
         return CompositePartnerCC(initParams[platform.client.fp10.core.model.impl.Model.currentObject]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}


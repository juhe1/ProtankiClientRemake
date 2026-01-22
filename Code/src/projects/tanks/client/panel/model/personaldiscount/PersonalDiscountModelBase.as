package projects.tanks.client.panel.model.personaldiscount
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PersonalDiscountModelBase extends Model
   {

      protected var server:PersonalDiscountModelServer;

      public static const modelId:Long = Long.getLong(897429325,1733728636);

      public function PersonalDiscountModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PersonalDiscountModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}

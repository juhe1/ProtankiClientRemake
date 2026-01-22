package projects.tanks.client.partners.impl.china.partner4399
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class Partner4399ModelBase extends Model
   {

      protected var server:Partner4399ModelServer;

      public static const modelId:Long = Long.getLong(15219793,-1921200771);

      public function Partner4399ModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new Partner4399ModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}

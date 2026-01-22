package projects.tanks.client.panel.model.shop.enable.paymode
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RestrictionByPayModeModelBase extends Model
   {

      protected var server:RestrictionByPayModeModelServer;

      public static const modelId:Long = Long.getLong(2061464659,240727734);

      public function RestrictionByPayModeModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RestrictionByPayModeModelServer(IModel(this));
      }

      protected function getInitParam() : RestrictionByPayModeCC
      {
         return RestrictionByPayModeCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}

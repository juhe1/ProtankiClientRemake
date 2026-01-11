package projects.tanks.client.battlefield.models.tankparts.armor.common
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class HullCommonModelBase extends Model
   {

      protected var server:HullCommonModelServer;

      public static const modelId:Long = Long.getLong(2136429398,-1896774533);

      public function HullCommonModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new HullCommonModelServer(IModel(this));
      }

      protected function getInitParam() : HullCommonCC
      {
         return HullCommonCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}

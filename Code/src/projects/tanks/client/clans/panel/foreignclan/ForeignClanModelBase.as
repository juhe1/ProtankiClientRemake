package projects.tanks.client.clans.panel.foreignclan
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ForeignClanModelBase extends Model
   {

      protected var server:ForeignClanModelServer;

      public static const modelId:Long = Long.getLong(1029456312,194126704);

      public function ForeignClanModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ForeignClanModelServer(IModel(this));
      }

      protected function getInitParam() : ForeignClanCC
      {
         return ForeignClanCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}

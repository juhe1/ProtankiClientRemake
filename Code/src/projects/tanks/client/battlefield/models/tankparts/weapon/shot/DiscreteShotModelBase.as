package projects.tanks.client.battlefield.models.tankparts.weapon.shot
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DiscreteShotModelBase extends Model
   {

      protected var server:DiscreteShotModelServer;

      private static const modelId:Long = Long.getLong(968114218,-1703577718);

      public function DiscreteShotModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new DiscreteShotModelServer(IModel(this));
      }

      protected function getInitParam() : ShotCC
      {
         return ShotCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}

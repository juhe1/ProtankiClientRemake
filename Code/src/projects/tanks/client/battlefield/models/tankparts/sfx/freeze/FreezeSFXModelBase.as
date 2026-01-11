package projects.tanks.client.battlefield.models.tankparts.sfx.freeze
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class FreezeSFXModelBase extends Model
   {

      protected var server:FreezeSFXModelServer;

      public static const modelId:Long = Long.getLong(196518382,153197781);

      public function FreezeSFXModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FreezeSFXModelServer(IModel(this));
      }

      protected function getInitParam() : FreezeSFXCC
      {
         return FreezeSFXCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}

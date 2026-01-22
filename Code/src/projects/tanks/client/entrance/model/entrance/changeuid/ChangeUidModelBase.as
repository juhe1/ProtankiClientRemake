package projects.tanks.client.entrance.model.entrance.changeuid
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ChangeUidModelBase extends Model
   {

      protected var server:ChangeUidModelServer;

      public static const modelId:Long = Long.getLong(334342439,-2018007012);

      public function ChangeUidModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ChangeUidModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}

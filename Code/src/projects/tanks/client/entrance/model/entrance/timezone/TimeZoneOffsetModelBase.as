package projects.tanks.client.entrance.model.entrance.timezone
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TimeZoneOffsetModelBase extends Model
   {

      protected var server:TimeZoneOffsetModelServer;

      public static const modelId:Long = Long.getLong(615172736,1458878101);

      public function TimeZoneOffsetModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TimeZoneOffsetModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}

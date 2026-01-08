package projects.tanks.client.commons.models.layout.notify
{

   import alternativa.types.Long;
   import platform.client.fp10.core.model.impl.Model;

   public class LobbyLayoutNotifyModelBase extends Model
   {

      static public var modelId:Long = Long.getLong(1481647778,-291699533);

      public function LobbyLayoutNotifyModelBase()
      {
         super();
      }

      override public function get id() : Long
      {
         return LobbyLayoutNotifyModelBase.modelId;
      }
   }
}

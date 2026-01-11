package projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ArtilleryRotatingTurretModelBase extends Model
   {

      protected var server:ArtilleryRotatingTurretModelServer;

      public static const modelId:Long = Long.getLong(1240706018,-961658094);

      public function ArtilleryRotatingTurretModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ArtilleryRotatingTurretModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}

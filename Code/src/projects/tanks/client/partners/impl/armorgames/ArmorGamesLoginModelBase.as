package projects.tanks.client.partners.impl.armorgames
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ArmorGamesLoginModelBase extends Model
   {

      protected var server:ArmorGamesLoginModelServer;

      public static const modelId:Long = Long.getLong(646093752,676236431);

      public function ArmorGamesLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ArmorGamesLoginModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}

package projects.tanks.client.partners.impl.miniclip
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MiniclipLoginModelBase extends Model
   {

      protected var server:MiniclipLoginModelServer;

      public static const modelId:Long = Long.getLong(819736117,596240975);

      public function MiniclipLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MiniclipLoginModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}

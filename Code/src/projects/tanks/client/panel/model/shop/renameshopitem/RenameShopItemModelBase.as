package projects.tanks.client.panel.model.shop.renameshopitem
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RenameShopItemModelBase extends Model
   {

      protected var server:RenameShopItemModelServer;

      public static const modelId:Long = Long.getLong(152091300,-295885938);

      public function RenameShopItemModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RenameShopItemModelServer(IModel(this));
      }

      protected function getInitParam() : RenameShopItemCC
      {
         return RenameShopItemCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}

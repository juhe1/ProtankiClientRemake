package alternativa.tanks.models.battle.battlefield.billboard
{
   import alternativa.tanks.battle.BattleService;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.battlefield.models.battle.battlefield.billboard.BillboardsModelBase;
   import projects.tanks.client.battlefield.models.battle.battlefield.billboard.IBillboardsModelBase;
   
   [ModelInfo]
   public class BillboardsModel extends BillboardsModelBase implements IBillboardsModelBase, ObjectLoadPostListener
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      public function BillboardsModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         var _loc1_:ImageResource = getInitParam().defaultBillboardImage;
         battleService.setBillboardImage(_loc1_.data);
      }
   }
}


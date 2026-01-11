package alternativa.tanks.models.bonus.common
{
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.bonuses.BattleBonus;
   import alternativa.tanks.bonuses.BattleBonusData;
   import alternativa.tanks.bonuses.Bonus;
   import alternativa.tanks.models.bonus.bonuslight.BonusLight;
   import alternativa.tanks.models.bonus.bonuslight.IBonusLight;
   import alternativa.tanks.models.effects.common.IBonusCommonModel;
   import alternativa.types.Long;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.display.BitmapData;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.StubBitmapData;
   import projects.tanks.client.battlefield.models.bonus.bonus.common.BonusCommonModelBase;
   import projects.tanks.client.battlefield.models.bonus.bonus.common.IBonusCommonModelBase;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   [ModelInfo]
   public class BonusCommonModel extends BonusCommonModelBase implements IBonusCommonModelBase, ObjectLoadListener, ObjectUnloadListener, IBonusCommonModel
   {
      
      [Inject]
      public static var materialRegistry:TextureMaterialRegistry;
      
      [Inject]
      public static var battleService:BattleService;
      
      private static var stubBitmapData:BitmapData;
      
      public function BonusCommonModel()
      {
         super();
      }
      
      private static function getMeshFromResource(param1:Tanks3DSResource) : Mesh
      {
         var _loc2_:Mesh = Mesh(param1.objects[0]);
         var _loc3_:BitmapData = param1.getTextureForObject(0);
         if(_loc3_ == null)
         {
            _loc3_ = getStubBitmapData();
         }
         var _loc4_:Mesh = Mesh(_loc2_.clone());
         var _loc5_:TextureMaterial = materialRegistry.getMaterial(_loc3_);
         _loc5_.resolution = 1;
         _loc4_.setMaterialToAllFaces(_loc5_);
         return _loc4_;
      }
      
      private static function getStubBitmapData() : BitmapData
      {
         if(stubBitmapData == null)
         {
            stubBitmapData = new StubBitmapData(65280);
         }
         return stubBitmapData;
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:BattleBonusData = new BattleBonusData();
         _loc1_.boxMesh = getMeshFromResource(getInitParam().boxResource);
         _loc1_.parachuteOuterMesh = getMeshFromResource(getInitParam().parachuteResource);
         _loc1_.parachuteInnerMesh = getMeshFromResource(getInitParam().parachuteInnerResource);
         _loc1_.cordsMaterial = materialRegistry.getMaterial(getInitParam().cordResource.data);
         _loc1_.cordsMaterial.resolution = 5;
         if(getInitParam().pickupSoundResource != null)
         {
            _loc1_.pickupSound = getInitParam().pickupSoundResource.sound;
         }
         var _loc2_:BonusLight = IBonusLight(object.adapt(IBonusLight)).getBonusLight();
         _loc1_.lightColor = _loc2_.getLightColor().getColor();
         _loc1_.lightIntensity = _loc2_.getLightColor().getIntensity();
         _loc1_.attenuationBegin = _loc2_.getAttenuationBegin();
         _loc1_.attenuationEnd = _loc2_.getAttenuationEnd();
         putData(BattleBonusData,_loc1_);
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         var _loc1_:BattleBonusData = BattleBonusData(getData(BattleBonusData));
         materialRegistry.releaseMaterial(this.getMeshMaterial(_loc1_.boxMesh));
         materialRegistry.releaseMaterial(this.getMeshMaterial(_loc1_.parachuteInnerMesh));
         materialRegistry.releaseMaterial(this.getMeshMaterial(_loc1_.parachuteOuterMesh));
         materialRegistry.releaseMaterial(_loc1_.cordsMaterial);
      }
      
      private function getMeshMaterial(param1:Mesh) : TextureMaterial
      {
         var _loc2_:Face = param1.faces[0];
         return TextureMaterial(_loc2_.material);
      }
      
      public function getBonus(param1:String) : Bonus
      {
         var _loc2_:BattleBonusData = BattleBonusData(getData(BattleBonusData));
         var _loc3_:BattleBonus = BattleBonus(battleService.getObjectPool().getObject(BattleBonus));
         _loc3_.init(object.id,param1,_loc2_,battleService);
         return _loc3_;
      }
   }
}


package alternativa.tanks.sfx
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.display.BlendMode;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   public class BonusCrystalsEffectUtils
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var materialRegistry:TextureMaterialRegistry;
      
      public function BonusCrystalsEffectUtils()
      {
         super();
      }
      
      public static function drawEffectForCatcherPosition(param1:Vector3d, param2:int, param3:TextureMaterial) : void
      {
         var _loc4_:CrystalBonusEffect = CrystalBonusEffect(battleService.getObjectPool().getObject(CrystalBonusEffect));
         _loc4_.init(param2,param3.texture.width * 2,param3.texture.height * 2,0,750,200,0.55,0,0,50,param1,param3,BlendMode.NORMAL);
         battleService.getBattleScene3D().addGraphicEffect(_loc4_);
      }
      
      public static function getTargetPosition(param1:IGameObject) : Vector3d
      {
         var _loc2_:ITankModel = ITankModel(param1.adapt(ITankModel));
         var _loc3_:Tank = _loc2_.getTank();
         var _loc4_:Object3D = _loc3_.getSkin().getTurret3D();
         return new Vector3d(_loc4_.x,_loc4_.y,_loc4_.z);
      }
   }
}


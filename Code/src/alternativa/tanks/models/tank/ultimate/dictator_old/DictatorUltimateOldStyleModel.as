package alternativa.tanks.models.tank.ultimate.dictator_old
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.battle.gui.inventory.InventorySoundService;
   import alternativa.tanks.models.effects.ultimate.SparkleSphereEffect;
   import alternativa.tanks.models.inventory.InventoryItemType;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.tank.LocalTankInfoService;
   import alternativa.tanks.models.tank.hullcommon.HullCommon;
   import alternativa.tanks.models.tank.ultimate.UltimateModel;
   import flash.geom.ColorTransform;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.ultimate.effects.dictator_old.DictatorUltimateOldStyleModelBase;
   import projects.tanks.client.battlefield.models.ultimate.effects.dictator_old.IDictatorUltimateOldStyleModelBase;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   
   [ModelInfo]
   public class DictatorUltimateOldStyleModel extends DictatorUltimateOldStyleModelBase implements IDictatorUltimateOldStyleModelBase, ObjectLoadListener
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var localTankInfoService:LocalTankInfoService;
      
      [Inject]
      public static var inventorySoundService:InventorySoundService;
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      public function DictatorUltimateOldStyleModel()
      {
         super();
      }
      
      private static function isAlly(param1:Tank, param2:Tank) : Boolean
      {
         if(param1 == param2)
         {
            return true;
         }
         if(param1.teamType == BattleTeam.NONE || param2.teamType == BattleTeam.NONE)
         {
            return false;
         }
         return param1.teamType == param2.teamType;
      }
      
      public function objectLoaded() : void
      {
         inventorySoundService.setUltimateSound(getInitParam().activateSound.sound);
      }
      
      public function showUltimateUsed(param1:IGameObject, param2:Vector.<IGameObject>) : void
      {
         var _loc4_:IGameObject = null;
         var _loc3_:IGameObject = HullCommon(object.adapt(HullCommon)).getTankObject();
         inventorySoundService.playActivationSound(_loc3_,InventoryItemType.ULTIMATE);
         for each(_loc4_ in param2)
         {
            this.createSparkleEffect(_loc4_);
         }
      }
      
      private function createSparkleEffect(param1:IGameObject) : void
      {
         var _loc2_:ITankModel = ITankModel(param1.adapt(ITankModel));
         var _loc3_:IGameObject = _loc2_.getTankSet().hull;
         var _loc4_:Tank = _loc2_.getTank();
         var _loc5_:Boolean = _loc3_ != object;
         var _loc6_:Boolean = isAlly(localTankInfoService.getLocalTank(),_loc2_.getTank());
         var _loc7_:TextureMaterial = new TextureMaterial(getInitParam().sparkImage.data);
         var _loc8_:ColorTransform = UltimateModel.parseColorTransform(getInitParam().positiveColorTransform);
         var _loc9_:SparkleSphereEffect = SparkleSphereEffect(battleService.getObjectPool().getObject(SparkleSphereEffect));
         var _loc10_:ColorTransform = _loc6_ ? _loc8_ : null;
         _loc9_.init(_loc7_,_loc4_.getSkin().getHullMesh(),_loc5_,_loc10_);
         battleService.addGraphicEffect(_loc9_);
      }
   }
}


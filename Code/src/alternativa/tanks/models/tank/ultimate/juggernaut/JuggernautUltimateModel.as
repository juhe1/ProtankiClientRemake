package alternativa.tanks.models.tank.ultimate.juggernaut
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.battle.gui.inventory.InventorySoundService;
   import alternativa.tanks.models.effects.ultimate.SparkleSphereEffect;
   import alternativa.tanks.models.inventory.InventoryItemType;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.tank.hullcommon.HullCommon;
   import alternativa.tanks.models.tank.ultimate.UltimateModel;
   import flash.geom.ColorTransform;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.ultimate.effects.juggernaut.IJuggernautUltimateEffectModelBase;
   import projects.tanks.client.battlefield.models.ultimate.effects.juggernaut.JuggernautUltimateEffectModelBase;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   
   [ModelInfo]
   public class JuggernautUltimateModel extends JuggernautUltimateEffectModelBase implements IJuggernautUltimateEffectModelBase, ObjectLoadListener
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var inventorySoundService:InventorySoundService;
      
      [Inject] // added
      public static var battleInfoService:IBattleInfoService;
      
      public function JuggernautUltimateModel()
      {
         super();
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
         this.createSparkleEffect(param1,true);
         for each(_loc4_ in param2)
         {
            this.createSparkleEffect(_loc4_,false);
         }
      }
      
      private function createSparkleEffect(param1:IGameObject, param2:Boolean) : void
      {
         var _loc3_:ITankModel = ITankModel(param1.adapt(ITankModel));
         var _loc4_:IGameObject = _loc3_.getTankSet().hull;
         var _loc5_:Tank = _loc3_.getTank();
         var _loc6_:Boolean = _loc4_ != object;
         var _loc7_:TextureMaterial = new TextureMaterial(getInitParam().sparkImage.data);
         var _loc8_:ColorTransform = UltimateModel.parseColorTransform(getInitParam().positiveColorTransform);
         var _loc9_:ColorTransform = UltimateModel.parseColorTransform(getInitParam().positiveColorTransform);
         var _loc10_:SparkleSphereEffect = SparkleSphereEffect(battleService.getObjectPool().getObject(SparkleSphereEffect));
         var _loc11_:ColorTransform = param2 ? _loc8_ : _loc9_;
         _loc10_.init(_loc7_,_loc5_.getSkin().getHullMesh(),_loc6_,_loc11_);
         battleService.addGraphicEffect(_loc10_);
      }
   }
}


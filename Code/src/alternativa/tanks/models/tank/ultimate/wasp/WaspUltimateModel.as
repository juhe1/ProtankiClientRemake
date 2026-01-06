package alternativa.tanks.models.tank.ultimate.wasp
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.models.battle.gui.inventory.InventorySoundService;
   import alternativa.tanks.models.battle.meteor.nuclear.NuclearBangEffect;
   import alternativa.tanks.models.inventory.InventoryItemType;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.utils.TextureMaterialRegistry;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.ultimate.effects.wasp.IWaspUltimateModelBase;
   import projects.tanks.client.battlefield.models.ultimate.effects.wasp.WaspUltimateModelBase;
   
   [ModelInfo]
   public class WaspUltimateModel extends WaspUltimateModelBase implements IWaspUltimateModelBase, ObjectLoadListener
   {
      
      [Inject]
      public static var inventorySoundService:InventorySoundService;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var textureMaterialRegistry:TextureMaterialRegistry;
      
      private static var vector:Vector3 = new Vector3();
      
      public function WaspUltimateModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         inventorySoundService.setUltimateSound(getInitParam().effectStartSound.sound);
      }
      
      public function showUltimateUsed(param1:IGameObject, param2:Vector.<IGameObject>) : void
      {
         inventorySoundService.playActivationSound(param1,InventoryItemType.ULTIMATE);
         var _loc3_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().nuclearBangFlame.data);
         var _loc4_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().nuclearBangLight.data);
         var _loc5_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().nuclearBangSmoke.data);
         var _loc6_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().nuclearBangWave.data);
         var _loc7_:NuclearBangEffect = new NuclearBangEffect(battleService.getObjectPool(),_loc4_,_loc6_,_loc5_,_loc3_);
         var _loc8_:Mesh = ITankModel(param1.adapt(ITankModel)).getTank().getSkin().getHullMesh();
         vector.reset(_loc8_.x,_loc8_.y,_loc8_.z);
         _loc7_.play(vector,battleService.getBattleScene3D());
      }
   }
}


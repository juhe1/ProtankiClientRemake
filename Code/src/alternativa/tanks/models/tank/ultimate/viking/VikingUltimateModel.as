package alternativa.tanks.models.tank.ultimate.viking
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.models.battle.gui.inventory.InventorySoundService;
   import alternativa.tanks.models.inventory.InventoryItemType;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.utils.TextureMaterialRegistry;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.ultimate.effects.viking.IVikingUltimateModelBase;
   import projects.tanks.client.battlefield.models.ultimate.effects.viking.VikingUltimateModelBase;
   
   [ModelInfo]
   public class VikingUltimateModel extends VikingUltimateModelBase implements IVikingUltimateModelBase, ObjectLoadListener
   {
      
      [Inject]
      public static var inventorySoundService:InventorySoundService;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var textureMaterialRegistry:TextureMaterialRegistry;
      
      public function VikingUltimateModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         inventorySoundService.setUltimateSound(getInitParam().effectStartSound.sound);
      }
      
      public function showUltimateUsed(param1:IGameObject, param2:Vector.<IGameObject>) : void
      {
         var _loc5_:IGameObject = null;
         inventorySoundService.playActivationSound(param1,InventoryItemType.ULTIMATE);
         var _loc3_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().flame.data);
         var _loc4_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().smoke.data);
         this.createBurnEffect(param1,_loc3_,_loc4_);
         for each(_loc5_ in param2)
         {
            this.createBurnEffect(_loc5_,_loc3_,_loc4_);
         }
      }
      
      private function createBurnEffect(param1:IGameObject, param2:TextureMaterial, param3:TextureMaterial) : void
      {
         var _loc4_:BurningEffect = BurningEffect(battleService.getObjectPool().getObject(BurningEffect));
         var _loc5_:Mesh = ITankModel(param1.adapt(ITankModel)).getTank().getSkin().getHullMesh();
         _loc4_.init(param2,param3,_loc5_,2.5);
         battleService.addGraphicEffect(_loc4_);
      }
   }
}


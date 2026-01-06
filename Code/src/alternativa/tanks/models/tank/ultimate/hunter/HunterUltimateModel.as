package alternativa.tanks.models.tank.ultimate.hunter
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
   import projects.tanks.client.battlefield.models.ultimate.effects.hunter.HunterUltimateModelBase;
   import projects.tanks.client.battlefield.models.ultimate.effects.hunter.IHunterUltimateModelBase;
   
   [ModelInfo]
   public class HunterUltimateModel extends HunterUltimateModelBase implements IHunterUltimateModelBase, ObjectLoadListener
   {
      
      [Inject]
      public static var inventorySoundService:InventorySoundService;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var textureMaterialRegistry:TextureMaterialRegistry;
      
      public function HunterUltimateModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         inventorySoundService.setUltimateSound(getInitParam().effectStartSound.sound);
      }
      
      public function showUltimateUsed(param1:IGameObject, param2:Vector.<IGameObject>) : void
      {
         var _loc6_:IGameObject = null;
         inventorySoundService.playActivationSound(param1,InventoryItemType.ULTIMATE);
         var _loc3_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().electro.data);
         var _loc4_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().energy.data);
         var _loc5_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().lightning.data);
         this.createChargingEffect(_loc4_,param1,1.5);
         for each(_loc6_ in param2)
         {
            this.createLightningEffect(_loc5_,param1,_loc6_);
            this.createElectroEffect(_loc3_,_loc6_,16);
         }
      }
      
      private function createChargingEffect(param1:TextureMaterial, param2:IGameObject, param3:Number) : void
      {
         var _loc4_:EnergyEffect = EnergyEffect(battleService.getObjectPool().getObject(EnergyEffect));
         var _loc5_:Mesh = ITankModel(param2.adapt(ITankModel)).getTank().getSkin().getHullMesh();
         _loc4_.init(param1,_loc5_,param3);
         battleService.addGraphicEffect(_loc4_);
      }
      
      private function createLightningEffect(param1:TextureMaterial, param2:IGameObject, param3:IGameObject) : void
      {
         var _loc4_:LightningEffect = LightningEffect(battleService.getObjectPool().getObject(LightningEffect));
         var _loc5_:Mesh = ITankModel(param2.adapt(ITankModel)).getTank().getSkin().getHullMesh();
         var _loc6_:Mesh = ITankModel(param3.adapt(ITankModel)).getTank().getSkin().getHullMesh();
         _loc4_.init(param1,_loc5_,_loc6_);
         battleService.addGraphicEffect(_loc4_);
      }
      
      private function createElectroEffect(param1:TextureMaterial, param2:IGameObject, param3:uint) : void
      {
         var _loc4_:ElectroEffect = ElectroEffect(battleService.getObjectPool().getObject(ElectroEffect));
         var _loc5_:Mesh = ITankModel(param2.adapt(ITankModel)).getTank().getSkin().getHullMesh();
         _loc4_.init(param1,_loc5_,param3);
         battleService.addGraphicEffect(_loc4_);
      }
   }
}


package alternativa.tanks.models.tank.ultimate.dictator
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
   import projects.tanks.client.battlefield.models.ultimate.effects.dictator.DictatorUltimateModelBase;
   import projects.tanks.client.battlefield.models.ultimate.effects.dictator.IDictatorUltimateModelBase;
   
   [ModelInfo]
   public class DictatorUltimateModel extends DictatorUltimateModelBase implements IDictatorUltimateModelBase, ObjectLoadListener
   {
      
      [Inject] // added
      public static var inventorySoundService:InventorySoundService;
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var textureMaterialRegistry:TextureMaterialRegistry;
      
      public function DictatorUltimateModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         inventorySoundService.setUltimateSound(getInitParam().activationSound.sound);
      }
      
      public function showUltimateUsed(param1:IGameObject, param2:Vector.<IGameObject>) : void
      {
         var _loc3_:IGameObject = null;
         inventorySoundService.playActivationSound(param1,InventoryItemType.ULTIMATE);
         this.createStreamEffect(param1,getInitParam().beamScale);
         this.createWaveEffect(param1);
         for each(_loc3_ in param2)
         {
            this.createStreamEffect(_loc3_,getInitParam().secondaryBeamScale);
         }
      }
      
      private function createWaveEffect(param1:IGameObject) : void
      {
         var _loc2_:DictatorWaveEffect = DictatorWaveEffect(battleService.getObjectPool().getObject(DictatorWaveEffect));
         var _loc3_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().wave.data);
         var _loc4_:Mesh = ITankModel(param1.adapt(ITankModel)).getTank().getSkin().getHullMesh();
         _loc2_.init(_loc3_,_loc4_);
         battleService.addGraphicEffect(_loc2_);
      }
      
      private function createStreamEffect(param1:IGameObject, param2:Number) : void
      {
         var _loc3_:DictatorStreamEffect = DictatorStreamEffect(battleService.getObjectPool().getObject(DictatorStreamEffect));
         var _loc4_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().beam.data);
         var _loc5_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().star.data);
         var _loc6_:Mesh = ITankModel(param1.adapt(ITankModel)).getTank().getSkin().getHullMesh();
         _loc3_.init(_loc4_,_loc5_,_loc6_,param2);
         battleService.addGraphicEffect(_loc3_);
      }
   }
}


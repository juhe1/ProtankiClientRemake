package alternativa.tanks.models.tank.ultimate.hornet
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
   import projects.tanks.client.battlefield.models.ultimate.effects.hornet.HornetUltimateModelBase;
   import projects.tanks.client.battlefield.models.ultimate.effects.hornet.IHornetUltimateModelBase;
   
   [ModelInfo]
   public class HornetUltimateModel extends HornetUltimateModelBase implements IHornetUltimateModelBase, ObjectLoadListener
   {
      
      [Inject] // added
      public static var inventorySoundService:InventorySoundService;
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var textureMaterialRegistry:TextureMaterialRegistry;
      
      public function HornetUltimateModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         inventorySoundService.setUltimateSound(getInitParam().effectStartSound.sound);
      }
      
      public function showUltimateUsed(param1:IGameObject, param2:Vector.<IGameObject>) : void
      {
         var _loc4_:IGameObject = null;
         inventorySoundService.playActivationSound(param1,InventoryItemType.ULTIMATE);
         var _loc3_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().ring.data);
         for each(_loc4_ in param2)
         {
            this.createRadarEffect(_loc4_,_loc3_);
         }
         this.createRadarEffect(param1,_loc3_);
      }
      
      private function createRadarEffect(param1:IGameObject, param2:TextureMaterial) : void
      {
         var _loc3_:RadarEffect = RadarEffect(battleService.getObjectPool().getObject(RadarEffect));
         var _loc4_:Mesh = ITankModel(param1.adapt(ITankModel)).getTank().getSkin().getHullMesh();
         _loc3_.init(param2,_loc4_,2.5);
         battleService.addGraphicEffect(_loc3_);
      }
   }
}


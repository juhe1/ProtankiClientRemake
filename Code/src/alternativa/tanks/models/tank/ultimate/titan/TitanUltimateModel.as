package alternativa.tanks.models.tank.ultimate.titan
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
   import projects.tanks.client.battlefield.models.ultimate.effects.titan.ITitanUltimateModelBase;
   import projects.tanks.client.battlefield.models.ultimate.effects.titan.TitanUltimateModelBase;
   
   [ModelInfo]
   public class TitanUltimateModel extends TitanUltimateModelBase implements ITitanUltimateModelBase, ObjectLoadListener
   {
      
      [Inject]
      public static var inventorySoundService:InventorySoundService;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var textureMaterialRegistry:TextureMaterialRegistry;
      
      public function TitanUltimateModel()
      {
         super();
      }
      
      public function showUltimateUsed(param1:IGameObject, param2:Vector.<IGameObject>) : void
      {
         var _loc5_:IGameObject = null;
         inventorySoundService.playActivationSound(param1,InventoryItemType.ULTIMATE);
         var _loc3_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().cell.data);
         var _loc4_:Mesh = Mesh(getInitParam().geosphere.objects[0]);
         this.createShieldEffect(param1,_loc3_,_loc4_);
         for each(_loc5_ in param2)
         {
            this.createShieldEffect(_loc5_,_loc3_,_loc4_);
         }
      }
      
      private function createShieldEffect(param1:IGameObject, param2:TextureMaterial, param3:Mesh) : void
      {
         var _loc4_:ShieldEffect = ShieldEffect(battleService.getObjectPool().getObject(ShieldEffect));
         var _loc5_:Mesh = ITankModel(param1.adapt(ITankModel)).getTank().getSkin().getHullMesh();
         _loc4_.init(param2,param3,_loc5_,3);
         battleService.addGraphicEffect(_loc4_);
      }
      
      public function objectLoaded() : void
      {
         inventorySoundService.setUltimateSound(getInitParam().effectStartSound.sound);
      }
   }
}


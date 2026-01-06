package alternativa.tanks.models.tank.ultimate.mammoth
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
   import projects.tanks.client.battlefield.models.ultimate.effects.mammoth.IMammothUltimateModelBase;
   import projects.tanks.client.battlefield.models.ultimate.effects.mammoth.MammothUltimateModelBase;
   
   [ModelInfo]
   public class MammothUltimateModel extends MammothUltimateModelBase implements IMammothUltimateModelBase, ObjectLoadListener
   {
      
      [Inject]
      public static var inventorySoundService:InventorySoundService;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var textureMaterialRegistry:TextureMaterialRegistry;
      
      public function MammothUltimateModel()
      {
         super();
      }
      
      public function showUltimateUsed(param1:IGameObject, param2:Vector.<IGameObject>) : void
      {
         var _loc6_:IGameObject = null;
         inventorySoundService.playActivationSound(param1,InventoryItemType.ULTIMATE);
         var _loc3_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().heart.data);
         var _loc4_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().shine.data);
         this.createFieldEffect(param1,_loc4_,_loc3_);
         var _loc5_:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().sparkles.data);
         for each(_loc6_ in param2)
         {
            this.createSparkle(_loc6_,_loc5_);
         }
      }
      
      private function createFieldEffect(param1:IGameObject, param2:TextureMaterial, param3:TextureMaterial) : void
      {
         var _loc4_:Mesh = ITankModel(param1.adapt(ITankModel)).getTank().getSkin().getHullMesh();
         var _loc5_:FieldEffect = FieldEffect(battleService.getObjectPool().getObject(FieldEffect));
         _loc5_.init(param2,param3,_loc4_,2.5);
         battleService.addGraphicEffect(_loc5_);
      }
      
      private function createSparkle(param1:IGameObject, param2:TextureMaterial) : void
      {
         var _loc3_:Mesh = ITankModel(param1.adapt(ITankModel)).getTank().getSkin().getHullMesh();
         var _loc4_:ExplosionEffect = ExplosionEffect(battleService.getObjectPool().getObject(ExplosionEffect));
         _loc4_.init(param2,_loc3_.x,_loc3_.y,_loc3_.z + 150);
         battleService.addGraphicEffect(_loc4_);
      }
      
      public function objectLoaded() : void
      {
         inventorySoundService.setUltimateSound(getInitParam().effectStartSound.sound);
      }
   }
}


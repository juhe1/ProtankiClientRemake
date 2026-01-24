package alternativa.tanks.battle.objects.tank.tankskin.materialfactory
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.skintexturesregistry.TankSkinTextureRegistry;
   import alternativa.tanks.battle.objects.tank.tankskin.SkinMaterials;
   import alternativa.tanks.battle.objects.tank.tankskin.TankHullSkinCacheItem;
   import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
   import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkinCacheItem;
   import alternativa.tanks.materials.TrackMaterial;
   import alternativa.types.Long;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.display.BitmapData;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.clients.flash.commons.models.coloring.IColoring;
   import alternativa.tanks.battle.objects.tank.tankskin.dynamic.DynamicSkinMaterial;
   
   public class DefaultTankSkinMaterialsFactory implements TankSkinMaterialsFactory
   {
      
      [Inject] // added
      public static var textureMaterialRegistry:TextureMaterialRegistry;
      
      [Inject] // added
      public static var skinTextureRegistry:TankSkinTextureRegistry;
      
      [Inject] // added
      public static var battleService:BattleService;
      
      public function DefaultTankSkinMaterialsFactory()
      {
         super();
      }
      
      public function createSkinMaterials(param1:TankSkin, param2:IColoring) : SkinMaterials
      {
         var _loc13_:MultiframeImageResource = null;
         var _loc14_:TextureMaterial = null;
         var _loc15_:TextureMaterial = null;
         var _loc16_:ImageResource = null;
         var _loc3_:TankHullSkinCacheItem = param1.getHullDescriptor();
         var _loc4_:TurretSkinCacheItem = param1.getTurretDescriptor();
         var _loc5_:Long = _loc3_.partId;
         var _loc6_:BitmapData = _loc3_.lightmap;
         var _loc7_:BitmapData = _loc3_.details;
         var _loc8_:Long = _loc4_.partId;
         var _loc9_:BitmapData = _loc4_.lightmap;
         var _loc10_:BitmapData = _loc4_.details;
         if(param2.isAnimated())
         {
            _loc13_ = param2.getAnimatedColoring();
            _loc14_ = textureMaterialRegistry.getAnimatedPaint(_loc13_,_loc6_,_loc7_,_loc5_);
            _loc15_ = textureMaterialRegistry.getAnimatedPaint(_loc13_,_loc9_,_loc10_,_loc8_);
         }
         else
         {
            _loc16_ = param2.getColoring();
            _loc14_ = textureMaterialRegistry.getPaint(_loc16_,_loc6_,_loc7_,_loc5_);
            _loc15_ = textureMaterialRegistry.getPaint(_loc16_,_loc9_,_loc10_,_loc8_);
         }
         var _loc11_:TrackMaterial = new TrackMaterial(_loc7_);
         var _loc12_:TrackMaterial = new TrackMaterial(_loc7_);
         var dynamicSkin:DynamicSkinMaterial = new DynamicSkinMaterial(_loc10_);
         textureMaterialRegistry.addMaterial(_loc11_);
         textureMaterialRegistry.addMaterial(_loc12_);
         textureMaterialRegistry.addMaterial(dynamicSkin);
         return new SkinMaterials(_loc14_,_loc15_,_loc11_,_loc12_,dynamicSkin);
      }
      
      public function createDeadSkinMaterials(param1:TankSkin, param2:ImageResource) : SkinMaterials
      {
         var _loc3_:TankHullSkinCacheItem = param1.getHullDescriptor();
         var _loc4_:TurretSkinCacheItem = param1.getTurretDescriptor();
         var _loc5_:Long = _loc3_.partId;
         var _loc6_:BitmapData = _loc3_.lightmap;
         var _loc7_:BitmapData = _loc3_.details;
         var _loc8_:Long = _loc4_.partId;
         var _loc9_:BitmapData = _loc4_.lightmap;
         var _loc10_:BitmapData = _loc4_.details;
         var _loc11_:TextureMaterial = textureMaterialRegistry.getPaint(param2,_loc6_,_loc7_,_loc5_);
         var _loc12_:TextureMaterial = textureMaterialRegistry.getPaint(param2,_loc9_,_loc10_,_loc8_);
         return new SkinMaterials(_loc11_,_loc12_, null, null, _loc12_);
      }
   }
}


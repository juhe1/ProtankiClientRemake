package alternativa.tanks.models.battle.commonflag
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.models.battle.assault.PointBaseIndicatorPlane;
   import alternativa.tanks.models.battle.gui.markers.PointIndicatorStateProvider;
   import alternativa.tanks.models.battle.gui.markers.PointMarker;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.display.BitmapData;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class MarkersUtils
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var materialRegistry:TextureMaterialRegistry;
      
      public function MarkersUtils()
      {
         super();
      }
      
      public static function createMarkers(param1:BattleTeam, param2:BitmapData, param3:BitmapData, param4:PointIndicatorStateProvider, param5:Boolean = false) : void
      {
         initMarker2D(param2,param4,param5);
         initMarker3D(param1,param3,param4);
      }
      
      public static function initMarker2D(param1:BitmapData, param2:PointIndicatorStateProvider, param3:Boolean = false) : PointMarker
      {
         var _loc4_:PointMarker = new PointMarker(battleService.getBattleScene3D().getCamera(),param1,param2,param3);
         battleService.getBattleScene3D().addRenderer(_loc4_,0);
         return _loc4_;
      }
      
      public static function initMarker3D(param1:BattleTeam, param2:BitmapData, param3:PointIndicatorStateProvider) : PointBaseIndicatorPlane
      {
         var _loc4_:TextureMaterial = getCircleMaterial(param2);
         var _loc5_:PointBaseIndicatorPlane = new PointBaseIndicatorPlane(param1,_loc4_,battleService,param3);
         battleService.getBattleScene3D().addRenderer(_loc5_,0);
         battleService.getBattleScene3D().addObject(_loc5_);
         return _loc5_;
      }
      
      private static function getCircleMaterial(param1:BitmapData) : TextureMaterial
      {
         var _loc2_:TextureMaterial = materialRegistry.getMaterial(param1,false);
         _loc2_.resolution = 1000 / param1.width;
         return _loc2_;
      }
   }
}


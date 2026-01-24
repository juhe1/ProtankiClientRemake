package alternativa.tanks.models.tank
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.services.battlereadiness.BattleReadinessService;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   public class SpawnCameraConfigurator
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var battleReadinessService:BattleReadinessService;
      
      private var firstSpawn:Boolean = true;
      
      public function SpawnCameraConfigurator(param1:Boolean)
      {
         super();
         this.firstSpawn = param1;
      }
      
      public function setupCamera(param1:Vector3d, param2:Vector3d) : void
      {
         var _loc3_:Vector3 = new Vector3(param1.x,param1.y,param1.z);
         var _loc4_:Vector3 = new Vector3(-Math.sin(param2.z),Math.cos(param2.z),0);
         if(this.firstSpawn)
         {
            this.firstSpawn = false;
            battleService.activateFollowCamera();
            battleService.lockFollowCamera();
            battleService.setFollowCameraTargetParams(_loc3_,_loc4_);
            battleReadinessService.unlockUser();
         }
         else
         {
            battleService.activateFlyCamera(_loc3_,_loc4_);
         }
      }
   }
}


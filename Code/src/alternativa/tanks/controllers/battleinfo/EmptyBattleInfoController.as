package alternativa.tanks.controllers.battleinfo
{
   import alternativa.types.Long;
   import flash.events.EventDispatcher;
   import platform.client.fp10.core.type.IGameObject;
   
   public class EmptyBattleInfoController extends EventDispatcher implements IBattleInfoController
   {
      
      public function EmptyBattleInfoController()
      {
         super();
      }
      
      public function addFormToStage() : void
      {
      }
      
      public function removeFormFromStage() : void
      {
      }
      
      public function hideForm() : void
      {
      }
      
      public function removeUser(param1:String) : void
      {
      }
      
      public function updateUserScore(param1:String, param2:int) : void
      {
      }
      
      public function updateUserSuspiciousState(param1:String, param2:Boolean) : void
      {
      }
      
      public function roundStart(param1:int) : void
      {
      }
      
      public function roundFinish() : void
      {
      }
      
      public function battleStop() : void
      {
      }
      
      public function getSelectedBattle() : IGameObject
      {
         return null;
      }
      
      public function updateBattleName() : void
      {
      }
   }
}


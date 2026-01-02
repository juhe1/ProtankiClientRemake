package alternativa.tanks.service.battle
{
   import alternativa.osgi.service.logging.LogService;
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.type.IGameObject;
   
   public class BattleUserInfoService implements IBattleUserInfoService
   {
      
      [Inject] // added
      public static var logService:LogService;
      
      private var battleUsers:Dictionary = new Dictionary();
      
      public function BattleUserInfoService()
      {
         super();
      }
      
      public function userInBattle(param1:String) : Boolean
      {
         return param1 in this.battleUsers;
      }
      
      public function getBattle(param1:String) : IGameObject
      {
         return this.battleUsers[param1];
      }
      
      public function connect(param1:String, param2:IGameObject) : void
      {
         this.battleUsers[param1] = param2;
      }
      
      public function disconnect(param1:String) : void
      {
         delete this.battleUsers[param1];
      }
      
      public function deleteBattleItem(param1:IGameObject) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:Long = null;
         for(_loc2_ in this.battleUsers)
         {
            _loc3_ = this.battleUsers[_loc2_].id;
            if(_loc3_ == param1.id)
            {
               this.disconnect(_loc2_);
            }
         }
      }
   }
}


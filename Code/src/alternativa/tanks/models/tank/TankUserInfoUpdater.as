package alternativa.tanks.models.tank
{
   import alternativa.tanks.display.usertitle.UserTitle;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoListener;
   import alternativa.tanks.services.tankregistry.TankUsersRegistry;
   import alternativa.types.Long;
   import platform.client.fp10.core.type.IGameObject;
   
   public class TankUserInfoUpdater implements BattleUserInfoListener
   {
      
      [Inject] // added
      public static var usersRegistry:TankUsersRegistry;
      
      public function TankUserInfoUpdater()
      {
         super();
      }
      
      public function userInfoChanged(param1:String, param2:String, param3:int, param4:Boolean) : void
      {
         var _loc6_:UserInfo = null;
         var _loc7_:UserTitle = null;
         var _loc5_:ITankModel = this.getTankModel(param1);
         if(_loc5_ != null)
         {
            _loc6_ = _loc5_.getUserInfo();
            _loc6_.name = param2;
            _loc6_.rank = param3;
            _loc7_ = _loc5_.getTitle();
            if(_loc7_ != null)
            {
               _loc7_.setLabelText(param2);
               _loc7_.setRank(param3);
               _loc7_.setSuspicious(param4);
            }
         }
      }
      
      public function userSuspiciousnessChanged(param1:String, param2:Boolean) : void
      {
         var _loc4_:ITankModel = null;
         var _loc5_:UserTitle = null;
         var _loc3_:IGameObject = usersRegistry.getUser(param1);
         if(_loc3_ != null)
         {
            _loc4_ = ITankModel(_loc3_.adapt(ITankModel));
            _loc5_ = _loc4_.getTitle();
            if(_loc5_ != null)
            {
               _loc5_.setSuspicious(param2);
            }
         }
      }
      
      public function userRankChanged(param1:String, param2:int) : void
      {
         var _loc4_:UserInfo = null;
         var _loc5_:UserTitle = null;
         var _loc3_:ITankModel = this.getTankModel(param1);
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.getUserInfo();
            _loc4_.rank = param2;
            _loc5_ = _loc3_.getTitle();
            if(_loc5_ != null)
            {
               _loc5_.setRank(param2);
            }
         }
      }
      
      private function getTankModel(param1:String) : ITankModel
      {
         var _loc2_:IGameObject = usersRegistry.getUser(param1);
         if(_loc2_ != null)
         {
            return ITankModel(_loc2_.adapt(ITankModel));
         }
         return null;
      }
   }
}


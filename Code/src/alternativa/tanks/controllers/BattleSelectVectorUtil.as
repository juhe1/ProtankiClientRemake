package alternativa.tanks.controllers
{
   import alternativa.tanks.controllers.battlelist.BattleListItemParams;
   import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
   
   public class BattleSelectVectorUtil
   {
      
      public function BattleSelectVectorUtil()
      {
         super();
      }
      
      public static function getUsersById(param1:Vector.<BattleInfoUser>, param2:String) : BattleInfoUser
      {
         var _loc3_:BattleInfoUser = null;
         var _loc4_:int = int(param1.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(param1[_loc5_].user == param2)
            {
               _loc3_ = param1[_loc5_];
               break;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function deleteElementInUsersVector(param1:Vector.<BattleInfoUser>, param2:String) : void
      {
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1[_loc4_].user == param2)
            {
               while(_loc4_ + 1 < _loc3_)
               {
                  param1[_loc4_] = param1[_loc4_ + 1];
                  _loc4_++;
               }
               param1.pop();
               break;
            }
            _loc4_++;
         }
      }
      
      public static function deleteElementInLongsVector(param1:Vector.<String>, param2:String) : void
      {
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1[_loc4_] == param2)
            {
               param1[_loc4_] = param1[_loc3_ - 1];
               param1.pop();
               break;
            }
            _loc4_++;
         }
      }
      
      public static function deleteElementInVector(param1:Vector.<BattleListItemParams>, param2:String) : void
      {
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1[_loc4_].id == param2)
            {
               param1[_loc4_] = param1[_loc3_ - 1];
               param1.pop();
               break;
            }
            _loc4_++;
         }
      }
      
      public static function deleteElementInArray(param1:Array, param2:String) : void
      {
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1[_loc4_].id == param2)
            {
               param1[_loc4_] = param1[_loc3_ - 1];
               param1.pop();
               break;
            }
            _loc4_++;
         }
      }
      
      public static function findElementInVector(param1:Vector.<BattleListItemParams>, param2:String) : BattleListItemParams
      {
         var _loc3_:BattleListItemParams = null;
         var _loc4_:int = int(param1.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(param1[_loc5_].id == param2)
            {
               _loc3_ = param1[_loc5_];
               break;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function containsElementInVector(param1:Vector.<String>, param2:String) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:int = int(param1.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(param1[_loc5_] == param2)
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
   }
}


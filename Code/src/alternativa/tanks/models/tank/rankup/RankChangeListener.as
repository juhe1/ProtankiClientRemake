package alternativa.tanks.models.tank.rankup
{
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoListener;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
   import alternativa.types.Long;
   import platform.client.fp10.core.type.AutoClosable;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   import utils.TankNameGameObjectMapper;
   
   public class RankChangeListener implements BattleUserInfoListener, AutoClosable
   {
      
      [Inject]
      public static var battleUserInfoService:BattleUserInfoService;
      
      private var space:ISpace;
      
      public function RankChangeListener(param1:ISpace)
      {
         super();
         this.space = param1;
         battleUserInfoService.addBattleUserInfoListener(this);
      }
      
      public function userRankChanged(param1:String, param2:int) : void
      {
         var _loc3_:IGameObject = TankNameGameObjectMapper.getGameObjectByTankName(param1);
         var _loc4_:ITankRankUpEffectModel = ITankRankUpEffectModel(_loc3_.adapt(ITankRankUpEffectModel));
         _loc4_.showRankUpEffect(param2);
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         this.space = null;
         battleUserInfoService.removeBattleUserInfoListener(this);
      }
      
      public function userInfoChanged(param1:String, param2:String, param3:int, param4:Boolean) : void
      {
      }
      
      public function userSuspiciousnessChanged(param1:String, param2:Boolean) : void
      {
      }
   }
}


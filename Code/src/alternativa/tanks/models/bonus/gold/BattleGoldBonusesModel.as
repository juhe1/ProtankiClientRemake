package alternativa.tanks.models.bonus.gold
{
   import alternativa.engine3d.core.MipMapping;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.math.Vector3;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
   import alternativa.tanks.models.battle.ctf.MessageColor;
   import alternativa.tanks.models.battle.gui.BattlefieldGUI;
   import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
   import alternativa.tanks.sfx.BonusCrystalsEffectUtils;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.tanks.sfx.Sound3DEffect;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   import projects.tanks.client.battlefield.models.bonus.bonus.battlebonuses.crystal.BattleGoldBonusesModelBase;
   import projects.tanks.client.battlefield.models.bonus.bonus.battlebonuses.crystal.IBattleGoldBonusesModelBase;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import utils.TankNameGameObjectMapper;
   
   [ModelInfo]
   public class BattleGoldBonusesModel extends BattleGoldBonusesModelBase implements IBattleGoldBonusesModelBase, ObjectLoadListener
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var userInfoService:BattleUserInfoService;
      
      [Inject] // added
      public static var userPropertiesService:IUserPropertiesService;
      
      public static const DELAY:int = 800;
      
      public function BattleGoldBonusesModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function goldTaken(param1:IGameObject) : void
      {
         if(param1 != null)
         {
            this.showBonusPickupNotification(param1,TanksLocale.TEXT_BATTLE_GOLD_TAKEN);
         }
      }
      
      private function showBonusPickupNotification(param1:IGameObject, param2:String) : void
      {
         var _loc8_:ISpace = null;
         var _loc9_:IGameObject = null;
         var _loc10_:BattlefieldGUI = null;
         var _loc3_:Vector3d = BonusCrystalsEffectUtils.getTargetPosition(param1);
         //var _loc4_:TextureMaterial = TextureMaterial(getData(TextureMaterial));
         //BonusCrystalsEffectUtils.drawEffectForCatcherPosition(_loc3_,DELAY,_loc4_);
         //var _loc5_:Sound3D = Sound3D.create(getInitParam().sound.sound,0.5);
         var _loc6_:Vector3 = new Vector3(_loc3_.x,_loc3_.y,_loc3_.z + 300);
         //battleService.addSound3DEffect(Sound3DEffect.create(_loc6_,_loc5_,DELAY));
         var _loc7_:String = userInfoService.getUserName(TankNameGameObjectMapper.getTankNameByGameObject(param1));
         if(_loc7_ != null)
         {
            _loc8_ = object.space;
            _loc9_ = _loc8_.rootObject;
            _loc10_ = BattlefieldGUI(_loc9_.adapt(BattlefieldGUI));
            _loc10_.showBattleMessage(MessageColor.ORANGE,_loc7_ + localeService.getText(param2));
            _loc10_.showUserBattleLogMessage(TankNameGameObjectMapper.getTankNameByGameObject(param1),UserAction.PLAYER_GOLD_BOX);
         }
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:TextureMaterial = new TextureMaterial(getInitParam().sprite.data,false,true,MipMapping.PER_PIXEL,1);
         putData(TextureMaterial,_loc1_);
      }
   }
}


package alternativa.tanks.models.battle.jgr
{
   import alternativa.math.Vector3;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.TankLoadedEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.battle.ctf.MessageColor;
   import alternativa.tanks.models.battle.gui.BattlefieldGUI;
   import alternativa.tanks.models.battle.gui.markers.PointIndicatorStateProvider;
   import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
   import alternativa.tanks.models.statistics.IClientUserInfo;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.services.tankregistry.TankUsersRegistry;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.types.Long;
   import flash.display.Bitmap;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.TextureResource;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   import projects.tanks.client.battlefield.models.battle.jgr.IJuggernautModelBase;
   import projects.tanks.client.battlefield.models.battle.jgr.JuggernautCC;
   import projects.tanks.client.battlefield.models.battle.jgr.JuggernautModelBase;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   
   [ModelInfo]
   public class JuggernautModel extends JuggernautModelBase implements IJuggernautModelBase, Juggernaut, ObjectLoadListener, ObjectUnloadListener, ObjectLoadPostListener, BattleEventListener, PointIndicatorStateProvider
   {
      
      [Inject]
      public static var usersRegistry:TankUsersRegistry;
      
      [Inject]
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject]
      public static var localeService:ILocaleService;
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      private static const MARKER_Z_OFFSET:Number = 350;
      
      private var guiModel:BattlefieldGUI = null;
      
      private var currentBossId:Long = null;
      
      private var battleSpace:ISpace = null;
      
      private var bossSpawnedSound:Sound3D;
      
      private var bossDiedSound:Sound3D;
      
      private var localTank:Tank = null;
      
      private var battleEventSupport:BattleEventSupport;
      
      public function JuggernautModel()
      {
         super();
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
      }
      
      private static function getUserUid(param1:Long) : String
      {
         var _loc2_:ShortUserInfo = null;
         if(param1 != null)
         {
            _loc2_ = IClientUserInfo(object.adapt(IClientUserInfo)).getShortUserInfo(param1);
            if(_loc2_ != null)
            {
               return _loc2_.uid;
            }
         }
         return null;
      }
      
      public function objectLoaded() : void
      {
         this.battleEventSupport.activateHandlers();
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function bossChanged(param1:Long) : void
      {
         var _loc4_:String = null;
         this.currentBossId = param1;
         var _loc2_:Boolean = !battleInfoService.isSpectatorMode() && this.localTank != null && this.localTank.user != null && this.currentBossId != null && this.localTank.user.id == this.currentBossId;
         var _loc3_:String = getUserUid(this.currentBossId);
         if(_loc3_ != null)
         {
            _loc4_ = localeService.getText(TanksLocale.TEXT_JGR_NEW_BOSS,_loc3_);
            this.guiModel.showBattleMessage(_loc2_ ? MessageColor.POSITIVE : MessageColor.YELLOW,_loc4_);
         }
         this.bossSpawnedSound.play(0,0);
      }
      
      public function bossKilled() : void
      {
         var _loc3_:String = null;
         var _loc1_:uint = !battleInfoService.isSpectatorMode() && this.localTank.user.id == this.currentBossId ? MessageColor.NEGATIVE : MessageColor.POSITIVE;
         var _loc2_:String = getUserUid(this.currentBossId);
         if(_loc2_ != null)
         {
            _loc3_ = localeService.getText(TanksLocale.TEXT_JGR_BOSS_KILLED,_loc2_);
            this.guiModel.showBattleMessage(_loc1_,_loc3_);
         }
         this.bossDiedSound.play(0,0);
      }
      
      public function bossId() : Long
      {
         return this.currentBossId;
      }
      
      private function onTankLoaded(param1:TankLoadedEvent) : void
      {
         if(param1.isLocal)
         {
            this.localTank = param1.tank;
         }
      }
      
      public function objectUnloaded() : void
      {
         this.battleEventSupport.deactivateHandlers();
         this.localTank = null;
         this.battleSpace = null;
      }
      
      public function objectLoadedPost() : void
      {
         this.guiModel = BattlefieldGUI(object.adapt(BattlefieldGUI));
         var _loc1_:JuggernautCC = getInitParam();
         this.bossSpawnedSound = Sound3D.create(_loc1_.bossSpawnedSound.sound);
         this.bossDiedSound = Sound3D.create(_loc1_.bossKilledSound.sound);
         var _loc2_:TextureResource = _loc1_.bossHudMarker;
         var _loc3_:JuggernautHudIndicator = new JuggernautHudIndicator(new Bitmap(_loc2_.data),this);
         battleService.getBattleScene3D().addRenderer(_loc3_);
         this.currentBossId = _loc1_.currentBoss == null ? null : _loc1_.currentBoss.id;
         this.battleSpace = object.space;
      }
      
      public function getIndicatorPosition() : Vector3
      {
         var _loc1_:IGameObject = null;
         if(this.currentBossId != null)
         {
            _loc1_ = this.battleSpace.getObject(this.currentBossId);
            if(_loc1_ != null)
            {
               return ITankModel(_loc1_.adapt(ITankModel)).getTank().getBody().state.position;
            }
         }
         return Vector3.ZERO;
      }
      
      public function isIndicatorActive(param1:Vector3 = null) : Boolean
      {
         return this.currentBossId != null && this.localTank != null && this.localTank.user != null && this.currentBossId != this.localTank.user.id;
      }
      
      public function zOffset() : Number
      {
         return MARKER_Z_OFFSET;
      }
   }
}


package alternativa.tanks.services.bonusregion
{
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Decal;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.BattleFinishEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.bonus.region.BonusRegion;
   import alternativa.tanks.models.bonus.region.GoldBonusRegion;
   import alternativa.tanks.service.settings.ISettingsService;
   import alternativa.tanks.service.settings.SettingsServiceEvent;
   import alternativa.utils.TextureMaterialRegistry;
   import alternativa.utils.clearDictionary;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.resource.types.StubBitmapData;
   import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;
   import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionResource;
   import projects.tanks.client.battlefield.models.bonus.bonus.BonusesType;
   
   public class BonusRegionService implements IBonusRegionService, BattleEventListener
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var materialRegistry:TextureMaterialRegistry;
      
      [Inject] // added
      public static var settings:ISettingsService;
      
      private static var stubBitmapData:BitmapData;
      
      private static const REGION_SIZE:int = 500;
      
      private static const REGION_DECAL_ACSENSION:Number = 5;
      
      private var _battleEventSupport:BattleEventSupport;
      
      private var _textures:Dictionary;
      
      private var _bonusRegions:Dictionary;
      
      private var _forceShow:Boolean;
      
      private var _forceHide:Boolean;
      
      private var _tank:Tank;
      
      public function BonusRegionService(param1:BattleEventDispatcher)
      {
         super();
         this._battleEventSupport = new BattleEventSupport(param1,this);
         this._battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinished);
      }
      
      private static function createRegion(param1:Vector3, param2:Vector3, param3:TextureMaterial) : Mesh
      {
         var _loc4_:Decal = new Decal();
         var _loc5_:Number = REGION_SIZE / 2;
         var _loc6_:Number = 0.5;
         var _loc7_:Vertex = _loc4_.addVertex(-_loc5_,_loc5_,_loc6_,0,0);
         var _loc8_:Vertex = _loc4_.addVertex(-_loc5_,-_loc5_,_loc6_,0,1);
         var _loc9_:Vertex = _loc4_.addVertex(_loc5_,-_loc5_,_loc6_,1,1);
         var _loc10_:Vertex = _loc4_.addVertex(_loc5_,_loc5_,_loc6_,1,0);
         _loc4_.addQuadFace(_loc7_,_loc8_,_loc9_,_loc10_,param3);
         _loc4_.calculateFacesNormals();
         _loc4_.calculateVerticesNormals();
         _loc4_.x = param1.x;
         _loc4_.y = param1.y;
         _loc4_.z = param1.z + REGION_DECAL_ACSENSION;
         _loc4_.rotationX = param2.x;
         _loc4_.rotationY = param2.y;
         _loc4_.rotationZ = param2.z;
         return _loc4_;
      }
      
      private static function getStubBitmapData() : BitmapData
      {
         if(stubBitmapData == null)
         {
            stubBitmapData = new StubBitmapData(65280);
         }
         return stubBitmapData;
      }
      
      private function onBattleFinished(param1:BattleFinishEvent) : void
      {
         this.hideAndRemoveGoldRegions();
      }
      
      private function hideAndRemoveGoldRegions() : void
      {
         var _loc1_:BonusRegion = null;
         for each(_loc1_ in this._bonusRegions)
         {
            if(_loc1_ is GoldBonusRegion)
            {
               _loc1_.hideAndRemoveFromGame();
               delete this._bonusRegions[_loc1_.getPosition().toString()];
            }
         }
      }
      
      public function showAll() : void
      {
         var _loc1_:BonusRegion = null;
         if(this._forceShow)
         {
            for each(_loc1_ in this._bonusRegions)
            {
               _loc1_.showForce();
            }
         }
      }
      
      private function hasTank() : Boolean
      {
         return this._tank != null;
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this._battleEventSupport.handleBattleEvent(param1);
      }
      
      public function prepare(param1:Vector.<BonusRegionResource>) : void
      {
         this._forceShow = settings.showDropZones;
         this._forceHide = !this._forceShow;
         settings.addEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.onSettingsAccept);
         this._battleEventSupport.activateHandlers();
         this._bonusRegions = new Dictionary();
         this.initMaterials(param1);
      }
      
      private function onSettingsAccept(param1:SettingsServiceEvent) : void
      {
         if(this._forceShow != settings.showDropZones)
         {
            this.toggleRegionsVisible();
         }
      }
      
      private function initMaterials(param1:Vector.<BonusRegionResource>) : void
      {
         var _loc4_:BonusRegionResource = null;
         this._textures = new Dictionary();
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1[_loc3_];
            this._textures[_loc4_.regionType] = _loc4_.dropZoneResource.data;
            _loc3_++;
         }
      }
      
      public function destroy() : void
      {
         settings.removeEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.onSettingsAccept);
         this._battleEventSupport.deactivateHandlers();
         this.destroyBonusRegions();
         this.destroyTextures();
         this._tank = null;
      }
      
      private function destroyBonusRegions() : void
      {
         var _loc1_:BonusRegion = null;
         for each(_loc1_ in this._bonusRegions)
         {
            _loc1_.removeFromGame();
         }
         clearDictionary(this._bonusRegions);
         this._bonusRegions = null;
      }
      
      private function destroyTextures() : void
      {
         clearDictionary(this._textures);
         this._textures = null;
      }
      
      public function addOneRegion(param1:BonusRegionData) : void
      {
         var _loc2_:Vector3 = null;
         var _loc3_:Mesh = null;
         var _loc4_:BonusRegion = null;
         if(!this.hasRegion(param1))
         {
            _loc2_ = BattleUtils.getVector3(param1.position);
            _loc3_ = createRegion(_loc2_,BattleUtils.getVector3(param1.rotation),this.getMaterial(param1.regionType));
            if(param1.regionType == BonusesType.GOLD)
            {
               _loc4_ = new GoldBonusRegion(_loc3_,_loc2_);
            }
            else
            {
               _loc4_ = new BonusRegion(_loc3_,_loc2_,this._forceShow);
            }
            _loc4_.addToGame();
            this._bonusRegions[_loc2_.toString()] = _loc4_;
         }
      }
      
      public function addFewRegions(param1:Vector.<BonusRegionData>) : void
      {
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.addOneRegion(param1[_loc3_]);
            _loc3_++;
         }
      }
      
      private function getMaterial(param1:BonusesType) : TextureMaterial
      {
         var _loc2_:BitmapData = this._textures[param1];
         if(_loc2_ == null)
         {
            _loc2_ = getStubBitmapData();
         }
         var _loc3_:TextureMaterial = materialRegistry.getMaterial(_loc2_);
         _loc3_.resolution = 2;
         return _loc3_;
      }
      
      public function setTank(param1:Tank) : void
      {
         this._tank = param1;
      }
      
      public function changeTank(param1:Tank) : void
      {
         if(!this.hasTank() || this.hasTank() && this._tank.getUser() != param1.getUser())
         {
            this._tank = param1;
         }
      }
      
      public function resetTank() : void
      {
         this._tank = null;
         if(this._forceShow)
         {
            this.showAll();
         }
      }
      
      public function enableForceShow() : void
      {
         var _loc1_:BonusRegion = null;
         this._forceShow = true;
         this._forceHide = false;
         settings.showDropZones = true;
         for each(_loc1_ in this._bonusRegions)
         {
            if(!(_loc1_ is GoldBonusRegion))
            {
               _loc1_.showForce();
            }
         }
      }
      
      public function enableForceHide() : void
      {
         var _loc1_:BonusRegion = null;
         this._forceHide = true;
         this._forceShow = false;
         settings.showDropZones = false;
         for each(_loc1_ in this._bonusRegions)
         {
            if(!(_loc1_ is GoldBonusRegion))
            {
               _loc1_.hideForce();
            }
         }
      }
      
      public function addAndShowRegion(param1:BonusRegionData) : void
      {
         var _loc2_:Vector3 = null;
         var _loc3_:BonusRegion = null;
         if(!this.hasRegion(param1))
         {
            this.addOneRegion(param1);
            _loc2_ = BattleUtils.getVector3(param1.position);
            _loc3_ = this._bonusRegions[_loc2_.toString()];
            _loc3_.show();
         }
      }
      
      public function hideAndRemoveRegion(param1:BonusRegionData) : void
      {
         var _loc2_:Vector3 = null;
         var _loc3_:BonusRegion = null;
         if(this.hasRegion(param1))
         {
            _loc2_ = BattleUtils.getVector3(param1.position);
            _loc3_ = this._bonusRegions[_loc2_.toString()];
            _loc3_.hideAndRemoveFromGame();
            delete this._bonusRegions[_loc2_.toString()];
         }
      }
      
      public function hasRegion(param1:BonusRegionData) : Boolean
      {
         var _loc2_:Vector3 = BattleUtils.getVector3(param1.position);
         return this._bonusRegions[_loc2_.toString()] != undefined;
      }
      
      public function toggleRegionsVisible() : void
      {
         if(this._forceShow)
         {
            this.enableForceHide();
         }
         else if(this._forceHide)
         {
            this.enableForceShow();
         }
      }
   }
}


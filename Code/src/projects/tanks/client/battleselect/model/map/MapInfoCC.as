package projects.tanks.client.battleselect.model.map
{
   import alternativa.types.Long;
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.battleservice.Range;
   import projects.tanks.client.battleservice.model.map.params.MapTheme;
   
   public class MapInfoCC
   {
      
      private var _defaultTheme:MapTheme;
      
      private var _enabled:Boolean;
      
      private var _mapId:String;
      
      private var _mapName:String;
      
      private var _matchmakingMark:Boolean;
      
      private var _maxPeople:int;
      
      private var _preview:ImageResource;
      
      private var _rankLimit:Range;
      
      private var _supportedModes:Vector.<BattleMode>;
      
      private var _theme:MapTheme;

      private var _additionalCrystalsPercent:int;
      
      public function MapInfoCC(additionalCrystalsPercent:int = 0, param1:MapTheme = null, param2:Boolean = false, param3:String = null, param4:String = null, param5:Boolean = false, param6:int = 0, param7:ImageResource = null, param8:Range = null, param9:Vector.<BattleMode> = null, param10:MapTheme = null)
      {
         super();
         this._additionalCrystalsPercent = additionalCrystalsPercent;
         this._defaultTheme = param1;
         this._enabled = param2;
         this._mapId = param3;
         this._mapName = param4;
         this._matchmakingMark = param5;
         this._maxPeople = param6;
         this._preview = param7;
         this._rankLimit = param8;
         this._supportedModes = param9;
         this._theme = param10;
      }

      public function get additionalCrystalsPercent() : int
      {
         return this._additionalCrystalsPercent;
      }
      
      public function set additionalCrystalsPercent(param1:int) : void
      {
         this._additionalCrystalsPercent = param1;
      }
      
      public function get defaultTheme() : MapTheme
      {
         return this._defaultTheme;
      }
      
      public function set defaultTheme(param1:MapTheme) : void
      {
         this._defaultTheme = param1;
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
      }
      
      public function get mapId() : String
      {
         return this._mapId;
      }
      
      public function set mapId(param1:String) : void
      {
         this._mapId = param1;
      }
      
      public function get mapName() : String
      {
         return this._mapName;
      }
      
      public function set mapName(param1:String) : void
      {
         this._mapName = param1;
      }
      
      public function get matchmakingMark() : Boolean
      {
         return this._matchmakingMark;
      }
      
      public function set matchmakingMark(param1:Boolean) : void
      {
         this._matchmakingMark = param1;
      }
      
      public function get maxPeople() : int
      {
         return this._maxPeople;
      }
      
      public function set maxPeople(param1:int) : void
      {
         this._maxPeople = param1;
      }
      
      public function get preview() : ImageResource
      {
         return this._preview;
      }
      
      public function set preview(param1:ImageResource) : void
      {
         this._preview = param1;
      }
      
      public function get rankLimit() : Range
      {
         return this._rankLimit;
      }
      
      public function set rankLimit(param1:Range) : void
      {
         this._rankLimit = param1;
      }
      
      public function get supportedModes() : Vector.<BattleMode>
      {
         return this._supportedModes;
      }
      
      public function set supportedModes(param1:Vector.<BattleMode>) : void
      {
         this._supportedModes = param1;
      }
      
      public function get theme() : MapTheme
      {
         return this._theme;
      }
      
      public function set theme(param1:MapTheme) : void
      {
         this._theme = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "MapInfoCC [";
         _loc1_ += "additionalCrystalsPercent = " + this.additionalCrystalsPercent + " ";
         _loc1_ += "defaultTheme = " + this.defaultTheme + " ";
         _loc1_ += "enabled = " + this.enabled + " ";
         _loc1_ += "mapId = " + this.mapId + " ";
         _loc1_ += "mapName = " + this.mapName + " ";
         _loc1_ += "matchmakingMark = " + this.matchmakingMark + " ";
         _loc1_ += "maxPeople = " + this.maxPeople + " ";
         _loc1_ += "preview = " + this.preview + " ";
         _loc1_ += "rankLimit = " + this.rankLimit + " ";
         _loc1_ += "supportedModes = " + this.supportedModes + " ";
         _loc1_ += "theme = " + this.theme + " ";
         return _loc1_ + "]";
      }
   }
}


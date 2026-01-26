package projects.tanks.client.battlefield.models.ultimate.effects.hornet.radar
{
   import alternativa.types.Long;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class BattleUltimateRadarCC
   {

      private var _discoveredTanksIds:Vector.<Long>;
      
      private var _farMarkerDistance:Number;
      
      private var _nearMarkerDistance:Number;

      [Embed(source="/_assets/indicator-blue.png")]
      private var _blueTankMarkerClass:Class;
      private var _blueTankMarker:BitmapData;
      
      [Embed(source="/_assets/indicator-green.png")]
      private var _neutralTankMarkerClass:Class;
      private var _neutralTankMarker:BitmapData;
      
      [Embed(source="/_assets/indicator-red.png")]
      private var _redTankMarkerClass:Class;
      private var _redTankMarker:BitmapData;
      
      public function BattleUltimateRadarCC(discoveredTanksIdsArg:Vector.<Long> = null, farMarkerDistanceArg:Number = 0, nearMarkerDistanceArg:Number = 0)
      {
         super();
         this._discoveredTanksIds = discoveredTanksIdsArg;
         this._farMarkerDistance = farMarkerDistanceArg;
         this._nearMarkerDistance = nearMarkerDistanceArg;

         this._blueTankMarker = Bitmap(new this._blueTankMarkerClass()).bitmapData;
         this._neutralTankMarker = Bitmap(new this._neutralTankMarkerClass()).bitmapData;
         this._redTankMarker = Bitmap(new this._redTankMarkerClass()).bitmapData;
      }
      
      public function get blueTankMarker() : BitmapData
      {
         return this._blueTankMarker;
      }
      
      public function set blueTankMarker(param1:BitmapData) : void
      {
         this._blueTankMarker = param1;
      }
      
      public function get discoveredTanksIds() : Vector.<Long>
      {
         return this._discoveredTanksIds;
      }
      
      public function set discoveredTanksIds(param1:Vector.<Long>) : void
      {
         this._discoveredTanksIds = param1;
      }
      
      public function get farMarkerDistance() : Number
      {
         return this._farMarkerDistance;
      }
      
      public function set farMarkerDistance(param1:Number) : void
      {
         this._farMarkerDistance = param1;
      }
      
      public function get nearMarkerDistance() : Number
      {
         return this._nearMarkerDistance;
      }
      
      public function set nearMarkerDistance(param1:Number) : void
      {
         this._nearMarkerDistance = param1;
      }
      
      public function get neutralTankMarker() : BitmapData
      {
         return this._neutralTankMarker;
      }
      
      public function set neutralTankMarker(param1:BitmapData) : void
      {
         this._neutralTankMarker = param1;
      }
      
      public function get redTankMarker() : BitmapData
      {
         return this._redTankMarker;
      }
      
      public function set redTankMarker(param1:BitmapData) : void
      {
         this._redTankMarker = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BattleUltimateRadarCC [";
         _loc1_ += "blueTankMarker = " + this.blueTankMarker + " ";
         _loc1_ += "discoveredTanksIds = " + this.discoveredTanksIds + " ";
         _loc1_ += "farMarkerDistance = " + this.farMarkerDistance + " ";
         _loc1_ += "nearMarkerDistance = " + this.nearMarkerDistance + " ";
         _loc1_ += "neutralTankMarker = " + this.neutralTankMarker + " ";
         _loc1_ += "redTankMarker = " + this.redTankMarker + " ";
         return _loc1_ + "]";
      }
   }
}


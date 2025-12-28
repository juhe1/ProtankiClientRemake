package scpacker.networking.protocol.packets.battlelist
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import projects.tanks.client.battleselect.model.map.MapInfoCC;
   import alternativa.types.Long;
   import alternativa.tanks.model.map.claninfo.ClanInfoModel;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.battleservice.Range;
   import alternativa.tanks.model.battleselect.create.BattleCreateModel;
   import scpacker.utils.newname_2263__END;
   import alternativa.tanks.model.map.mapinfo.MapInfoModel;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.createparams.BattleLimits;
   import platform.client.fp10.core.model.impl.*;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.type.newname_3133__END;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.IGameClass;
   import projects.tanks.client.clans.clan.info.ClanInfoCC;
   import projects.tanks.client.battleselect.model.battleselect.create.BattleCreateCC;
   import scpacker.networking.protocol.packets.battlelist.BattleCreateFailedDisabledInPacket;
   import scpacker.networking.protocol.packets.battlelist.BattleCreateFailedServerHaltingInPacket;
   import scpacker.networking.protocol.packets.battlelist.BattleCreateFailedTooManyBattlesInPacket;
   import scpacker.networking.protocol.packets.battlelist.BattleCreateFailedBannedInPacket;
   import scpacker.networking.protocol.packets.battlelist.SetFilteredBattleNameInPacket;
   
   public class BattlelistPacketHandler extends AbstractPacketHandler
   {
      private var battleCreateModel:BattleCreateModel;
      
      private var mapInfoModel:MapInfoModel;
      
      private var clanInfoModel:ClanInfoModel;
      
      private var battleSelectClass:IGameClass;
      
      private var battleSelectObject:IGameObject;
      
      public function BattlelistPacketHandler()
      {
         super();
         this.id = 30;
         this.battleCreateModel = BattleCreateModel(modelRegistry.getModel(Long.getLong(0,300090002)));
         this.mapInfoModel = MapInfoModel(modelRegistry.getModel(Long.getLong(0,300090019)));
         this.clanInfoModel = ClanInfoModel(modelRegistry.getModel(Long.getLong(0,300090014)));
         var _loc1_:Vector.<Long> = new Vector.<Long>();
         _loc1_.push(this.battleCreateModel.id);
         _loc1_.push(Long.getLong(0,300090011));
         var _loc2_:Vector.<Long> = new Vector.<Long>();
         _loc2_.push(this.mapInfoModel.id);
         _loc2_.push(this.clanInfoModel.id);
         this.battleSelectClass = gameTypeRegistry.createClass(Long.getLong(591359,5235923),_loc1_);
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case BattleCreateFailedDisabledInPacket.id:
               this.createFailedBattleCreateDisabled();
               break;
            case BattleCreateFailedServerHaltingInPacket.id:
               this.createFailedServerIsHalting();
               break;
            case BattleCreateFailedTooManyBattlesInPacket.id:
               this.createFailedTooManyBattlesFromYou();
               break;
            case BattleCreateFailedBannedInPacket.id:
               this.createFailedYouAreBanned();
               break;
            case InitMapsInPacket.id:
               this.initMaps(param1 as InitMapsInPacket);
               break;
            case SetFilteredBattleNameInPacket.id:
               this.setFilteredBattleName(param1 as SetFilteredBattleNameInPacket);
         }
      }
      
      private function initMaps(param1:InitMapsInPacket) : void
      {
         var _loc9_:IGameObject = null;
         var _loc5_:MapInfoCC = null;
         var _loc2_:ClanInfoCC = null;
         var _loc8_:newname_3133__END = spaceRegistry.getSpace(Long.getLong(59235923,646943));
         this.battleSelectObject = _loc8_.createObject(Long.getLong(53152835,6296493246),this.battleSelectClass,"BattleSelectObject");
         var _loc3_:Object = JSON.parse(param1.battlesJson);
         for each(var _loc4_ in _loc3_.maps)
         {
            _loc9_ = _loc8_.createObject(Long.getLong(_loc4_.preview * 1000,_loc4_.preview * 1000),this.newname_8610__END,_loc4_.mapId + _loc4_.theme);
            _loc5_ = new MapInfoCC();
            _loc5_.additionalCrystalsPercent = _loc4_.additionalCrystalsPercent;
            _loc5_.enabled = _loc4_.enabled;
            _loc5_.mapId = _loc4_.mapId;
            _loc5_.mapName = _loc4_.mapName;
            _loc5_.maxPeople = _loc4_.maxPeople;
            _loc5_.preview = ImageResource(newname_122__END.getResource(Long.getLong(0,_loc4_.preview)));
            _loc5_.rankLimit = new Range(_loc4_.maxRank,_loc4_.minRank);
            _loc5_.supportedModes = new Vector.<BattleMode>();
            for each(var _loc6_ in _loc4_.supportedModes)
            {
               _loc5_.supportedModes.push(newname_2263__END.newname_8618__END(_loc6_));
            }
            _loc5_.theme = newname_2263__END.newname_8619__END(_loc4_.theme);
            _loc2_ = new ClanInfoCC(_loc4_.clanLink,_loc4_.clanName);
            platform.client.fp10.core.model.impl.Model.objects[platform.client.fp10.core.model.impl.Model.objects.length] = platform.client.fp10.core.model.impl.Model.currentObject;
            platform.client.fp10.core.model.impl.Model.currentObject = _loc9_;
            this.mapInfoModel.putInitParams(_loc5_);
            this.mapInfoModel.objectLoaded();
            this.clanInfoModel.putInitParams(_loc2_);
            Model.popObject();
         }
         platform.client.fp10.core.model.impl.Model.objects[platform.client.fp10.core.model.impl.Model.objects.length] = platform.client.fp10.core.model.impl.Model.currentObject;
         platform.client.fp10.core.model.impl.Model.currentObject = this.battleSelectObject;
         var _loc7_:BattleCreateCC = new BattleCreateCC();
         _loc7_.battleCreationDisabled = _loc3_.battleCreationDisabled;
         _loc7_.battlesLimits = new Vector.<BattleLimits>();
         for each(_loc6_ in _loc3_.battleLimits)
         {
            _loc7_.battlesLimits.push(new BattleLimits(_loc6_.scoreLimit,_loc6_.timeLimitInSec));
         }
         _loc7_.maxRangeLength = _loc3_.maxRangeLength;
         _loc7_.proBattleTimeLeftInSec = _loc3_.proBattleTimeLeftInSec;
         this.battleCreateModel.putInitParams(_loc7_);
         this.battleCreateModel.objectLoaded();
         this.battleCreateModel.objectLoadedPost();
         Model.popObject();
      }
      
      private function createFailedBattleCreateDisabled() : void
      {
         this.battleCreateModel.createFailedBattleCreateDisabled();
      }
      
      private function createFailedServerIsHalting() : void
      {
         this.battleCreateModel.createFailedServerIsHalting();
      }
      
      private function createFailedTooManyBattlesFromYou() : void
      {
         this.battleCreateModel.createFailedTooManyBattlesFromYou();
      }
      
      private function createFailedYouAreBanned() : void
      {
         this.battleCreateModel.createFailedYouAreBanned();
      }
      
      private function setFilteredBattleName(param1:SetFilteredBattleNameInPacket) : void
      {
         var _loc2_:IGameObject = spaceRegistry.getSpace(Long.getLong(59235923,646943)).getObjectByName("BattleSelectObject");
         platform.client.fp10.core.model.impl.Model.objects[platform.client.fp10.core.model.impl.Model.objects.length] = platform.client.fp10.core.model.impl.Model.currentObject;
         platform.client.fp10.core.model.impl.Model.currentObject = _loc2_;
         this.battleCreateModel.setFilteredBattleName(param1.battleName);
         Model.popObject();
      }
   }
}


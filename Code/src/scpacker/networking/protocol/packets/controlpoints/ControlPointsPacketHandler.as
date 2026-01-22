package scpacker.networking.protocol.packets.controlpoints
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.models.controlpoints.IDominationModel;
   import alternativa.tanks.models.controlpoints.ControlPointsModel;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battlefield.models.battle.cp.ControlPointsModelBase;
   import scpacker.networking.protocol.packets.battle.BattlePacketHandler;
   import platform.client.fp10.core.model.impl.Model;
   
   public class ControlPointsPacketHandler extends AbstractPacketHandler
   {
      private var controlPointsModel:ControlPointsModel;
      
      public function ControlPointsPacketHandler()
      {
         super();
         this.id = 60;
         this.controlPointsModel = ControlPointsModel(modelRegistry.getModel(ControlPointsModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case LoadControlPointsCCInPacket.id:
               this.loadControlPointsCC(param1 as LoadControlPointsCCInPacket);
               break;
            case PointCaptureStartedInPacket.id:
               this.pointCaptureStarted(param1 as PointCaptureStartedInPacket);
               break;
            case PointCaptureStoppedInPacket.id:
               this.pointCaptureStopped(param1 as PointCaptureStoppedInPacket);
               break;
            case SetPointProgressInPacket.id:
               this.setPointProgress(param1 as SetPointProgressInPacket);
               break;
            case SetPointStateInPacket.id:
               this.setPointState(param1 as SetPointStateInPacket);
               break;
            case TankEnteredPointZoneInPacket.id:
               this.tankEnteredPointZone(param1 as TankEnteredPointZoneInPacket);
               break;
            case TankLeftPointZoneInPacket.id:
               this.tankLeftPointZone(param1 as TankLeftPointZoneInPacket);
         }
      }
      
      private function loadControlPointsCC(param1:LoadControlPointsCCInPacket) : void
      {
         //OSGi.getInstance().registerService(IDominationModel,this.controlPointsModel);
         BattlePacketHandler.battlefieldGameObject.gameClass.models.push(this.controlPointsModel.id);
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.controlPointsModel.putInitParams(param1.soundNotification);
         this.controlPointsModel.objectLoaded();
         this.controlPointsModel.objectLoadedPost();
         Model.popObject();
      }
      
      private function pointCaptureStarted(param1:PointCaptureStartedInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.controlPointsModel.pointCaptureStarted(param1.team);
         Model.popObject();
      }
      
      private function pointCaptureStopped(param1:PointCaptureStoppedInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.controlPointsModel.pointCaptureStopped(param1.team);
         Model.popObject();
      }
      
      private function setPointProgress(param1:SetPointProgressInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.controlPointsModel.setPointProgress(param1.pointId,param1.progress,param1.progressSpeed);
         Model.popObject();
      }
      
      private function setPointState(param1:SetPointStateInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.controlPointsModel.setPointState(param1.pointId,param1.currentState);
         Model.popObject();
      }
      
      private function tankEnteredPointZone(param1:TankEnteredPointZoneInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.controlPointsModel.tankEnteredPointZone(param1.pointId,param1.tankId);
         Model.popObject()
      }
      
      private function tankLeftPointZone(param1:TankLeftPointZoneInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.controlPointsModel.tankLeftPointZone(param1.pointId,param1.tankId);
         Model.popObject();
      }
   }
}


package scpacker.networking.protocol.packets.userproperties
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import controls.Rank;
   import alternativa.osgi.OSGi;
   import projects.tanks.client.tanksservices.model.notifier.premium.PremiumNotifierData;
   import alternativa.tanks.model.userproperties.UserPropertiesModel;
   import projects.tanks.client.panel.model.profile.userproperties.UserPropertiesModelBase;
   import projects.tanks.client.users.model.userbattlestatistics.rank.RankBounds;
   
   public class UserPropertiesPacketHandler extends AbstractPacketHandler
   {
      private var userPropertiesModel:UserPropertiesModel;
      
      public function UserPropertiesPacketHandler()
      {
         super();
         this.id = 29;
         this.userPropertiesModel = UserPropertiesModel(modelRegistry.getModel(UserPropertiesModelBase.modelId));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case ChangeCrystalCountInPacket.id:
               this.setCrystalCount(param1 as ChangeCrystalCountInPacket);
               break;
            case UpdateScoreInPacket.id:
               this.setScore(param1 as UpdateScoreInPacket);
               break;
            case UpdateRankInPacket.id:
               this.setRank(param1 as UpdateRankInPacket);
               break;
            case UpdateRatingAndPlaceInPacket.id:
               this.setRatingAndPlace(param1 as UpdateRatingAndPlaceInPacket);
               break;
         }
      }
      
      private function setCrystalCount(param1:ChangeCrystalCountInPacket) : void
      {
         this.userPropertiesModel.changeCrystal(param1.crystalCount);
      }

      private function setScore(param1:UpdateScoreInPacket) : void
      {
         this.userPropertiesModel.updateScore(param1.score);
      }

      private function setRank(param1:UpdateRankInPacket) : void
      {
         this.userPropertiesModel.updateRank(param1.rank, param1.score, new RankBounds(param1.currentRankScore, param1.nextScore), param1.crystalGift, false, false);
      }

      private function setRatingAndPlace(param1:UpdateRatingAndPlaceInPacket) : void
      {
         this.userPropertiesModel.updateUserRating(param1.rating);
         this.userPropertiesModel.setPlace(param1.place);
      }
   }
}


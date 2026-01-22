package scpacker.networking.protocol.packets.friends
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.incomingnotificator.FriendsIncomingNotificatorModel;
   import alternativa.types.Long;
   import alternativa.tanks.model.friends.loader.FriendsLoaderModel;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.acceptednotificator.FriendsAcceptedNotificatorModel;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.incoming.FriendsIncomingModel;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.FriendsModel;
   import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.accepted.FriendsAcceptedModel;
   import projects.tanks.client.users.model.friends.accepted.FriendsAcceptedModelBase;
   import projects.tanks.client.users.model.friends.acceptednotificator.FriendsAcceptedNotificatorModelBase;
   import projects.tanks.client.users.model.friends.incoming.FriendsIncomingModelBase;
   import projects.tanks.client.users.model.friends.incomingnotificator.FriendsIncomingNotificatorModelBase;
   import projects.tanks.client.users.model.friends.FriendsModelBase;
   import projects.tanks.client.panel.model.friends.FriendsLoaderModelBase;
   import platform.client.fp10.core.type.IGameClass;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.impl.Space;
   import platform.client.fp10.core.model.impl.Model;
   
   public class FriendsPacketHandler extends AbstractPacketHandler
   {
      private var friendsAcceptedModel:FriendsAcceptedModel;
      private var friendsAcceptedNotificatorModel:FriendsAcceptedNotificatorModel;
      private var friendsIncomingModel:FriendsIncomingModel;
      private var friendsIncomingNotificatorModel:FriendsIncomingNotificatorModel;
      //private var friendsOutgoingModel:FriendsOutgoingModel;
      private var friendsModel:FriendsModel;
      private var friendsLoaderModel:FriendsLoaderModel;
      private var space:Space;
      
      public function FriendsPacketHandler()
      {
         super();
         this.id = 13;

         this.friendsAcceptedModel = FriendsAcceptedModel(modelRegistry.getModel(FriendsAcceptedModelBase.modelId));
         this.friendsAcceptedNotificatorModel = FriendsAcceptedNotificatorModel(modelRegistry.getModel(FriendsAcceptedNotificatorModelBase.modelId));
         this.friendsIncomingModel = FriendsIncomingModel(modelRegistry.getModel(FriendsIncomingModelBase.modelId));
         this.friendsIncomingNotificatorModel = FriendsIncomingNotificatorModel(modelRegistry.getModel(FriendsIncomingNotificatorModelBase.modelId));
         //this.friendsOutgoingModel = FriendsOutgoingModel(modelRegistry.getModel(Long.getLong(1522959740,-985374708)));
         this.friendsModel = FriendsModel(modelRegistry.getModel(FriendsModelBase.modelId));
         this.friendsLoaderModel = FriendsLoaderModel(modelRegistry.getModel(FriendsLoaderModelBase.modelId));

         this.space = new Space(Long.getLong(10566810,44467896),null,null,false);
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case LoadFriendsListInPacket.id:
               this.handleLoadFriendsList(param1 as LoadFriendsListInPacket);
               break;
            case OutgoingOnAddingInPacket.id:
               this.handleOutgoingOnAdding(param1 as OutgoingOnAddingInPacket);
               break;
            case AcceptIncomingFriendInPacket.id:
               this.handleAcceptIncomingFriend(param1 as AcceptIncomingFriendInPacket);
               break;
            case IncomingOnAddingInPacket.id:
               this.handleIncomingOnAdding(param1 as IncomingOnAddingInPacket);
               break;
            case AlreadyInAcceptedFriendsInPacket.id:
               this.handleAlreadyInAcceptedFriends(param1 as AlreadyInAcceptedFriendsInPacket);
               break;
            case AlreadyInIncomingFriendsInPacket.id:
               this.handleAlreadyInIncomingFriends(param1 as AlreadyInIncomingFriendsInPacket);
               break;
            case AlreadyInOutgoingFriendsInPacket.id:
               this.handleAlreadyInOutgoingFriends(param1 as AlreadyInOutgoingFriendsInPacket);
               break;
            case FriendsAcceptedOnRemoveInPacket.id:
               this.handleAcceptedOnRemove(param1 as FriendsAcceptedOnRemoveInPacket);
               break;
            case FriendsIncomingOnRemoveInPacket.id:
               this.handleIncomingOnRemove(param1 as FriendsIncomingOnRemoveInPacket);
               break;
            case FriendsOutgoingOnRemoveInPacket.id:
               this.handleOutgoingOnRemove(param1 as FriendsOutgoingOnRemoveInPacket);
               break;
            case FriendsAcceptedNotificatorOnRemoveInPacket.id:
               this.handleAcceptedNotificatorOnRemove(param1 as FriendsAcceptedNotificatorOnRemoveInPacket);
               break;
            case FriendsIncomingNotificatorOnRemoveInPacket.id:
               this.handleIncomingNotificatorOnRemove(param1 as FriendsIncomingNotificatorOnRemoveInPacket);
               break;
            case FriendsOnUsersLoadedInPacket.id:
               this.handleUsersLoaded();
               break;
            case FriendsUidExistInPacket.id:
               this.handleUidExist();
               break;
            case FriendsUidNotExistInPacket.id:
               this.handleUidNotExist();
         }
      }
      
      private function handleLoadFriendsList(param1:LoadFriendsListInPacket) : void
      {

         var modelVector:Vector.<Long> = new Vector.<Long>();
         modelVector.push(this.friendsAcceptedModel.id);
         modelVector.push(this.friendsAcceptedNotificatorModel.id);
         modelVector.push(this.friendsIncomingModel.id);
         modelVector.push(this.friendsIncomingNotificatorModel.id);
         //modelVector.push(this.friendsOutgoingModel.id);
         modelVector.push(this.friendsLoaderModel.id);
         modelVector.push(this.friendsModel.id);
         var friendsGameClass:IGameClass = this.gameTypeRegistry.createClass(Long.getLong(5555,87654321), modelVector);
         var friendsObject:IGameObject = this.space.createObject(Long.getLong(5555,87654321), friendsGameClass, "Friends game object");

         Model.object = friendsObject;
         this.friendsAcceptedModel.putInitParams(param1.friendsAcceptedCC);
         this.friendsAcceptedModel.objectLoaded();
         this.friendsAcceptedNotificatorModel.putInitParams(param1.friendsAcceptedNotificatorCC);
         this.friendsAcceptedNotificatorModel.objectLoaded();
         this.friendsIncomingModel.putInitParams(param1.friendsIncomingCC);
         this.friendsIncomingModel.objectLoaded();
         this.friendsIncomingNotificatorModel.putInitParams(param1.friendsIncomingNotificatorCC);
         this.friendsIncomingNotificatorModel.objectLoaded();
         this.friendsModel.objectLoaded();
         this.friendsLoaderModel.objectLoadedPost();
         //this.friendsOutgoingModel.putInitParams(param1.friendsOutgoingCC);
         //this.friendsOutgoingModel.objectLoaded();
         Model.popObject();
      }
      
      private function handleUsersLoaded() : void
      {
         this.friendsLoaderModel.onUsersLoaded();
      }
      
      private function handleOutgoingOnAdding(param1:OutgoingOnAddingInPacket) : void
      {
         //this.friendsOutgoingModel.onAdding(param1.userId);
      }
      
      private function handleAcceptIncomingFriend(param1:AcceptIncomingFriendInPacket) : void
      {
         this.friendsAcceptedModel.onAdding(param1.userId);
         this.friendsAcceptedNotificatorModel.onAdding(param1.userId);
         this.friendsIncomingNotificatorModel.onRemoved(param1.userId);
      }
      
      private function handleIncomingOnAdding(param1:IncomingOnAddingInPacket) : void
      {
         this.friendsIncomingModel.onAdding(param1.userId);
         this.friendsIncomingNotificatorModel.onAdding(param1.userId);
      }
      
      private function handleAlreadyInAcceptedFriends(param1:AlreadyInAcceptedFriendsInPacket) : void
      {
         this.friendsModel.alreadyInAcceptedFriends(param1.userId);
      }
      
      private function handleAlreadyInIncomingFriends(param1:AlreadyInIncomingFriendsInPacket) : void
      {
         this.friendsModel.alreadyInIncomingFriends(param1.userId,param1.userId);
      }
      
      private function handleAlreadyInOutgoingFriends(param1:AlreadyInOutgoingFriendsInPacket) : void
      {
         this.friendsModel.alreadyInOutgoingFriends(param1.userId);
      }
      
      private function handleAcceptedOnRemove(param1:FriendsAcceptedOnRemoveInPacket) : void
      {
         this.friendsAcceptedModel.onRemoved(param1.userId);
         this.friendsAcceptedNotificatorModel.onRemoved(param1.userId);
      }
      
      private function handleOutgoingOnRemove(param1:FriendsOutgoingOnRemoveInPacket) : void
      {
         //this.friendsOutgoingModel.onRemoved(param1.userId);
      }
      
      private function handleIncomingOnRemove(param1:FriendsIncomingOnRemoveInPacket) : void
      {
         this.friendsIncomingModel.onRemoved(param1.userId);
         this.friendsIncomingNotificatorModel.onRemoved(param1.userId);
      }
      
      private function handleAcceptedNotificatorOnRemove(param1:FriendsAcceptedNotificatorOnRemoveInPacket) : void
      {
         this.friendsAcceptedNotificatorModel.onRemoved(param1.userId);
      }
      
      private function handleIncomingNotificatorOnRemove(param1:FriendsIncomingNotificatorOnRemoveInPacket) : void
      {
         this.friendsIncomingNotificatorModel.onRemoved(param1.userId);
      }
      
      private function handleUidExist() : void
      {
         //this.friendsModel.uidExist();
      }
      
      private function handleUidNotExist() : void
      {
         //this.friendsModel.uidNotExist();
      }
   }
}


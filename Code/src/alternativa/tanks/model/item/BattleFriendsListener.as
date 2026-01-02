package alternativa.tanks.model.item
{
   
   [ModelInterface]
   public interface BattleFriendsListener
   {
      
      function onAddFriend(param1:String) : void;
      
      function onDeleteFriend(param1:String) : void;
   }
}


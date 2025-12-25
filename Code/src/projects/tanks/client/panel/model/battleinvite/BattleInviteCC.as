package projects.tanks.client.panel.model.battleinvite
{
   import platform.client.fp10.core.resource.types.SoundResource;
   
   public class BattleInviteCC
   {
      private var newname_10666__END:SoundResource;
      
      public function BattleInviteCC(param1:SoundResource = null)
      {
         super();
         this.newname_10666__END = param1;
      }
      
      public function get soundNotification() : SoundResource
      {
         return this.newname_10666__END;
      }
      
      public function set soundNotification(param1:SoundResource) : void
      {
         this.newname_10666__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BattleInviteCC [";
         _loc1_ += "soundNotification = " + this.newname_10666__END + " ";
         return _loc1_ + "]";
      }
   }
}


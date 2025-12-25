package projects.tanks.client.battleservice.model.statistics.dm
{
   import projects.tanks.client.battleservice.model.statistics.UserInfo;
   
   public class StatisticsDMCC
   {
      private var newname_8549__END:Vector.<UserInfo>;
      
      public function StatisticsDMCC(param1:Vector.<UserInfo> = null)
      {
         super();
         this.newname_8549__END = param1;
      }
      
      public function get userInfos() : Vector.<UserInfo>
      {
         return this.newname_8549__END;
      }
      
      public function set userInfos(param1:Vector.<UserInfo>) : void
      {
         this.newname_8549__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "StatisticsDMCC [";
         _loc1_ += "usersInfo = " + this.newname_8549__END + " ";
         return _loc1_ + "]";
      }
   }
}


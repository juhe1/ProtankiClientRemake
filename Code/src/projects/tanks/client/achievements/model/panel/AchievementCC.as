package projects.tanks.client.achievements.model.panel
{
   import projects.tanks.client.achievements.model.Achievement;
   
   public class AchievementCC
   {
      private var newname_10190__END:Vector.<Achievement>;
      
      public function AchievementCC(param1:Vector.<Achievement> = null)
      {
         super();
         this.newname_10190__END = param1;
      }
      
      public function get activeAchievements() : Vector.<Achievement>
      {
         return this.newname_10190__END;
      }
      
      public function set activeAchievements(param1:Vector.<Achievement>) : void
      {
         this.newname_10190__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "AchievementCC [";
         _loc1_ += "activeAchievements = " + this.newname_10190__END + " ";
         return _loc1_ + "]";
      }
   }
}


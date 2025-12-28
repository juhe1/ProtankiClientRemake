package projects.tanks.clients.fp10.libraries.tanksservices.service.rank
{
   import projects.tanks.client.tanksservices.model.rankloader.RankInfo;
   
   public class RankServiceImpl implements RankService
   {
      
      private var _rankNames:Vector.<String>;
      
      public function RankServiceImpl()
      {
         super();
         initRanks(Vector.<RankInfo>([
            new RankInfo(1,"Recruit"),
            new RankInfo(2,"Private"),
            new RankInfo(3,"Gefreiter"),
            new RankInfo(4,"Corporal"),
            new RankInfo(5,"Master Corporal"),
            new RankInfo(6,"Sergeant"),
            new RankInfo(7,"Staff Sergeant"),
            new RankInfo(8,"Master Sergeant"),
            new RankInfo(9,"First Sergeant"),
            new RankInfo(10,"Sergeant-Major"),
            new RankInfo(11,"Warrant Officer 1"),
            new RankInfo(12,"Warrant Officer 2"),
            new RankInfo(13,"Warrant Officer 3"),
            new RankInfo(14,"Warrant Officer 4"),
            new RankInfo(15,"Warrant Officer 5"),
            new RankInfo(16,"Third Lieutenant"),
            new RankInfo(17,"Second Lieutenant"),
            new RankInfo(18,"First Lieutenant"),
            new RankInfo(19,"Captain"),
            new RankInfo(20,"Major"),
            new RankInfo(21,"Lieutenant Colonel"),
            new RankInfo(22,"Colonel"),
            new RankInfo(23,"Brigadier"),
            new RankInfo(24,"Major General"),
            new RankInfo(25,"Lieutenant General"),
            new RankInfo(26,"General"),
            new RankInfo(27,"Marshal"),
            new RankInfo(28,"Field Marshal"),
            new RankInfo(29,"Commander"),
            new RankInfo(30,"Generalissimo")
         ]));
      }
      
      public function getRankName(param1:int) : String
      {
         if(param1 > this._rankNames.length)
         {
            return this._rankNames[this._rankNames.length - 1] + " " + (param1 + 1 - this._rankNames.length);
         }
         return this._rankNames[param1 - 1];
      }
      
      public function getNormalizedRankIndex(param1:int) : int
      {
         return Math.min(this._rankNames.length,param1);
      }
      
      public function initRanks(param1:Vector.<RankInfo>) : void
      {
         var _loc2_:RankInfo = null;
         this._rankNames = new Vector.<String>(param1.length);
         for each(_loc2_ in param1)
         {
            this._rankNames[_loc2_.index - 1] = _loc2_.name;
         }
      }
      
      public function get rankNames() : Vector.<String>
      {
         return this._rankNames;
      }
   }
}


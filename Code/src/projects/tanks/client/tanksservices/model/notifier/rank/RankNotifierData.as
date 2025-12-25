package projects.tanks.client.tanksservices.model.notifier.rank
{
   import projects.tanks.client.tanksservices.model.notifier.AbstractNotifier;
   
   public class RankNotifierData extends AbstractNotifier
   {
      
      private var _rank:int;
      
      public function RankNotifierData(param1:int = 0)
      {
         super();
         this._rank = param1;
      }
      
      public function get rank() : int
      {
         return this._rank;
      }
      
      public function set rank(param1:int) : void
      {
         this._rank = param1;
      }
      
      override public function toString() : String
      {
         var _loc1_:String = "RankNotifierData [";
         _loc1_ += "rank = " + this.rank + " ";
         _loc1_ += super.toString();
         return _loc1_ + "]";
      }
   }
}


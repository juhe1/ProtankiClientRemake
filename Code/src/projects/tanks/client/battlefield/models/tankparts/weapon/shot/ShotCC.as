package projects.tanks.client.battlefield.models.tankparts.weapon.shot
{
   public class ShotCC
   {
      
      private var _reloadMsec:Number;
      
      public function ShotCC(param1:Number = 0)
      {
         super();
         this._reloadMsec = param1;
      }
      
      public function get reloadMsec() : Number
      {
         return this._reloadMsec;
      }
      
      public function set reloadMsec(param1:Number) : void
      {
         this._reloadMsec = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ShotCC [";
         _loc1_ += "reloadMsec = " + this.reloadMsec + " ";
         return _loc1_ + "]";
      }
   }
}


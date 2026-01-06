package projects.tanks.client.battlefield.models.effects.effectlevel
{
   public class EffectLevelCC
   {
      
      private var _effectLevel:int;
      
      public function EffectLevelCC(param1:int = 0)
      {
         super();
         this._effectLevel = param1;
      }
      
      public function get effectLevel() : int
      {
         return this._effectLevel;
      }
      
      public function set effectLevel(param1:int) : void
      {
         this._effectLevel = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "EffectLevelCC [";
         _loc1_ += "effectLevel = " + this.effectLevel + " ";
         return _loc1_ + "]";
      }
   }
}


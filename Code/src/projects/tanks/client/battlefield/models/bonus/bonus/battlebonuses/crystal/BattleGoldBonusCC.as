package projects.tanks.client.battlefield.models.bonus.bonus.battlebonuses.crystal
{
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class BattleGoldBonusCC
   {
      
      private var _sound:SoundResource;
      
      private var _sprite:ImageResource;
      
      public function BattleGoldBonusCC(param1:SoundResource = null, param2:ImageResource = null)
      {
         super();
         this._sound = param1;
         this._sprite = param2;
      }
      
      public function get sound() : SoundResource
      {
         return this._sound;
      }
      
      public function set sound(param1:SoundResource) : void
      {
         this._sound = param1;
      }
      
      public function get sprite() : ImageResource
      {
         return this._sprite;
      }
      
      public function set sprite(param1:ImageResource) : void
      {
         this._sprite = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BattleGoldBonusCC [";
         _loc1_ += "sound = " + this.sound + " ";
         _loc1_ += "sprite = " + this.sprite + " ";
         return _loc1_ + "]";
      }
   }
}


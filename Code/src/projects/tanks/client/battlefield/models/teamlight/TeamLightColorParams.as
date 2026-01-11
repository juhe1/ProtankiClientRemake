package projects.tanks.client.battlefield.models.teamlight
{
   public class TeamLightColorParams
   {
      
      private var _color:String;
      
      private var _intensity:Number;
      
      public function TeamLightColorParams(__color:String = null, __intensity:Number = 0)
      {
         super();
         this._color = __color;
         this._intensity = __intensity;
      }
      
      public function get color() : String
      {
         return this._color;
      }
      
      public function set color(param1:String) : void
      {
         this._color = param1;
      }
      
      public function get intensity() : Number
      {
         return this._intensity;
      }
      
      public function set intensity(param1:Number) : void
      {
         this._intensity = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "TeamLightColorParams [";
         _loc1_ += "color = " + this.color + " ";
         _loc1_ += "intensity = " + this.intensity + " ";
         return _loc1_ + "]";
      }
   }
}


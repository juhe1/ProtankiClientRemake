package projects.tanks.client.battleservice.model.map.params
{
   public class MapTheme
   {
      public static const SUMMER:MapTheme = new MapTheme(0,"SUMMER");
      
      public static const WINTER:MapTheme = new MapTheme(1,"WINTER");
      
      public static const SPACE:MapTheme = new MapTheme(2,"SPACE");
      
      public static const SUMMER_DAY:MapTheme = new MapTheme(3,"SUMMER_DAY");
      
      public static const SUMMER_NIGHT:MapTheme = new MapTheme(4,"SUMMER_NIGHT");
      
      public static const WINTER_DAY:MapTheme = new MapTheme(5,"WINTER_DAY");
      
      public static const WINTER_NIGHT:MapTheme = new MapTheme(6,"WINTER_NIGHT");
      
      private var _value:int;
      
      private var _name:String;
      
      public function MapTheme(param1:int, param2:String)
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public static function get values() : Vector.<MapTheme>
      {
         var _loc1_:Vector.<MapTheme> = new Vector.<MapTheme>();
         _loc1_.push(SUMMER);
         _loc1_.push(WINTER);
         _loc1_.push(SPACE);
         _loc1_.push(SUMMER_DAY);
         _loc1_.push(SUMMER_NIGHT);
         _loc1_.push(WINTER_DAY);
         _loc1_.push(WINTER_NIGHT);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "MapTheme [" + this._name + "]";
      }
      
      public function get value() : int
      {
         return this._value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
   }
}


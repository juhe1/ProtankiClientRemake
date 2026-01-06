package alternativa.tanks.battle.hidablegraphicobjects
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.scene3d.Renderer;
   
   public class HidableGraphicObjects implements Renderer
   {
      
      private static const _objectPosition:Vector3 = new Vector3();
      
      private var hideRadiusSquared:Number;
      
      private const center:Vector3 = new Vector3();
      
      private const objects:Vector.<HidableGraphicObject> = new Vector.<HidableGraphicObject>();
      
      private var numObjects:int;
      
      public function HidableGraphicObjects()
      {
         super();
      }
      
      public function add(param1:HidableGraphicObject) : void
      {
         if(this.objects.indexOf(param1) < 0)
         {
            this.objects[this.numObjects++] = param1;
         }
      }
      
      public function remove(param1:HidableGraphicObject) : void
      {
         var _loc2_:int = int(this.objects.indexOf(param1));
         if(_loc2_ >= 0)
         {
            param1.setAlphaMultiplier(1);
            --this.numObjects;
            this.objects[_loc2_] = this.objects[this.numObjects];
            this.objects[this.numObjects] = null;
         }
      }
      
      public function setCenterAndRadius(param1:Vector3, param2:Number) : void
      {
         this.center.copy(param1);
         this.hideRadiusSquared = param2 * param2;
      }
      
      public function restore() : void
      {
         var _loc2_:HidableGraphicObject = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.numObjects)
         {
            _loc2_ = this.objects[_loc1_];
            _loc2_.setAlphaMultiplier(1);
            _loc1_++;
         }
      }
      
      public function render(param1:int, param2:int) : void
      {
         var _loc4_:HidableGraphicObject = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.numObjects)
         {
            _loc4_ = this.objects[_loc3_];
            _loc4_.readPosition(_objectPosition);
            _loc4_.setAlphaMultiplier(this.getAlphaMultiplier(_objectPosition));
            _loc3_++;
         }
      }
      
      private function getAlphaMultiplier(param1:Vector3) : Number
      {
         var _loc2_:Number = param1.x - this.center.x;
         var _loc3_:Number = param1.y - this.center.y;
         var _loc4_:Number = param1.z - this.center.z;
         var _loc5_:Number = _loc2_ * _loc2_ + _loc3_ * _loc3_ + _loc4_ * _loc4_;
         if(_loc5_ < this.hideRadiusSquared)
         {
            return Math.sqrt(_loc5_ / this.hideRadiusSquared);
         }
         return 1;
      }
      
      public function clear() : void
      {
         this.objects.length = 0;
         this.numObjects = 0;
      }
   }
}


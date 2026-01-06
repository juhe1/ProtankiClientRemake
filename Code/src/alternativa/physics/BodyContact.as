package alternativa.physics
{
   public class BodyContact
   {
      
      private static var poolTop:BodyContact;
      
      public var body1:Body;
      
      public var body2:Body;
      
      public var shapeContacts:Vector.<ShapeContact> = new Vector.<ShapeContact>();
      
      private var nextInPool:BodyContact;
      
      public function BodyContact()
      {
         super();
      }
      
      public static function create() : BodyContact
      {
         if(poolTop == null)
         {
            return new BodyContact();
         }
         var _loc1_:BodyContact = poolTop;
         poolTop = poolTop.nextInPool;
         _loc1_.nextInPool = null;
         return _loc1_;
      }
      
      public function dispose() : void
      {
         var _loc3_:ShapeContact = null;
         this.body1 = null;
         this.body2 = null;
         var _loc1_:uint = this.shapeContacts.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.shapeContacts[_loc2_];
            _loc3_.dispose();
            _loc2_++;
         }
         this.shapeContacts.length = 0;
         this.nextInPool = poolTop;
         poolTop = this;
      }
      
      public function copy(param1:BodyContact) : void
      {
         this.body1 = param1.body1;
         this.body2 = param1.body2;
         var _loc2_:Vector.<ShapeContact> = param1.shapeContacts;
         var _loc3_:uint = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this.shapeContacts[this.shapeContacts.length] = _loc2_[_loc4_];
            _loc4_++;
         }
      }
      
      public function setShapeContacts(param1:Vector.<ShapeContact>) : void
      {
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.shapeContacts[_loc3_] = param1[_loc3_];
            _loc3_++;
         }
      }
   }
}


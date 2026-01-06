package alternativa.physics.contactislands
{
   import alternativa.physics.Body;
   import alternativa.physics.BodyContact;
   
   public class ContactLevels
   {
      
      private const contacts:Vector.<BodyContact> = new Vector.<BodyContact>();
      
      public function ContactLevels()
      {
         super();
      }
      
      public function init(param1:Vector.<BodyContact>) : void
      {
         var _loc2_:int = int(param1.length);
         this.contacts.length = _loc2_;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.contacts[_loc3_] = param1[_loc3_];
            _loc3_++;
         }
      }
      
      public function clear() : void
      {
         this.contacts.length = 0;
      }
      
      public function getStaticLevel(param1:Vector.<BodyContact>, param2:Vector.<Body>) : void
      {
         var _loc3_:int = 0;
         var _loc4_:BodyContact = null;
         _loc3_ = 0;
         while(_loc3_ < this.contacts.length)
         {
            _loc4_ = this.contacts[_loc3_];
            if(this.isStaticContact(_loc4_))
            {
               param1[param1.length] = _loc4_;
               param2[param2.length] = this.getNonStaticBody(_loc4_);
               this.removeContact(_loc3_);
               _loc3_--;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.contacts.length)
         {
            _loc4_ = this.contacts[_loc3_];
            if(param2.indexOf(_loc4_.body1) >= 0 && param2.indexOf(_loc4_.body2) >= 0)
            {
               param1[param1.length] = _loc4_;
               this.removeContact(_loc3_);
               _loc3_--;
            }
            _loc3_++;
         }
      }
      
      private function isStaticContact(param1:BodyContact) : Boolean
      {
         return !(param1.body1.movable && param1.body2.movable);
      }
      
      private function getNonStaticBody(param1:BodyContact) : Body
      {
         if(param1.body1.movable)
         {
            return param1.body1;
         }
         return param1.body2;
      }
      
      private function removeContact(param1:int) : void
      {
         var _loc2_:int = this.contacts.length - 1;
         this.contacts[param1] = this.contacts[_loc2_];
         this.contacts.length = _loc2_;
      }
      
      public function getNextLevel(param1:Vector.<Body>, param2:Vector.<BodyContact>, param3:Vector.<Body>) : void
      {
         var _loc4_:int = 0;
         var _loc5_:BodyContact = null;
         _loc4_ = 0;
         while(_loc4_ < this.contacts.length)
         {
            _loc5_ = this.contacts[_loc4_];
            if(this.isInContactWith(param1,_loc5_))
            {
               param2[param2.length] = _loc5_;
               param3[param3.length] = this.getNextLevelBody(_loc5_,param1);
               this.removeContact(_loc4_);
               _loc4_--;
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < this.contacts.length)
         {
            _loc5_ = this.contacts[_loc4_];
            if(param3.indexOf(_loc5_.body1) >= 0 && param3.indexOf(_loc5_.body2) >= 0)
            {
               param2[param2.length] = _loc5_;
               this.removeContact(_loc4_);
               _loc4_--;
            }
            _loc4_++;
         }
      }
      
      private function isInContactWith(param1:Vector.<Body>, param2:BodyContact) : Boolean
      {
         return param1.indexOf(param2.body1) >= 0 || param1.indexOf(param2.body2) >= 0;
      }
      
      private function getNextLevelBody(param1:BodyContact, param2:Vector.<Body>) : Body
      {
         if(param2.indexOf(param1.body1) < 0)
         {
            return param1.body1;
         }
         return param1.body2;
      }
      
      public function hasContacts() : Boolean
      {
         return this.contacts.length > 0;
      }
   }
}


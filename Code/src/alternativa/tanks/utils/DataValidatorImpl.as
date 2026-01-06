package alternativa.tanks.utils
{
   import alternativa.osgi.OSGi;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   
   public class DataValidatorImpl implements DataValidator
   {
      
      private static const zero:EncryptedInt = new EncryptedIntImpl();
      
      private static const one:EncryptedInt = new EncryptedIntImpl(1);
      
      private static const numChecksPerTick:EncryptedInt = new EncryptedIntImpl(5);
      
      private const currentIndex:EncryptedInt = new EncryptedIntImpl();
      
      private var battleEventDispatcher:BattleEventDispatcher;
      
      private var validators:Vector.<DataUnitValidator> = new Vector.<DataUnitValidator>();
      
      public function DataValidatorImpl(param1:OSGi)
      {
         super();
         this.battleEventDispatcher = BattleEventDispatcher(param1.getService(BattleEventDispatcher));
      }
      
      public function addValidator(param1:DataUnitValidator) : void
      {
         if(this.validators.indexOf(param1) < zero.getInt())
         {
            this.validators.push(param1);
         }
      }
      
      public function removeValidator(param1:DataUnitValidator) : void
      {
         var _loc2_:int = int(this.validators.indexOf(param1));
         if(_loc2_ >= zero.getInt())
         {
            this.validators.splice(_loc2_,one.getInt());
         }
      }
      
      public function removeAllValidators() : void
      {
         this.validators.length = zero.getInt();
      }
      
      public function tick() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DataUnitValidator = null;
         if(this.validators.length > zero.getInt())
         {
            _loc1_ = int(zero.getInt());
            while(_loc1_ < numChecksPerTick.getInt())
            {
               _loc2_ = this.getNextValidator();
               if(_loc2_.hasIncorrectData())
               {
                  this.battleEventDispatcher.dispatchEvent(new DataValidationErrorEvent(_loc2_.getType()));
                  break;
               }
               _loc1_++;
            }
         }
      }
      
      private function getNextValidator() : DataUnitValidator
      {
         return this.validators[this.getNextIndex()];
      }
      
      private function getNextIndex() : int
      {
         var _loc1_:int = int(this.currentIndex.getInt());
         _loc1_++;
         if(_loc1_ >= this.validators.length)
         {
            _loc1_ = int(zero.getInt());
         }
         this.currentIndex.setInt(_loc1_);
         return _loc1_;
      }
   }
}


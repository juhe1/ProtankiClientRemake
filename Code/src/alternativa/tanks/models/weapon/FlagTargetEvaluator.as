package alternativa.tanks.models.weapon
{
   import alternativa.physics.Body;
   import flash.utils.Dictionary;
   import projects.tanks.client.battlefield.models.battle.ctf.ClientFlag;
   
   public class FlagTargetEvaluator
   {
      
      private var carriers:Dictionary = new Dictionary();
      
      public function FlagTargetEvaluator()
      {
         super();
      }
      
      public function setFlagCarrier(param1:ClientFlag, param2:Body) : void
      {
         if(param2 != null)
         {
            this.carriers[param1] = param2;
         }
         else
         {
            delete this.carriers[param1];
         }
      }
      
      public function isCarrier(param1:Body) : Boolean
      {
         var _loc2_:Body = null;
         for each(_loc2_ in this.carriers)
         {
            if(_loc2_ == param1)
            {
               return true;
            }
         }
         return false;
      }
   }
}


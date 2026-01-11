package alternativa.tanks.battle
{
   import alternativa.physics.Body;
   import projects.tanks.client.battlefield.models.battle.ctf.ClientFlag;
   
   public interface CTFTargetEvaluator extends TeamDMTargetEvaluator
   {
      
      function setFlagCarrier(param2:Body) : void;
   }
}


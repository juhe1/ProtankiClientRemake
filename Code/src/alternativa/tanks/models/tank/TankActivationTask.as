package alternativa.tanks.models.tank
{
   import alternativa.tanks.battle.LogicUnit;
   import platform.client.fp10.core.type.IGameObject;
   
   public class TankActivationTask implements LogicUnit
   {
      
      private var activationTime:int;
      
      private var tankObject:IGameObject;
      
      public function TankActivationTask(param1:int, param2:IGameObject)
      {
         super();
         this.activationTime = param1;
         this.tankObject = param2;
      }
      
      public function runLogic(param1:int, param2:int) : void
      {
         if(param1 > this.activationTime)
         {
            ITankModel(this.tankObject.adapt(ITankModel)).onReadyToActivate();
         }
      }
   }
}


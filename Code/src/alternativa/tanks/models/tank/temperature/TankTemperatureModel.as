package alternativa.tanks.models.tank.temperature
{
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.tank.ITankModel;
   import projects.tanks.client.battlefield.models.user.temperature.ITankTemperatureModelBase;
   import projects.tanks.client.battlefield.models.user.temperature.TankTemperatureModelBase;
   
   [ModelInfo]
   public class TankTemperatureModel extends TankTemperatureModelBase implements ITankTemperatureModelBase
   {
      
      public function TankTemperatureModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function setTemperature(param1:Number) : void
      {
         var _loc2_:Tank = ITankModel(object.adapt(ITankModel)).getTank();
         if(_loc2_ != null)
         {
            _loc2_.setTemperature(param1);
         }
      }
   }
}


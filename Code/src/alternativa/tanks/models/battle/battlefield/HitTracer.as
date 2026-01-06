package alternativa.tanks.models.battle.battlefield
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import projects.tanks.client.battlefield.models.battle.battlefield.types.HitTraceData;
   
   public class HitTracer
   {
      
      public function HitTracer()
      {
         super();
      }
      
      public static function trace(param1:HitTraceData) : void
      {
         var _loc2_:Number = param1.colorResistDamage - param1.origDamage;
         var _loc3_:Number = param1.weaponEffectsDamage - param1.colorResistDamage;
         var _loc4_:Number = param1.armorPreEffectDamage - param1.weaponEffectsDamage;
         var _loc5_:Number = param1.targetHealth - param1.postHealth;
         IClientLog(OSGi.getInstance().getService(IClientLog)).log("damage",makeCell(param1.killerTurretName,12) + makeCell(param1.targetHullName,12) + makeCell(param1.targetHealth.toFixed(2),13) + makeCell(param1.origDamage.toFixed(2),11) + makeCell(_loc2_ != 0 ? _loc2_.toFixed(2) : "",13) + makeCell(_loc3_ != 0 ? _loc3_.toFixed(2) : "",13) + makeCell(_loc4_ != 0 ? _loc4_.toFixed(2) : "",12) + makeCell(_loc5_.toFixed(2),11) + makeCell(param1.postHealth.toFixed(2),12));
      }
      
      private static function makeCell(param1:String, param2:int) : String
      {
         var _loc3_:String = param1;
         if(_loc3_.length >= param2)
         {
            _loc3_ = _loc3_.substr(0,param2 - 2) + "\\";
         }
         var _loc4_:int = param2 - _loc3_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = " " + _loc3_;
            _loc5_++;
         }
         return _loc3_;
      }
   }
}


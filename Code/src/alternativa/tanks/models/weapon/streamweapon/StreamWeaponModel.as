package alternativa.tanks.models.weapon.streamweapon
{
   import platform.client.fp10.core.model.ObjectLoadListener;
   import projects.tanks.client.battlefield.models.tankparts.weapon.streamweapon.IStreamWeaponModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.streamweapon.StreamWeaponCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.streamweapon.StreamWeaponModelBase;
   
   [ModelInfo]
   public class StreamWeaponModel extends StreamWeaponModelBase implements IStreamWeaponModelBase, IStreamWeaponModel, ObjectLoadListener
   {
      
      public function StreamWeaponModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:StreamWeaponCC = getInitParam();
         var _loc2_:StreamWeaponData = new StreamWeaponData(_loc1_.energyCapacity,_loc1_.energyDischargeSpeed,_loc1_.energyRechargeSpeed,_loc1_.weaponTickIntervalMsec);
         putData(StreamWeaponData,_loc2_);
      }
      
      public function getStreamWeaponData() : StreamWeaponData
      {
         return StreamWeaponData(getData(StreamWeaponData));
      }
   }
}


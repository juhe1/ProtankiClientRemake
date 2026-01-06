package alternativa.tanks.models.weapon.machinegun.sfx
{
   import alternativa.tanks.models.sfx.lighting.LightingSfx;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.sfx.IMachineGunSFXModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.sfx.MachineGunSFXModelBase;
   
   [ModelInfo]
   public class MachineGunSFXModel extends MachineGunSFXModelBase implements IMachineGunSFXModelBase, IMachineGunSFXModel, ObjectLoadPostListener
   {
      
      public function MachineGunSFXModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         var _loc1_:MachineGunSFXData = new MachineGunSFXData(getInitParam(),new LightingSfx(getInitParam().lightingSFXEntity));
         putData(MachineGunSFXData,_loc1_);
      }
      
      public function getSfxData() : MachineGunSFXData
      {
         return MachineGunSFXData(getData(MachineGunSFXData));
      }
   }
}


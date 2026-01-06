package alternativa.tanks.models.weapon.shotgun.aiming
{
   import alternativa.tanks.models.weapon.WeaponObject;
   import alternativa.tanks.models.weapon.shotgun.PelletDirectionCalculator;
   import alternativa.tanks.models.weapon.shotgun.ShotgunRicochetTargetingSystem;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.IShotgunHittingModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.ShotgunHittingModelBase;
   
   [ModelInfo]
   public class ShotgunAimingModel extends ShotgunHittingModelBase implements IShotgunHittingModelBase, ShotgunAiming
   {
      
      public function ShotgunAimingModel()
      {
         super();
      }
      
      public function createTargetingSystem() : ShotgunRicochetTargetingSystem
      {
         var _loc1_:WeaponObject = new WeaponObject(object);
         return new ShotgunRicochetTargetingSystem(_loc1_,this.getPelletDirectionCalculator(),getInitParam());
      }
      
      public function getPelletDirectionCalculator() : PelletDirectionCalculator
      {
         var _loc1_:PelletDirectionCalculator = PelletDirectionCalculator(getData(PelletDirectionCalculator));
         if(_loc1_ == null)
         {
            _loc1_ = new PelletDirectionCalculator(getInitParam());
            putData(PelletDirectionCalculator,_loc1_);
         }
         return _loc1_;
      }
   }
}


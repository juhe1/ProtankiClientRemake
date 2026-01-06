package alternativa.tanks.models.weapon.artillery
{
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.ArtilleryCC;
   
   public class RemoteArtilleryWeapon extends ArtilleryWeapon
   {
      
      public function RemoteArtilleryWeapon(param1:IGameObject, param2:ArtilleryObject, param3:ArtilleryCC)
      {
         super(param1,param2,param3);
      }
      
      override public function enable() : void
      {
      }
      
      override public function disable(param1:Boolean) : void
      {
         stop(0,param1);
      }
   }
}


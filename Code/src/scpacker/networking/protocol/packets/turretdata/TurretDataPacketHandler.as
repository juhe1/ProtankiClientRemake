package scpacker.networking.protocol.packets.turretdata
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.tanks.models.weapon.weakening.WeaponWeakeningModel;
   import scpacker.weapon.WeaponModelUtil;
   import scpacker.weapon.WeaponData;
   import projects.tanks.client.battlefield.models.tankparts.weapon.weakening.WeaponWeakeningCC;
   
   public class TurretDataPacketHandler extends AbstractPacketHandler
   {

      public function TurretDataPacketHandler()
      {
         super();
         this.id = 58;
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case LoadTurretDataInPacket.id:
               this.LoadTurretData(param1 as LoadTurretDataInPacket);
         }
      }
      
      private function LoadTurretData(param1:LoadTurretDataInPacket) : void
      {
         var weaponJson:Object = null;
         var weaponData:WeaponData = null;
         var specialEntity:* = undefined;
         var json:Object = JSON.parse(param1.json);
         for each(weaponJson in json.weapons)
         {
            weaponData = new WeaponData(weaponJson.reload,weaponJson.auto_aiming_down,weaponJson.auto_aiming_up,weaponJson.num_rays_up,weaponJson.num_rays_down);
            if(weaponJson.has_wwd)
            {
               var weaponWeakeningCC:WeaponWeakeningCC = new WeaponWeakeningCC(weaponJson.max_damage_radius,weaponJson.min_damage_percent,weaponJson.min_damage_radius);
               WeaponModelUtil.weaponWeakeningDatas[weaponJson.id] = weaponWeakeningCC;
            }
            specialEntity = weaponJson.special_entity;
            WeaponModelUtil.weaponDatas[weaponJson.id] = weaponData;
            WeaponModelUtil.weaponJsonSpecialEntities[weaponJson.id] = specialEntity;
         }
      }
   }
}


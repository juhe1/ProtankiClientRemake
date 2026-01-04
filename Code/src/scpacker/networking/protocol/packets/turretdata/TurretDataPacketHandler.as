package scpacker.networking.protocol.packets.turretdata
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import scpacker.tanks.WeaponsManager;
   import alternativa.types.Long;
   import newname_7089__END.newname_7090__END;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.tanks.models.weapon.weakening.WeaponWeakeningModel;
   
   public class TurretDataPacketHandler extends AbstractPacketHandler
   {
      private var weaponWeakeningModel:WeaponWeakeningModel;
      
      public function TurretDataPacketHandler()
      {
         super();
         this.id = 58;
         this.weaponWeakeningModel = WeaponWeakeningModel(modelRegistry.getModel(Long.getLong(1486543535,-1939817925)));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId() - -2124388778)
         {
            case 0:
               this.LoadTurretData(param1 as LoadTurretDataInPacket);
         }
      }
      
      private function LoadTurretData(param1:LoadTurretDataInPacket) : void
      {
         var _loc4_:Object = null;
         var _loc5_:newname_7090__END = null;
         var _loc3_:* = undefined;
         var _loc2_:Object = JSON.parse(param1.json);
         for each(_loc4_ in _loc2_.weapons)
         {
            _loc5_ = new newname_7090__END(_loc4_.reload,_loc4_.auto_aiming_down,_loc4_.auto_aiming_up,_loc4_.num_rays_up,_loc4_.num_rays_down);
            if(_loc4_.has_wwd)
            {
               this.weaponWeakeningModel.newname_5979__END(WeaponsManager.newname_2440__END(_loc4_.id),_loc4_.max_damage_radius,_loc4_.min_damage_percent,_loc4_.min_damage_radius);
            }
            _loc3_ = _loc4_.special_entity;
            WeaponsManager.newname_5965__END[_loc4_.id] = _loc5_;
            WeaponsManager.newname_123__END[_loc4_.id] = _loc3_;
         }
      }
   }
}


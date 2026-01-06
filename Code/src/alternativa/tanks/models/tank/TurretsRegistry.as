package alternativa.tanks.models.tank
{
   import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkinCacheItem;
   import flash.utils.Dictionary;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   internal class TurretsRegistry
   {
      
      private var turrets:Dictionary = new Dictionary();
      
      public function TurretsRegistry()
      {
         super();
      }
      
      public function getTurret(param1:Tanks3DSResource) : TurretSkinCacheItem
      {
         var _loc2_:TurretSkinCacheItem = this.turrets[param1.id];
         if(_loc2_ == null)
         {
            _loc2_ = new TurretSkinCacheItem(param1);
            this.turrets[param1.id] = _loc2_;
         }
         return _loc2_;
      }
   }
}


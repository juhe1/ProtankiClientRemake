package alternativa.tanks.battle.objects.tank
{
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   public interface Weapon
   {
      
      function init(param1:WeaponPlatform) : void;
      
      function destroy() : void;
      
      function activate() : void;
      
      function deactivate() : void;
      
      function enable() : void;
      
      function disable(param1:Boolean) : void;
      
      function reset() : void;
      
      function getStatus() : Number;
      
      function getResistanceProperty() : ItemProperty;
   }
}


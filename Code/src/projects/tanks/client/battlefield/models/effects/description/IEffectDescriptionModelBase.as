package projects.tanks.client.battlefield.models.effects.description
{
   public interface IEffectDescriptionModelBase
   {
      
      function activated(param1:int, param2:Boolean) : void;
      
      function deactivated() : void;
      
      function merged(param1:int, param2:Boolean) : void;
   }
}


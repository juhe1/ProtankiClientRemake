package projects.tanks.client.battlefield.models.battle.battlefield.mine
{
   import alternativa.types.Long;
   
   public interface IBattleMinesModelBase
   {
      
      function activateMine(param1:String) : void;
      
      function explodeMine(param1:String, param2:String) : void;
      
      function putMine(param1:String, param2:Number, param3:Number, param4:Number, param5:String) : void;
      
      function removeAllMines(param1:String) : void;
      
      function removeMines(param1:String, param2:Vector.<String>) : void;
   }
}


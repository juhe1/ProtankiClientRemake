package alternativa.tanks.models.battle.battlefield.billboard
{
   import alternativa.osgi.service.command.CommandService;
   import alternativa.osgi.service.command.FormattedOutput;
   import alternativa.tanks.battle.BattleService;
   import flash.display.BitmapData;
   import platform.client.fp10.core.type.AutoClosable;
   
   public class BillboardsDebugCommands implements AutoClosable
   {
      
      [Inject] // added
      public static var commandService:CommandService;
      
      [Inject] // added
      public static var battleService:BattleService;
      
      public function BillboardsDebugCommands()
      {
         super();
      }
      
      private function setBillboard(param1:FormattedOutput) : void
      {
      }
      
      private function generateBillboard() : BitmapData
      {
         var _loc1_:BitmapData = new BitmapData(64,64,false,0);
         _loc1_.perlinNoise(64,64,3,Math.random() * 255,false,true);
         return _loc1_;
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
      }
   }
}


package alternativa.tanks.battle.scene3d
{
   import alternativa.engine3d.objects.Decal;
   import alternativa.tanks.battle.BattleService;
   import flash.utils.getTimer;
   
   public class FadingDecalsRenderer implements Renderer
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private var fadeTime:int;
      
      private var entries:Vector.<DecalEntry> = new Vector.<DecalEntry>();
      
      private var numDecals:int;
      
      public function FadingDecalsRenderer(param1:int)
      {
         super();
         this.fadeTime = param1;
      }
      
      public function render(param1:int, param2:int) : void
      {
         var _loc7_:DecalEntry = null;
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = this.numDecals;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = this.entries[_loc5_];
            _loc8_ = param1 - _loc7_.startTime;
            if(_loc8_ > this.fadeTime)
            {
               _loc3_++;
               battleService.getBattleScene3D().removeDecal(_loc7_.decal);
               --this.numDecals;
            }
            else
            {
               _loc7_.decal.alpha = 1 - _loc8_ / this.fadeTime;
               if(_loc3_ > 0)
               {
                  this.entries[_loc5_ - _loc3_] = _loc7_;
               }
            }
            _loc5_++;
         }
         var _loc6_:int = this.numDecals;
         while(_loc6_ < _loc4_)
         {
            this.entries[_loc6_] = null;
            _loc6_++;
         }
      }
      
      public function add(param1:Decal) : void
      {
         this.entries[this.numDecals++] = new DecalEntry(param1,getTimer());
      }
   }
}


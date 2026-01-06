package alternativa.tanks.battle.scene3d
{
   import alternativa.tanks.battle.*;
   
   public class RenderGroup
   {
      
      private var renderers:Vector.<Renderer> = new Vector.<Renderer>();
      
      private var size:int;
      
      private var rendering:Boolean;
      
      private const deferredActions:Vector.<DeferredAction> = new Vector.<DeferredAction>();
      
      public function RenderGroup()
      {
         super();
      }
      
      public function addRenderer(param1:Renderer) : void
      {
         if(this.rendering)
         {
            this.deferredActions.push(new DeferredRendererAddition(this,param1));
         }
         else if(this.renderers.indexOf(param1) < 0)
         {
            this.renderers[this.size++] = param1;
         }
      }
      
      public function removeRenderer(param1:Renderer) : void
      {
         var _loc2_:int = 0;
         if(this.rendering)
         {
            this.deferredActions.push(new DeferredRendererDeletion(this,param1));
         }
         else
         {
            _loc2_ = int(this.renderers.indexOf(param1));
            if(_loc2_ >= 0)
            {
               this.renderers[_loc2_] = this.renderers[--this.size];
               this.renderers[this.size] = null;
            }
         }
      }
      
      public function render(param1:int, param2:int) : void
      {
         var _loc4_:Renderer = null;
         this.rendering = true;
         var _loc3_:int = 0;
         while(_loc3_ < this.size)
         {
            _loc4_ = this.renderers[_loc3_];
            _loc4_.render(param1,param2);
            _loc3_++;
         }
         this.rendering = false;
         this.executeDeferredActions();
      }
      
      private function executeDeferredActions() : void
      {
         var _loc1_:DeferredAction = null;
         while(true)
         {
            _loc1_ = this.deferredActions.pop();
            if(_loc1_ == null)
            {
               break;
            }
            _loc1_.execute();
         }
      }
   }
}


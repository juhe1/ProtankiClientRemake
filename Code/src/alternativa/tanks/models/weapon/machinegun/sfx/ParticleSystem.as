package alternativa.tanks.models.weapon.machinegun.sfx
{
   import alternativa.tanks.battle.BattleService;
   import flash.utils.Dictionary;
   
   public class ParticleSystem
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private var particles:Dictionary = new Dictionary();
      
      private var particleClass:Class;
      
      private var emit:Boolean;
      
      private var emitInterval:Number = 0;
      
      private var time:Number = 0;
      
      private var count:int;
      
      private var maxCount:int;
      
      public function ParticleSystem(param1:Class, param2:Number, param3:int)
      {
         super();
         this.particleClass = param1;
         this.emitInterval = param2;
         this.maxCount = param3;
      }
      
      public function start() : void
      {
         this.emit = true;
      }
      
      public function stop() : void
      {
         this.emit = false;
      }
      
      public function update(param1:Number) : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:Particle = null;
         if(this.emit)
         {
            this.time += param1;
            if(this.time >= this.emitInterval)
            {
               this.time = 0;
               if(this.count < this.maxCount)
               {
                  this.createParticle();
               }
            }
         }
         for(_loc2_ in this.particles)
         {
            _loc3_ = _loc2_;
            this.onUpdateParticle(_loc3_,param1);
            if(!_loc3_.alive)
            {
               this.deleteParticle(_loc3_);
            }
         }
         return this.emit || this.count > 0;
      }
      
      public function clear() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:Particle = null;
         for(_loc1_ in this.particles)
         {
            _loc2_ = _loc1_;
            this.deleteParticle(_loc2_);
         }
         this.stop();
      }
      
      protected function onCreateParticle(param1:Particle) : void
      {
      }
      
      protected function onUpdateParticle(param1:Particle, param2:Number) : void
      {
      }
      
      protected function onDeleteParticle(param1:Particle) : void
      {
      }
      
      private function createParticle() : void
      {
         var _loc1_:Particle = Particle(battleService.getObjectPool().getObject(this.particleClass));
         _loc1_.alive = true;
         this.onCreateParticle(_loc1_);
         this.particles[_loc1_] = true;
         ++this.count;
      }
      
      private function deleteParticle(param1:Particle) : void
      {
         this.onDeleteParticle(param1);
         delete this.particles[param1];
         param1.recycle();
         --this.count;
      }
   }
}


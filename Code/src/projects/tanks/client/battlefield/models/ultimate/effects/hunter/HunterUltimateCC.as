package projects.tanks.client.battlefield.models.ultimate.effects.hunter
{
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.resource.types.TextureResource;
   
   public class HunterUltimateCC
   {
      
      private var _effectStartSound:SoundResource;
      
      private var _electro:TextureResource;
      
      private var _energy:TextureResource;
      
      private var _lightning:TextureResource;
      
      public function HunterUltimateCC(param1:SoundResource = null, param2:TextureResource = null, param3:TextureResource = null, param4:TextureResource = null)
      {
         super();
         this._effectStartSound = param1;
         this._electro = param2;
         this._energy = param3;
         this._lightning = param4;
      }
      
      public function get effectStartSound() : SoundResource
      {
         return this._effectStartSound;
      }
      
      public function set effectStartSound(param1:SoundResource) : void
      {
         this._effectStartSound = param1;
      }
      
      public function get electro() : TextureResource
      {
         return this._electro;
      }
      
      public function set electro(param1:TextureResource) : void
      {
         this._electro = param1;
      }
      
      public function get energy() : TextureResource
      {
         return this._energy;
      }
      
      public function set energy(param1:TextureResource) : void
      {
         this._energy = param1;
      }
      
      public function get lightning() : TextureResource
      {
         return this._lightning;
      }
      
      public function set lightning(param1:TextureResource) : void
      {
         this._lightning = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "HunterUltimateCC [";
         _loc1_ += "effectStartSound = " + this.effectStartSound + " ";
         _loc1_ += "electro = " + this.electro + " ";
         _loc1_ += "energy = " + this.energy + " ";
         _loc1_ += "lightning = " + this.lightning + " ";
         return _loc1_ + "]";
      }
   }
}


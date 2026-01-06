package projects.tanks.client.battlefield.models.map
{
   import platform.client.fp10.core.resource.types.MultiframeTextureResource;
   
   public class DustParams
   {
      
      private var _alpha:Number;
      
      private var _density:Number;
      
      private var _dustFarDistance:Number;
      
      private var _dustNearDistance:Number;
      
      private var _dustParticle:MultiframeTextureResource;
      
      private var _dustSize:Number;
      
      public function DustParams(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:MultiframeTextureResource = null, param6:Number = 0)
      {
         super();
         this._alpha = param1;
         this._density = param2;
         this._dustFarDistance = param3;
         this._dustNearDistance = param4;
         this._dustParticle = param5;
         this._dustSize = param6;
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         this._alpha = param1;
      }
      
      public function get density() : Number
      {
         return this._density;
      }
      
      public function set density(param1:Number) : void
      {
         this._density = param1;
      }
      
      public function get dustFarDistance() : Number
      {
         return this._dustFarDistance;
      }
      
      public function set dustFarDistance(param1:Number) : void
      {
         this._dustFarDistance = param1;
      }
      
      public function get dustNearDistance() : Number
      {
         return this._dustNearDistance;
      }
      
      public function set dustNearDistance(param1:Number) : void
      {
         this._dustNearDistance = param1;
      }
      
      public function get dustParticle() : MultiframeTextureResource
      {
         return this._dustParticle;
      }
      
      public function set dustParticle(param1:MultiframeTextureResource) : void
      {
         this._dustParticle = param1;
      }
      
      public function get dustSize() : Number
      {
         return this._dustSize;
      }
      
      public function set dustSize(param1:Number) : void
      {
         this._dustSize = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "DustParams [";
         _loc1_ += "alpha = " + this.alpha + " ";
         _loc1_ += "density = " + this.density + " ";
         _loc1_ += "dustFarDistance = " + this.dustFarDistance + " ";
         _loc1_ += "dustNearDistance = " + this.dustNearDistance + " ";
         _loc1_ += "dustParticle = " + this.dustParticle + " ";
         _loc1_ += "dustSize = " + this.dustSize + " ";
         return _loc1_ + "]";
      }
   }
}


package projects.tanks.client.entrance.model.entrance.externalentrance
{
   public class ExternalEntranceCC
   {
      
      private var _socialNetworkParams:Vector.<SocialNetworkEntranceParams>;
      
      public function ExternalEntranceCC(param1:Vector.<SocialNetworkEntranceParams> = null)
      {
         super();
         this._socialNetworkParams = param1;
      }
      
      public function get socialNetworkParams() : Vector.<SocialNetworkEntranceParams>
      {
         return this._socialNetworkParams;
      }
      
      public function set socialNetworkParams(param1:Vector.<SocialNetworkEntranceParams>) : void
      {
         this._socialNetworkParams = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ExternalEntranceCC [";
         _loc1_ += "socialNetworkParams = " + this.socialNetworkParams + " ";
         return _loc1_ + "]";
      }
   }
}


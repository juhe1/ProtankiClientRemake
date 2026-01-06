package projects.tanks.client.battlefield.models.user.bossstate
{
   import alternativa.types.Long;
   
   public class BossStateCC
   {
      
      private var _enabled:Boolean;
      
      private var _hullId:Long;
      
      private var _local:Boolean;
      
      private var _role:BossRelationRole;
      
      private var _weaponId:Long;
      
      public function BossStateCC(param1:Boolean = false, param2:Long = null, param3:Boolean = false, param4:BossRelationRole = null, param5:Long = null)
      {
         super();
         this._enabled = param1;
         this._hullId = param2;
         this._local = param3;
         this._role = param4;
         this._weaponId = param5;
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
      }
      
      public function get hullId() : Long
      {
         return this._hullId;
      }
      
      public function set hullId(param1:Long) : void
      {
         this._hullId = param1;
      }
      
      public function get local() : Boolean
      {
         return this._local;
      }
      
      public function set local(param1:Boolean) : void
      {
         this._local = param1;
      }
      
      public function get role() : BossRelationRole
      {
         return this._role;
      }
      
      public function set role(param1:BossRelationRole) : void
      {
         this._role = param1;
      }
      
      public function get weaponId() : Long
      {
         return this._weaponId;
      }
      
      public function set weaponId(param1:Long) : void
      {
         this._weaponId = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BossStateCC [";
         _loc1_ += "enabled = " + this.enabled + " ";
         _loc1_ += "hullId = " + this.hullId + " ";
         _loc1_ += "local = " + this.local + " ";
         _loc1_ += "role = " + this.role + " ";
         _loc1_ += "weaponId = " + this.weaponId + " ";
         return _loc1_ + "]";
      }
   }
}


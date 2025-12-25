package projects.tanks.client.battlefield.models.bonus.battle
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import platform.client.fp10.core.type.IGameObject;
   
   public class BonusSpawnData
   {
      private var newname_7579__END:IGameObject;
      
      private var newname_7580__END:String;
      
      private var newname_7581__END:int;
      
      private var newname_7582__END:Vector3d;
      
      public function BonusSpawnData(param1:IGameObject = null, param2:String = null, param3:int = 0, param4:Vector3d = null)
      {
         super();
         this.newname_7579__END = param1;
         this.newname_7580__END = param2;
         this.newname_7581__END = param3;
         this.newname_7582__END = param4;
      }
      
      public function get battleBonusObject() : IGameObject
      {
         return this.newname_7579__END;
      }
      
      public function set battleBonusObject(param1:IGameObject) : void
      {
         this.newname_7579__END = param1;
      }
      
      public function get bonusId() : String
      {
         return this.newname_7580__END;
      }
      
      public function set bonusId(param1:String) : void
      {
         this.newname_7580__END = param1;
      }
      
      public function get lifeTime() : int
      {
         return this.newname_7581__END;
      }
      
      public function set lifeTime(param1:int) : void
      {
         this.newname_7581__END = param1;
      }
      
      public function get spawnPosition() : Vector3d
      {
         return this.newname_7582__END;
      }
      
      public function set spawnPosition(param1:Vector3d) : void
      {
         this.newname_7582__END = param1;
      }
      
      public function toString() : String
      {
         return "";
      }
   }
}


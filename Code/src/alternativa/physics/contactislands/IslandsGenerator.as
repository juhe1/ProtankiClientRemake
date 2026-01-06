package alternativa.physics.contactislands
{
   import alternativa.physics.BodyContact;
   import alternativa.physics.PhysicsScene;
   import alternativa.physics.QuickUnionFind;
   import alternativa.utils.clearDictionary;
   import flash.utils.Dictionary;
   
   public class IslandsGenerator
   {
      
      public const contactIslands:Vector.<ContactIsland> = new Vector.<ContactIsland>();
      
      private const contactIslandsByRootId:Dictionary = new Dictionary();
      
      private const uf:QuickUnionFind = new QuickUnionFind();
      
      private var physicsScene:PhysicsScene;
      
      public function IslandsGenerator(param1:PhysicsScene)
      {
         super();
         this.physicsScene = param1;
      }
      
      public function generate(param1:Vector.<BodyContact>, param2:int) : void
      {
         this.createUnions(param1,param2);
         this.createIslands(param1);
      }
      
      private function createUnions(param1:Vector.<BodyContact>, param2:int) : void
      {
         var _loc5_:BodyContact = null;
         this.uf.init(param2);
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            if(_loc5_.body1.movable && _loc5_.body2.movable)
            {
               this.uf.union(_loc5_.body1.id,_loc5_.body2.id);
            }
            _loc4_++;
         }
      }
      
      private function createIslands(param1:Vector.<BodyContact>) : void
      {
         var _loc6_:BodyContact = null;
         var _loc7_:int = 0;
         var _loc8_:ContactIsland = null;
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = param1[_loc3_];
            if(_loc6_.body1.movable)
            {
               _loc7_ = this.uf.root(_loc6_.body1.id);
            }
            else
            {
               _loc7_ = this.uf.root(_loc6_.body2.id);
            }
            _loc8_ = this.contactIslandsByRootId[_loc7_];
            if(_loc8_ == null)
            {
               _loc8_ = ContactIsland.create();
               this.contactIslands[this.contactIslands.length] = _loc8_;
               this.contactIslandsByRootId[_loc7_] = _loc8_;
            }
            _loc8_.bodyContacts[_loc8_.bodyContacts.length] = _loc6_;
            _loc3_++;
         }
         var _loc4_:int = int(this.contactIslands.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc8_ = this.contactIslands[_loc5_];
            _loc8_.init(this.physicsScene);
            _loc5_++;
         }
         clearDictionary(this.contactIslandsByRootId);
      }
      
      public function clear() : void
      {
         var _loc3_:ContactIsland = null;
         var _loc1_:int = int(this.contactIslands.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.contactIslands[_loc2_];
            _loc3_.dispose();
            _loc2_++;
         }
         this.contactIslands.length = 0;
      }
   }
}


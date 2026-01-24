package alternativa.tanks.models.tank.resistance
{
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.models.tank.LocalWeaponController;
   import alternativa.tanks.models.tank.bosstate.IBossState;
   import alternativa.tanks.services.tankregistry.TankUsersRegistry;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;
   import projects.tanks.client.battlefield.models.user.resistance.ITankResistancesModelBase;
   import projects.tanks.client.battlefield.models.user.resistance.TankResistance;
   import projects.tanks.client.battlefield.models.user.resistance.TankResistancesModelBase;
   import projects.tanks.client.garage.models.item.properties.ItemProperty;
   
   [ModelInfo]
   public class TankResistancesModel extends TankResistancesModelBase implements ITankResistancesModelBase, TankResistances, ObjectLoadPostListener
   {
      
      [Inject] // added
      public static var usersRegistry:TankUsersRegistry;
      
      public function TankResistancesModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoadedPost() : void
      {
         var _loc1_:IGameObject = null;
         if(Boolean(usersRegistry.existLocalUser()) && usersRegistry.getLocalUser() == object)
         {
            for each(_loc1_ in usersRegistry.getUsers())
            {
               if(_loc1_ != object)
               {
                  this.setResistance(_loc1_,true);
               }
            }
         }
         else
         {
            this.setResistance(object,true);
         }
      }
      
      public function getResistance(param1:Boolean) : int
      {
         if(!usersRegistry.existLocalUser() || usersRegistry.getLocalUser() == object)
         {
            return 0;
         }
         var _loc2_:IGameObject = usersRegistry.getLocalUser();
         if(this.isBoss(_loc2_))
         {
            return 0;
         }
         var _loc3_:ITankModel = ITankModel(_loc2_.adapt(ITankModel));
         var _loc4_:Dictionary = Dictionary(getData(Dictionary));
         if(_loc4_ == null || param1)
         {
            _loc4_ = this.createResistanceDictionary();
            putData(Dictionary,_loc4_);
         }
         if(ItemProperty.ALL_RESISTANCE in _loc4_)
         {
            return _loc4_[ItemProperty.ALL_RESISTANCE];
         }
         var _loc5_:LocalWeaponController = LocalWeaponController(_loc3_.getWeaponController());
         var _loc6_:ItemProperty = _loc5_.getResistanceProperty();
         if(_loc6_ in _loc4_)
         {
            return _loc4_[_loc6_];
         }
         return 0;
      }
      
      private function isBoss(param1:IGameObject) : Boolean
      {
         return IBossState(param1.adapt(IBossState)).role() == BossRelationRole.BOSS;
      }
      
      public function getResistances() : Vector.<TankResistance>
      {
         return getInitParam().resistances;
      }
      
      private function createResistanceDictionary() : Dictionary
      {
         var _loc2_:TankResistance = null;
         var _loc1_:Dictionary = new Dictionary();
         for each(_loc2_ in getInitParam().resistances)
         {
            _loc1_[_loc2_.resistanceProperty] = _loc2_.resistanceInPercent;
         }
         return _loc1_;
      }
      
      private function setResistance(param1:IGameObject, param2:Boolean) : void
      {
         var _loc3_:int = int(TankResistances(param1.adapt(TankResistances)).getResistance(param2));
         ITankModel(param1.adapt(ITankModel)).getTitle().setResistance(_loc3_);
      }
      
      public function updateOthersResistances() : void
      {
         var _loc1_:IGameObject = null;
         for each(_loc1_ in usersRegistry.getUsers())
         {
            if(_loc1_ != object)
            {
               this.setResistance(_loc1_,true);
            }
         }
      }
   }
}


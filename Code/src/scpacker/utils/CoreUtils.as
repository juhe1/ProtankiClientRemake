package scpacker.utils
{
   import alternativa.types.Long;
   import alternativa.osgi.OSGi;
   import platform.client.fp10.core.model.IObjectLoadListener;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.registry.GameTypeRegistry;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.IGameClass;
   import platform.client.fp10.core.type.impl.GameClass;
   import platform.client.fp10.core.type.impl.Space;
   import platform.client.fp10.core.type.ISpace;
   
   public class CoreUtils
   {
      private static var gameTypeRegistry:GameTypeRegistry;
      
      private static var spaceRegistry:SpaceRegistry;
      
      public function CoreUtils()
      {
         super();
      }
      
      public static function init() : void
      {
         gameTypeRegistry = GameTypeRegistry(OSGi.getInstance().getService(GameTypeRegistry));
         spaceRegistry = SpaceRegistry(OSGi.getInstance().getService(SpaceRegistry));
         CoreUtils.registerGameClass(Long.ZERO,new Vector.<Long>(0));
         CoreUtils.registerGameClass(LongUtils.strToId("battle_bonus"),new <Long>[Long.getLong(2087671478,1672369054),Long.getLong(1742678945,1383804656)]);
      }
      
      public static function registerGameClass(param1:Long, param2:Vector.<Long>) : GameClass
      {
         return gameTypeRegistry.createClass(param1,param2);
      }
      
      public static function destroyGameClass(param1:Long) : void
      {
         gameTypeRegistry.destroyClass(param1);
      }
      
      public static function getClass(param1:Long) : IGameClass
      {
         return gameTypeRegistry.getClass(param1);
      }
      
      public static function createObject(param1:Long, param2:Long, param3:Long) : IGameObject
      {
         var _loc5_:ISpace = spaceRegistry.getSpace(param3);
         if(_loc5_ == null)
         {
            _loc5_ = new Space(param3,null,null,false);
            spaceRegistry.addSpace(_loc5_);
         }
         if(_loc5_.rootObject && _loc5_.rootObject.id == param1)
         {
            _loc5_.destroyObject(param1);
         }
         var _loc4_:IGameClass = gameTypeRegistry.getClass(param2);
         if(_loc4_ == null)
         {
            throw new Error("Class not found exception class=" + param2 + ", object=" + param1);
         }
         return _loc5_.createObject(param1,_loc4_,"");
      }
      
      public static function getObject(param1:Long, param2:Long, param3:Long) : IGameObject
      {
         var _loc5_:ISpace = spaceRegistry.getSpace(param3);
         var _loc4_:IGameClass = gameTypeRegistry.getClass(param2);
         if(_loc4_ == null)
         {
            throw new Error("Class not found exception class=" + param2 + ", object=" + param1);
         }
         return _loc5_.getObject(param1);
      }
      
      public static function destroyObject(param1:Long) : void
      {
         var _loc2_:ISpace = spaceRegistry.currentSpace;
         _loc2_.destroyObject(param1);
      }
      
      public static function notifyObjectLoadListeners(param1:IGameObject) : void
      {
         OSGi.clientLog.log("CoreUtils","Loaded objectId=" + param1.id);
         var _loc2_:IObjectLoadListener = IObjectLoadListener(param1.event(IObjectLoadListener));
         _loc2_.objectLoaded();
         ObjectLoadListener(param1.event(ObjectLoadListener)).objectLoaded();
         _loc2_.objectLoadedPost();
         ObjectLoadPostListener(param1.event(ObjectLoadPostListener)).objectLoadedPost();
         Space(spaceRegistry.currentSpace).modelsDataReady(param1);
      }
      
      public static function unloadSpace(param1:Long) : void
      {
         var _loc2_:ISpace = spaceRegistry.getSpace(param1);
         for each(var _loc3_ in _loc2_.objects)
         {
            _loc2_.destroyObject(_loc3_.id);
         }
      }
      
      public static function addModelToGameClass(gameObject:IGameObject, modelId:Long):void
      {
         if(gameObject.gameClass.models.indexOf(modelId) == -1)
         {
            gameObject.gameClass.models.push(modelId);
         }
      }
   }
}


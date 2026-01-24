package platform.client.fp10.core
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.command.CommandService;
   import alternativa.osgi.service.command.FormattedOutput;
   import alternativa.types.Long;
   import flash.system.System;
   import flash.utils.getQualifiedClassName;
   import platform.client.fp10.core.registry.GameTypeRegistry;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.resource.Resource;
   import platform.client.fp10.core.service.transport.ITransportService;
   import platform.client.fp10.core.type.IGameClass;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.ISpace;
   
   public class CoreCommands
   {
      
      [Inject] // added
      public static var gameTypeRegistry:GameTypeRegistry;
      
      [Inject] // added
      public static var modelRegister:ModelRegistry;
      
      [Inject] // added
      public static var spaceRegistry:SpaceRegistry;
      
      [Inject] // added
      public static var resourceRegistry:ResourceRegistry;
      
      [Inject] // added
      public static var commandService:CommandService;
      
      [Inject] // added
      public static var transportService:ITransportService;
      
      private var osgi:OSGi;
      
      public function CoreCommands()
      {
         super();
         this.osgi = OSGi.getInstance();
         commandService.registerCommand("core","objects","Список загруженных объектов",[],this.cmdObjectsList);
         commandService.registerCommand("core","resource","Список ресурсов",[],this.cmdResourcesList);
         commandService.registerCommand("core","spaces","Список спейсов",[],this.cmdSpacesList);
         commandService.registerCommand("system","gc","Вызвать сборщик мусора (debug only)",[],this.cmdSystemGc);
      }
      
      private function cmdSystemGc(param1:FormattedOutput) : void
      {
         System.gc();
      }
      
      private function cmdSpacesList(param1:FormattedOutput) : void
      {
         var _loc3_:ISpace = null;
         var _loc2_:Vector.<ISpace> = SpaceRegistry(this.osgi.getService(SpaceRegistry)).spaces;
         for each(_loc3_ in _loc2_)
         {
            param1.addText("space id: " + (_loc3_.id == null ? "null" : _loc3_.id.toString()));
         }
      }
      
      private function cmdResourcesList(param1:FormattedOutput) : void
      {
         var _loc4_:Resource = null;
         var _loc2_:Vector.<Resource> = resourceRegistry.resources;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            param1.addText(_loc4_.toString());
            _loc3_++;
         }
      }
      
      private function cmdObjectsList(param1:FormattedOutput) : void
      {
         var _loc4_:ISpace = null;
         var _loc5_:Vector.<IGameObject> = null;
         var _loc6_:IGameObject = null;
         var _loc7_:IGameClass = null;
         var _loc8_:Vector.<Long> = null;
         var _loc9_:int = 0;
         var _loc2_:Vector.<ISpace> = spaceRegistry.spaces;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            param1.addText("space id: " + _loc4_.id);
            _loc5_ = _loc4_.objects;
            for each(_loc6_ in _loc5_)
            {
               param1.addText("  object id: " + _loc6_.id);
               _loc7_ = _loc6_.gameClass;
               if(_loc7_ != null)
               {
                  param1.addText("    class id: " + _loc7_.id);
                  _loc8_ = _loc6_.gameClass.models;
                  if(_loc8_.length > 0)
                  {
                     param1.addText("    models:");
                     _loc9_ = 0;
                     while(_loc9_ < _loc8_.length)
                     {
                        param1.addText("      " + this.getClassName(modelRegister.getModel(_loc8_[_loc9_])) + " [" + _loc8_[_loc9_] + "]");
                        _loc9_++;
                     }
                  }
               }
               else
               {
                  param1.addText("    class id: null");
               }
            }
            _loc3_++;
         }
      }
      
      private function getClassName(param1:Object) : String
      {
         var _loc2_:String = getQualifiedClassName(param1);
         var _loc3_:int = int(_loc2_.indexOf("::"));
         if(_loc3_ > -1)
         {
            return _loc2_.substr(_loc3_ + 2);
         }
         return _loc2_;
      }
   }
}


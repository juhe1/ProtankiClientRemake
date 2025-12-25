package scpacker.resource
{
   import newname_3200__END.ResourceImageParams;
   import alternativa.types.Long;
   import platform.core.general.resource.types.imageframe.ResourceImageFrameParams;
   import alternativa.osgi.OSGi;
   import platform.client.core.general.spaces.loading.dispatcher.types.ObjectsDependencies;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.resource.Resource;
   import platform.client.fp10.core.resource.ResourceInfo;
   import platform.client.fp10.core.type.impl.GameObject;
   import platform.client.fp10.core.model.impl.Model;
   
   public class ResourcesLoader
   {
      private var newname_122__END:ResourceRegistry = OSGi.getInstance().getService(ResourceRegistry) as ResourceRegistry;
      
      public function ResourcesLoader()
      {
         super();
      }
      
      public function getResourceDependencies(param1:String, param2:int) : ObjectsDependencies
      {
         var _loc4_:* = new GameObject(Long.getLong(1,1),null,"ResourceObject",null);
         Model.objects[Model.objects.length] = Model.currentObject;
         Model.currentObject = _loc4_;
         return new ObjectsDependencies(param2,this.getResources(param1));
      }
      
      private function getResources(param1:String) : Vector.<Resource>
      {
         var _loc4_:Resource = null;
         var _loc6_:Boolean = false;
         var _loc3_:Object = JSON.parse(param1);
         var _loc5_:Vector.<Resource> = new Vector.<Resource>();
         for each(var _loc2_ in _loc3_.resources)
         {
            var _loc7_:* = _loc4_ = this.createResource(this.parseResourceInfo(_loc2_));
            _loc6_ = !_loc7_.resourceInfo.isLazy && _loc4_.status == null;
            if(_loc6_)
            {
               _loc5_.push(_loc4_);
            }
         }
         return _loc5_;
      }
      
      private function createResource(param1:ResourceInfo) : Resource
      {
         var _loc3_:Resource = null;
         var _loc2_:Long = param1.id;
         if(this.newname_122__END.isRegistered(_loc2_))
         {
            return this.newname_122__END.getResource(_loc2_);
         }
         if(!this.newname_122__END.isTypeClassRegistered(param1.type))
         {
            throw new Error("Unknown resource type");
         }
         var _loc4_:Class = this.newname_122__END.getResourceClass(param1.type);
         if(param1.newname_3167__END == null)
         {
            _loc3_ = Resource(new _loc4_(param1));
         }
         else
         {
            _loc3_ = Resource(new _loc4_(param1,param1.newname_3167__END));
         }
         this.newname_122__END.registerResource(_loc3_);
         return _loc3_;
      }
      
      private function parseResourceInfo(param1:*) : ResourceInfo
      {
         var _loc7_:Object = null;
         var _loc2_:Long = Long.getLong(param1.idhigh,param1.idlow);
         var _loc8_:int = int(param1.type);
         var _loc5_:Long = Long.getLong(param1.versionhigh,param1.versionlow);
         var _loc4_:Boolean = Boolean(param1.lazy);
         var _loc6_:Vector.<String> = new Vector.<String>();
         for each(var _loc3_ in param1.fileNames)
         {
            _loc6_.push(_loc3_);
         }
         if(_loc8_ == 10)
         {
            _loc7_ = new ResourceImageParams(param1.alpha);
         }
         else if(_loc8_ == 11)
         {
            _loc7_ = new ResourceImageFrameParams(param1.fps,param1.height,param1.weight,param1.numFrames);
         }
         return new ResourceInfo(_loc8_,_loc2_,_loc5_,_loc4_,_loc7_,_loc6_);
      }
   }
}


package platform.client.fp10.core.resource
{
   import alternativa.types.Long;
   
   public class ResourceInfo
   {
      public var type:int;
      
      public var id:Long;
      
      public var version:Long;
      
      public var isLazy:Boolean;

      public var newname_3167__END:Object;

      public var newname_3168__END:Vector.<String>;
      
      public function ResourceInfo(param1:int, param2:Long, param3:Long, param4:Boolean, param5:Object, param6:Vector.<String> = null)
      {
         super();
         this.type = param1;
         this.id = param2;
         this.version = param3;
         this.isLazy = param4;
         this.newname_3167__END = param5;
         this.newname_3168__END = param6;
      }
   }
}


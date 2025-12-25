package alternativa.osgi.catalogs
{
   import alternativa.osgi.service.IServiceRegisterListener;
   import flash.utils.Dictionary;
   
   public class ServiceListenersCatalog
   {
       
      
      private var dictionary:Dictionary;
      
      private var listeners:Vector.<IServiceRegisterListener>;
      
      public function ServiceListenersCatalog()
      {
         this.dictionary = new Dictionary();
         this.listeners = new Vector.<IServiceRegisterListener>();
         super();
      }
      
      public function addListener(listener:IServiceRegisterListener, filter:String) : void
      {
         var filters:Vector.<String> = this.dictionary[listener];
         if(filters == null)
         {
            filters = new Vector.<String>();
            this.dictionary[listener] = filters;
         }
         if(filters.indexOf(filter) == -1)
         {
            filters.push(filter);
         }
         if(this.listeners.indexOf(listener) == -1)
         {
            this.listeners.push(listener);
         }
      }
      
      public function removeListener(listener:IServiceRegisterListener, filter:String) : void
      {
         var filters:Vector.<String> = this.dictionary[listener];
         var index:Number = filters.indexOf(filter);
         if(index >= 0)
         {
            filters.splice(index,1);
         }
         if(filters.length == 0)
         {
            delete this.dictionary[listener];
            index = this.listeners.indexOf(listener);
            this.listeners.splice(index,1);
         }
      }
      
      public function getListeners() : Vector.<IServiceRegisterListener>
      {
         return this.listeners.concat();
      }
      
      public function getFilters(listener:IServiceRegisterListener) : Vector.<String>
      {
         return this.dictionary[listener];
      }
   }
}

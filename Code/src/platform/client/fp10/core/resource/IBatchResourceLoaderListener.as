package platform.client.fp10.core.resource
{
   import platform.client.fp10.core.resource.validation.IValidationHash;
   
   public interface IBatchResourceLoaderListener
   {
      
      function onBatchLoadingComplete(param1:IValidationHash) : void;
      
      function onResourceLoadingStart(param1:Resource) : void;
      
      function onResourceLoadingComplete(param1:Resource) : void;
   }
}


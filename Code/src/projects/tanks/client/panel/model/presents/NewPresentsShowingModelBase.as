package projects.tanks.client.panel.model.presents
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.panel.model.presents.NewPresentsShowingModelServer;
   
   public class NewPresentsShowingModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1012007416,-1351622809);
      
      protected var server:NewPresentsShowingModelServer;
      
      public function NewPresentsShowingModelBase()
      {
         super();
         this.server = new NewPresentsShowingModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}


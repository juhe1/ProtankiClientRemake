package projects.tanks.client.tanksservices.model.clientrestarttime
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class OnceADayActionModelBase extends Model
   {

      protected var server:OnceADayActionModelServer;

      public static const modelId:Long = Long.getLong(121239387,-1441001284);

      public function OnceADayActionModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new OnceADayActionModelServer(IModel(this));
      }

      protected function getInitParam() : OnceADayActionCC
      {
         return OnceADayActionCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}

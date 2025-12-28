package projects.tanks.client.panel.model.panel
{
   import alternativa.osgi.OSGi;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class PanelModelBase extends Model
   {
      
      private var client:IPanelModelBase = IPanelModelBase(this);
      
      static public var modelId:Long = Long.getLong(469211470,2012932912);
      
      public function PanelModelBase()
      {
         super();
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}


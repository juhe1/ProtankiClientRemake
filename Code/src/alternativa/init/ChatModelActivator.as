package alternativa.init
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.tanks.gui.communication.tabs.chat.ChatTabView;
   import alternativa.tanks.gui.communication.tabs.chat.IChatTabView;
   import alternativa.tanks.services.NewsService;
   import alternativa.tanks.services.NewsServiceImpl;
   import alternativa.tanks.gui.communication.tabs.clanchat.IClanChatView;
   import alternativa.tanks.gui.communication.tabs.clanchat.ClanChatTab;
   import alternativa.tanks.gui.communication.tabs.clanchat.ClanChatView;
   
   public class ChatModelActivator implements IBundleActivator
   {
      
      public function ChatModelActivator()
      {
         super();
      }
      
      public function start(param1:OSGi) : void
      {
         param1.registerService(NewsService,new NewsServiceImpl());
         param1.registerService(IChatTabView,new ChatTabView());
         param1.registerService(IClanChatView,new ClanChatView());
      }
      
      public function stop(param1:OSGi) : void
      {
      }
   }
}


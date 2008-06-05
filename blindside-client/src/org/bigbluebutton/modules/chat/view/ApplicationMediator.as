package org.bigbluebutton.modules.chat.view
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.bigbluebutton.main.view.components.MainApplicationShell;

	public class ApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ApplicationMediator";
		
		public function ApplicationMediator(viewComponent:MainApplicationShell)
		{
			super(NAME, viewComponent);
		}
		/**
		 * registers the ChatWindowMediator with the facade 
		 * @param key
		 * 
		 */		
		override public function initializeNotifier(key:String):void{
			super.initializeNotifier(key);
			facade.registerMediator(new ChatWindowMediator(app.chatWindow));
		}
			
		/**
		 * 
		 * @return the main mxml application
		 * 
		 */		
		protected function get app():MainApplicationShell
		{
            return viewComponent as MainApplicationShell;
        }
	}
}
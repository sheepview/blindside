package whiteboard.view
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 * The Application Mediator is the main mediator class of the Whiteboard application
	 * <p>
	 * This class extends the Mediator class of the PureMVC framework 
	 * @author dzgonjan
	 * 
	 */	
	public class ApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ApplicationMediator";
		
		/**
		 * The default constructor for the class. It calls the super() constructor, and also creates and
		 * registers the BoardMediator with the application  
		 * @param viewComponent
		 * 
		 */		
		public function ApplicationMediator(viewComponent:BlindsideMVC)
		{
			super(NAME, viewComponent);
			//facade.registerMediator(new BoardMediator(viewComponent.board));
		}
		
		/**
		 * In the PureMVC - Multicore version it is necessary to override the initializeNotifier method
		 * in order to get the facade, instead of getting the facade from the constructor. I don't know why
		 * exactely this is the case.
		 * @param key
		 * 
		 */		
		override public function initializeNotifier(key:String):void{
			super.initializeNotifier(key);
			facade.registerMediator(new BoardMediator(app.whiteboard));
		}
		
		/**
		 * Returns the application component (whiteboard.mxml) 
		 * @return 
		 * 
		 */		
		protected function get app():BlindsideMVC
		{
            return viewComponent as BlindsideMVC;
        }

	}
}
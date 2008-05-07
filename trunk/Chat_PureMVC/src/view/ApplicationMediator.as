package view
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * The Application Mediator is the main mediator class of the Whiteboard application
	 * <p>
	 * This class extends the Mediator class of the PureMVC framework 
	 * @author snegari
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
		public function ApplicationMediator(viewComponent:Chat_PureMVC)
		{
			
			super(NAME, viewComponent);
			facade.registerMediator(new ChatMediator(viewComponent.chat));
		}
		
		/**
		 * Returns the application component (whiteboard.mxml) 
		 * @return 
		 * 
		 */		
		protected function get app():Chat_PureMVC
		{
            return viewComponent as Chat_PureMVC;
        }

	}
}
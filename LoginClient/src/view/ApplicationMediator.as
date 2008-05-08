package view
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ApplicationMediator";
		
		/**
		 * The default constructor for the class. It calls the super() constructor, and also creates and
		 * registers the LogInMediator with the application  
		 * @param viewComponent
		 * 
		 */		
		public function ApplicationMediator(viewComponent:LoginClient)
		{
			super(NAME, viewComponent);
			facade.registerMediator(new LogInMediator(viewComponent.login));
		}
		
		/**
		 * Returns the application component (whiteboard.mxml) 
		 * @return 
		 * 
		 */		
		protected function get app():LoginClient
		{
            return viewComponent as LoginClient;
        }

	}
}
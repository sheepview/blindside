package login.view
{
	import login.LogInFacade;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class ApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ApplicationMediator";
		
		/**
		 * The default constructor for the class. It calls the super() constructor, and also creates and
		 * registers the LogInMediator with the application  
		 * @param viewComponent
		 * 
		 */		
		public function ApplicationMediator(viewComponent:BlindsideMVC)
		{
			super(NAME, viewComponent);
			//facade.registerMediator(new LogInMediator(viewComponent.login));
		}
		
		override public function initializeNotifier(key:String):void{
			super.initializeNotifier(key);
			facade.registerMediator(new LogInMediator(app.login));
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
        
        override public function listNotificationInterests():Array{
        	return [
        			LogInFacade.LOGIN_ATTEMPT
        			];
        }
        
        override public function handleNotification(notification:INotification):void{
        	switch(notification.getName()){
        		case LogInFacade.LOGIN_ATTEMPT:
        			if (String(notification.getBody()) == "true"){
        				app.controlBar.enabled = true;
        				app.mdiCanvas.removeChild(app.mdiCanvas.getChildByName("login"));
        			}
        			break;
        	}
        }

	}
}
package login.view
{
	import flash.events.Event;
	
	import login.LogInFacade;
	import login.model.LogInProxy;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 * The LogInMediator is a Mediator class for the Login.mxml GUI component. It listens to important notifications
	 * and initiates a proper coresponding action on the Login.mxml GUI
	 * @author dzgonjan
	 * 
	 */	
	public class LogInMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LogInMediator";
		public static const TRY_LOGIN:String = "tryLogin";
		public static const REGISTER:String = "register";
		
		/**
		 * The constructor. Calls the super constructor and registers the event listener to listen for updates
		 * coming from the LogIn GUI component. 
		 * @param view The LogIn component
		 * 
		 */		
		public function LogInMediator(view:LogIn):void
		{
			super(NAME, view);
			loginMXML.addEventListener(LogInMediator.TRY_LOGIN, tryLogin);
			loginMXML.addEventListener(LogInMediator.REGISTER, tryRegister);
			
		}
		
		/**
		 * Returns the Board GUI component that is registered to this Mediator object 
		 * @return 
		 * 
		 */		
		protected function get loginMXML():LogIn{
			return viewComponent as LogIn;
		}
		
		/**
		 * Returns the Proxy class instance which is comunicating with the red5 server 
		 * @return the LogInProxy
		 * 
		 */		
		public function get proxy():LogInProxy{
			return facade.retrieveProxy(LogInProxy.NAME) as LogInProxy;
		}
		
		/**
		 * Tries to log in the user with the specified user name and password 
		 * @param e
		 * 
		 */		
		public function tryLogin(e:Event):void{
			proxy.attempLogin(loginMXML.txtName.text, loginMXML.txtPass.text);
		}
		
		public function tryRegister(e:Event):void{
			if (loginMXML.txtName.text == ""){
				loginMXML.lblMessage.text = "Please enter a username";
			} else if (loginMXML.txtPass.text == loginMXML.txtConfirm.text){
				proxy.attemptRegister(loginMXML.txtName.text, loginMXML.txtPass.text);	
			} else{
				loginMXML.lblMessage.text = "Passwords do not match";
			}
		}
		
		/**
		 * A list of notifications which this class is interested in 
		 * <p>
		 * This class listens to:
		 * 		- LogInFacade.LOGIN_ATTEMPT
		 * 		- LogInFacade.CALL_FAILED
		 * @return 
		 * 
		 */		
		override public function listNotificationInterests():Array{
			return [
					LogInFacade.LOGIN_ATTEMPT,
					LogInFacade.CALL_FAILED,
					LogInFacade.REGISTER_ATTEMPT,
					LogInFacade.NOT_CONNECTED
				   ];
		}
		
		/**
		 * When a notification is received, this method handles it accordingly 
		 * @param notification
		 * 
		 */		
		override public function handleNotification(notification:INotification):void{
			switch (notification.getName()){
				case LogInFacade.LOGIN_ATTEMPT:
					loginMXML.lblMessage.text = "Login Attempt: " +  notification.getBody();
					//TODO handle login attempt
					break;
				
				case LogInFacade.CALL_FAILED:
					loginMXML.lblMessage.text = "Call Failed: " + notification.getBody();
					//TODO handle call failed
					break;
				
				case LogInFacade.REGISTER_ATTEMPT:
					if (String(notification.getBody()) == "true") loginMXML.lblMessage.text = "Registration Successful";
					else if (String(notification.getBody()) == "false") loginMXML.lblMessage.text = "Registration Error";
					break;
				
				case LogInFacade.NOT_CONNECTED:
					loginMXML.lblMessage.text = "Not connected to server";
			}
		}

	}
}
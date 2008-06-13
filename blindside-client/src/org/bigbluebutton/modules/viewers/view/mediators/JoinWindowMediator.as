package org.bigbluebutton.modules.viewers.view.mediators
{
	import flash.events.Event;
	
	import org.bigbluebutton.common.Constants;
	import org.bigbluebutton.modules.log.LogModule;
	import org.bigbluebutton.modules.log.LogModuleFacade;
	import org.bigbluebutton.modules.viewers.ViewersFacade;
	import org.bigbluebutton.modules.viewers.model.services.SharedObjectConferenceDelegate;
	import org.bigbluebutton.modules.viewers.view.JoinWindow;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class JoinWindowMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "JoinWindowMediator";
		private var v:JoinWindow;
		public static const LOGIN:String = "Attempt Login";

		public function JoinWindowMediator(view:JoinWindow)
		{
			super(NAME);
			v = view;
			view.addEventListener(LOGIN, login);
		}
		
		override public function listNotificationInterests():Array{
			return [];
		}
		
		override public function handleNotification(notification:INotification):void{
			
		}
		
		private function get joinWindow():JoinWindow{
			return viewComponent as JoinWindow;
		}
		
		private function login(e:Event):void{
			var name : String = v.nameField.text; 
		    var room : String = v.confField.text;
		    var password : String = v.passwdField.text
		    
		    if ((name.length < 1) || (room.length < 1) || (password.length < 1)) {
		    	return;
		    } 
			
			var completeHost:String = "rtmp://" + Constants.RED5_HOST + "/conference/" + room;
			sendNotification(ViewersFacade.DEBUG, "connecting: " + completeHost);
			LogModuleFacade.getInstance(LogModule.NAME).debug("Connecting");
			proxy.join(completeHost,name,password,room);
		}
		
		private function get proxy():SharedObjectConferenceDelegate{
			return facade.retrieveProxy(SharedObjectConferenceDelegate.NAME) as SharedObjectConferenceDelegate;
		}
		
		override public function initializeNotifier(key:String):void{
			super.initializeNotifier(key);
			sendNotification(ViewersFacade.DEBUG, "Started JoinWindowMediator");
		}

	}
}
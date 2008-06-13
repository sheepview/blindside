package org.bigbluebutton.modules.viewers.view.mediators
{
	import flash.events.Event;
	
	import org.bigbluebutton.modules.viewers.ViewersFacade;
	import org.bigbluebutton.modules.viewers.model.services.SharedObjectConferenceDelegate;
	import org.bigbluebutton.modules.viewers.view.ViewersWindow;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class ViewersWindowMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ViewersWindowMediator";
		public static const CHANGE_STATUS:String = "Change Status";
		
		public function ViewersWindowMediator(view:ViewersWindow)
		{
			super(NAME);
			view.addEventListener(CHANGE_STATUS, changeStatus);
		}
		
		override public function listNotificationInterests():Array{
			return [];
		}
		
		override public function handleNotification(notification:INotification):void{
			
		}
		
		public function get viewersWindow():ViewersWindow{
			return viewComponent as ViewersWindow;
		}
		
		private function changeStatus(e:Event):void{
		var newStatus : String;
		
			if (viewersWindow.conference.me.status == "raisehand") {
				newStatus = "lowerhand";	
				viewersWindow.toggleTooltip = "Click to raise hand.";
				viewersWindow.toggleIcon = viewersWindow.images.raisehand;
			} else {
				newStatus = "raisehand";
				viewersWindow.toggleTooltip = "Click to lower hand.";
				viewersWindow.toggleIcon = viewersWindow.images.participant;
			}

			proxy.sendNewStatus(newStatus);
		}
		
		private function get proxy():SharedObjectConferenceDelegate{
			return facade.retrieveProxy(SharedObjectConferenceDelegate.NAME) as SharedObjectConferenceDelegate;
		}

	}
}
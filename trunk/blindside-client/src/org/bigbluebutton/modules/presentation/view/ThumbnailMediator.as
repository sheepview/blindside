package org.bigbluebutton.modules.presentation.view
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class ThumbnailMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ThumbnailMediator";
		
		public function ThumbnailMediator(view:Thumbnail)
		{
			super(NAME, view);
		}
		
		public function get thumbnail():Thumbnail{
			return viewComponent as Thumbnail;
		}
		
		override public function listNotificationInterests():Array{
			return [];	
		}
		
		override public function handleNotification(notification:INotification):void{
			
		}

	}
}
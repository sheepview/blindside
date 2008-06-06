package org.red5.samples.publisher.control.handlers 
{		 
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerFacade;
		
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	
	import mx.rpc.IResponder;
	
	import org.red5.samples.publisher.business.*;
	import org.red5.samples.publisher.control.commands.SetupStreamsCommand;
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.vo.IMedia;
	import org.red5.samples.publisher.MediaType;
	import org.red5.samples.publisher.vo.BroadcastMedia;
	import org.red5.samples.publisher.vo.PlayMedia;
	
	public class SetupStreamsCommandHandler implements ICommand
	{		
		private var modelLoc : PublisherModelLocator = PublisherModelLocator.getInstance();	 	
	 		
	 	public function execute( cgEvent : CairngormEvent ) : void
	    { 
			var cmd : SetupStreamsCommand = SetupStreamsCommand( cgEvent );
			
			var media : IMedia  = modelLoc.model.getPlayMedia(cmd.streamName);
			
			if (media == null) {
				media = modelLoc.model.getBroadcastMedia(cmd.streamName);
			}
			media.streamName = cmd.streamName;
			
			if (media.type == MediaType.BROADCAST) {
				var m : BroadcastMedia = media as BroadcastMedia;
				m.broadcastStreamDelegate = new BroadcastStreamDelegate(m);
			} else if (media.type == MediaType.PLAY)
			{
				var p : PlayMedia = media as PlayMedia;
				p.playStreamDelegate = new PlayStreamDelegate(p);
			}
		}		
	}
}
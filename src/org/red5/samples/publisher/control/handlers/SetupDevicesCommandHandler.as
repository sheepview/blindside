package org.red5.samples.publisher.control.handlers 
{		 
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	
	import org.red5.samples.publisher.business.*;
	import org.red5.samples.publisher.control.commands.SetupDevicesCommand;
	import org.red5.samples.publisher.model.*;
	
	public class SetupDevicesCommandHandler implements ICommand
	{
		
		private var model : PublisherModel = PublisherModelLocator.getInstance().model;
	 		 	
	 	public function execute( cgEvent : CairngormEvent ) : void
	    { 
			var event : SetupDevicesCommand = SetupDevicesCommand( cgEvent );
			
			if ( Camera.names.length != 0 ) 
			{
				// Merge options with devices array.
				model.cameraNames = model.cameraNames.concat( Camera.names );
			}
			//
			if ( Microphone.names.length != 0 ) 
			{
				// Merge options with devices array.
				model.microphoneNames = model.microphoneNames.concat( Microphone.names );
			}
		}

	}
}
package org.red5.samples.publisher.view
{
	import mx.containers.Box;
	
	import org.red5.samples.publisher.model.*;
	public class ParticipantClass extends Box
	{
		private var model : ModelLocator = ModelLocator.getInstance();
		
		[Bindable]
		/**
		* 
		*/		
		public var logger : Logger = model.logger;
		
		[Bindable]
		/**
		* 
		*/		
		public var main : Main;
		
		[Bindable]
		/**
		* 
		*/		
		public var navigation : Navigation;
	}
}
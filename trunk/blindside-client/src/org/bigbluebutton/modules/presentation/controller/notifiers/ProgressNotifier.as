package org.bigbluebutton.modules.presentation.controller.notifiers
{
	/**
	 * This is a convinience class so that multiple pieces of data can be sent via a pureMVC notification  
	 * @author dzgonjan
	 * 
	 */	
	public class ProgressNotifier
	{
		private var _totalSlides:Number;
		private var _completedSlides:Number;
		
		public function ProgressNotifier(totalSlides:Number, completedSlides:Number){
			this._totalSlides = totalSlides;
			this._completedSlides = completedSlides;
		}
		
		public function get totalSlides():Number{
			return this._totalSlides;
		}
		
		public function get completedSlides():Number{
			return this._completedSlides;
		}

	}
}
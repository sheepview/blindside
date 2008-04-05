package control.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import control.DrawController;
	
	/**
	 * An event for sending a shape to the DrawDelegate service 
	 * @author Denis
	 * 
	 */	
	public class SendShapeCommand extends CairngormEvent
	{
		public var segment:Array;
		
		/**
		 * The default constructor. Registers this event with the DrawController
		 * @param segment The segment to be passed to the DrawDelegate
		 * 
		 */		
		public function SendShapeCommand(segment:Array)
		{
			super(DrawController.SEND_SHAPE_EVENT);
			this.segment = segment;
		}
		
		/**
		 * Returns the shape stored in this command 
		 * @return the array representation of the shape
		 * 
		 */		
		public function getSegment():Array{
			return this.segment;
		}

	}
}
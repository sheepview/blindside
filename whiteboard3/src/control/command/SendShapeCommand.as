package control.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import control.DrawController;
	
	public class SendShapeCommand extends CairngormEvent
	{
		public var segment:Array;
		
		public function SendShapeCommand(segment:Array)
		{
			super(DrawController.SEND_SHAPE_EVENT);
			this.segment = segment;
		}
		
		public function getSegment():Array{
			return this.segment;
		}

	}
}
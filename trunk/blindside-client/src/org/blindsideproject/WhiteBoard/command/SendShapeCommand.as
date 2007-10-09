package org.blindsideproject.WhiteBoard.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.WhiteBoard.event.SendShapeEvent;
	import org.blindsideproject.WhiteBoard.model.DrawModelLocator;
	import flash.display.Shape;
	
	public class SendShapeCommand implements ICommand
	{
		private var shape:Array;
		
		[Bindable]
		public var model:DrawModelLocator = DrawModelLocator.getInstance();
		
		public function execute(cgEvent:CairngormEvent):void{
			var event:SendShapeEvent = SendShapeEvent(cgEvent);
			
			this.shape = event.shape;
			
			model.draw.drawDelegate.sendShape(this.shape);
		}
	}
}
package org.blindsideproject.WhiteBoard.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.WhiteBoard.model.DrawModelLocator;
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.WhiteBoard.event.ChangeColorEvent;
	
	public class SendColorCommand implements ICommand
	{
		public var color:uint;
		
		[Bindable]
		public var model:DrawModelLocator = DrawModelLocator.getInstance();
		
		public function execute(cgEvent:CairngormEvent):void{
			var event:ChangeColorEvent = ChangeColorEvent(cgEvent);
			
			this.color = event.color;
			
			model.draw.drawDelegate.sendColor(this.color);
		}
	}
}
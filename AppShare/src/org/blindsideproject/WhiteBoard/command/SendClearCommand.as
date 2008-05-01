package org.blindsideproject.WhiteBoard.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.WhiteBoard.model.DrawModelLocator;
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.WhiteBoard.event.SendClearEvent;
	
	public class SendClearCommand implements ICommand
	{
		public var clear:Boolean;
		
		[Bindable]
		public var model:DrawModelLocator = DrawModelLocator.getInstance();
		
		public function execute(cgEvent:CairngormEvent):void{
			var event:SendClearEvent = new SendClearEvent(cgEvent);
			
			this.clear = event.clear;
			
			model.draw.drawDelegate.sendClear(this.clear);
		}
	}
}
package view
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ApplicationMediator";
		
		public function ApplicationMediator(viewComponent:whiteboard)
		{
			viewComponent.txtDebug.text += "\n ApplicationMediator";
			super(NAME, viewComponent);
			facade.registerMediator(new BoardMediator(viewComponent.board));
		}
		
		protected function get app():whiteboard
		{
            return viewComponent as whiteboard;
        }

	}
}
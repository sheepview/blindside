package view
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class BoardMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "BoardMediator";
		
		public function BoardMediator(view:Board):void
		{
			super(NAME, view);
			board.addEventListener(Board.SEND_SHAPE, sendUpdate);
		}
		
		protected function get board():Board{
			return viewComponent as Board;
		}
		
		protected function sendUpdate():void{
			
		}

	}
}
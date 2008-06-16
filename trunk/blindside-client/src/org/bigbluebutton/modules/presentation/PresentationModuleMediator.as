package org.bigbluebutton.modules.presentation
{
	import org.bigbluebutton.common.InputPipe;
	import org.bigbluebutton.common.OutputPipe;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.MainApplicationConstants;
	import org.bigbluebutton.modules.presentation.view.PresentationWindow;
	import org.bigbluebutton.modules.presentation.view.PresentationWindowMediator;
	import org.bigbluebutton.modules.presentation.view.ThumbnailViewMediator;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.PipeListener;
	
	public class PresentationModuleMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "Presentation Module Mediator";
		
		private var outpipe : OutputPipe;
		private var inpipe : InputPipe;
		private var router : Router;
		private var inpipeListener : PipeListener;
		
		private var presentationWindow:PresentationWindow = new PresentationWindow();
		
		public function PresentationModuleMediator(view:PresentationModule)
		{
			super(NAME, view);
			router = view.router;
			inpipe = new InputPipe(PresentationConstants.TO_PRESENTATION_MODULE);
			outpipe = new OutputPipe(PresentationConstants.FROM_PRESENTATION_MODULE);
			inpipeListener = new PipeListener(this, messageReceiver);
			router.registerOutputPipe(outpipe.name, outpipe);
			router.registerInputPipe(inpipe.name, inpipe);
			addWindow();
		}
		
		private function messageReceiver(message : IPipeMessage) : void
		{
			var msg : String = message.getHeader().MSG;
		}
		
		private function addWindow():void{
			var msg:IPipeMessage = new Message(Message.NORMAL);
			msg.setHeader({MSG:MainApplicationConstants.ADD_WINDOW_MSG, SRC: PresentationConstants.FROM_PRESENTATION_MODULE,
   						TO: MainApplicationConstants.TO_MAIN });
   			msg.setPriority(Message.PRIORITY_HIGH);
   			
   			//presentationWindow = (facade.retrieveMediator(PresentationWindowMediator.NAME) as PresentationWindowMediator).presentationWindow;
   			
   			presentationWindow.height = 378;
   			presentationWindow.width = 464;
   			presentationWindow.title = PresentationWindow.TITLE;
   			presentationWindow.showCloseButton = false;
   			msg.setBody(presentationWindow);
   			outpipe.write(msg);
		}
		
		override public function initializeNotifier(key:String):void{
			super.initializeNotifier(key);
			facade.registerMediator(new PresentationWindowMediator(presentationWindow));
   			facade.registerMediator(new ThumbnailViewMediator(presentationWindow.thumbnailView));
		}
		
		protected function get presentationModule():PresentationModule{
			return viewComponent as PresentationModule;
		}

	}
}
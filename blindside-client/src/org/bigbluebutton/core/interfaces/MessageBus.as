package org.bigbluebutton.core.interfaces
{
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Pipe;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.PipeListener;
	
	public class MessageBus extends Junction
	{
		private var outPipe : IPipeFitting = new Pipe();
		
		public function MessageBus()
		{
		}

		public function outputPipe() : IPipeFitting
		{
			return outPipe;
		}
		
		public function setPipeListener(listener : PipeListener) : void
		{
			outPipe.connect(listener);
		}
	}
}
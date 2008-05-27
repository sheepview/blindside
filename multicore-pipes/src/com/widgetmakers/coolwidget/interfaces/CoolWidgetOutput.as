package com.widgetmakers.coolwidget.interfaces
{
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeMerge;

	public class CoolWidgetOutput extends TeeMerge
	{
		public static const NAME : String = "CoolWidgetOutput";
		
		public function CoolWidgetOutput(input1:IPipeFitting=null, input2:IPipeFitting=null)
		{
			super(input1, input2);
		}
		
	}
}
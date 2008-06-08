package org.bigbluebutton.core.interfaces
{
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	
	public interface IRouterAware
	{
		function acceptRouter(router : Router, shell : MainApplicationShell) : void;
	}
}
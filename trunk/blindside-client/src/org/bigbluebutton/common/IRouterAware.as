package org.bigbluebutton.common
{
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	
	public interface IRouterAware
	{
		function acceptRouter(router : Router, shell : MainApplicationShell) : void;
	}
}
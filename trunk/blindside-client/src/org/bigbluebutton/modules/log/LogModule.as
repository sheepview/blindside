/**
* BigBlueButton open source conferencing system - http://www.bigbluebutton.org/
*
* Copyright (c) 2008 by respective authors (see below).
*
* This program is free software; you can redistribute it and/or modify it under the
* terms of the GNU Lesser General Public License as published by the Free Software
* Foundation; either version 2.1 of the License, or (at your option) any later
* version.
*
* This program is distributed in the hope that it will be useful, but WITHOUT ANY
* WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
* PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License along
* with this program; if not, write to the Free Software Foundation, Inc.,
* 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
* 
*/
package org.bigbluebutton.modules.log
{
	import mx.modules.ModuleBase;
	
	import org.bigbluebutton.common.IRouterAware;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	
	/**
	 * 
	 * view component class for LogModuleMediator
	 * 
	 */	
	public class LogModule extends ModuleBase implements IRouterAware
	{
		public static const NAME:String = 'LogModule';
		
		private var facade : LogModuleFacade;		
		private var _router : Router;
		public var mshell : MainApplicationShell;
		/**
		 * Constructor 
		 * Gets an instance of facade
		 */		
		public function LogModule()
		{
			super();
			facade = LogModuleFacade.getInstance(NAME);			
		}
		/**
		 * setting up the router for the shell 
		 * @param router:Router
		 * @param shell:MAinApplicationShell
		 * 
		 */        
		public function acceptRouter(router : Router, shell : MainApplicationShell) : void
		{
			mshell = shell;
			shell.debugLog.text = 'In LogModule';
			_router = router;
			shell.debugLog.text = 'In LogModule 2';
			LogModuleFacade(facade).startup(this);			
			shell.debugLog.text = 'In LogModule 3';
		}
		/**
		 * 
		 * @return Router
		 * 
		 */		
		public function get router() : Router
		{
			return _router;
		}
	}
}
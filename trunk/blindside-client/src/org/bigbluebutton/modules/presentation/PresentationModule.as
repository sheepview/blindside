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
package org.bigbluebutton.modules.presentation
{
	import mx.modules.ModuleBase;
	
	import org.bigbluebutton.common.Constants;
	import org.bigbluebutton.common.IRouterAware;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	import org.bigbluebutton.modules.viewers.ViewersFacade;
	import org.bigbluebutton.modules.viewers.model.business.Conference;
	
	/**
	 * The main class of the Presentation Module
	 * <p>
	 * This class extends the ModuleBase of the Flex Framework 
	 * @author Denis Zgonjanin
	 * 
	 */	
	public class PresentationModule extends ModuleBase implements IRouterAware
	{
		public static const NAME:String = "Presentation Module";
		
		public static const DEFAULT_RED5_URL:String = "rtmp://" + Constants.RED5_HOST;
		public static const DEFAULT_PRES_URL:String = "http://" + Constants.PRESENTATION_HOST;
		
		private var facade:PresentationFacade;
		private var _router:Router;
		public var mshell:MainApplicationShell;
		
		/**
		 * Creates a new Presentation Module 
		 * 
		 */		
		public function PresentationModule()
		{
			super();
			facade = PresentationFacade.getInstance();
		}
		
		/**
		 * Accepts a piping router object through which messages can be sent through different modules 
		 * @param router - the router being passed in
		 * @param shell - the main application shell of the bigbluebutton project
		 * 
		 */		
		public function acceptRouter(router:Router, shell:MainApplicationShell):void{
			mshell = shell;
			_router = router;
			facade.startup(this);
			var conf:Conference = ViewersFacade.getInstance().retrieveMediator(Conference.NAME) as Conference;
			facade.setPresentationApp(conf.me.userid, conf.room, DEFAULT_RED5_URL, DEFAULT_PRES_URL);
			facade.presApp.join();
		}
		
		public function get router():Router{
			return _router;
		}

	}
}
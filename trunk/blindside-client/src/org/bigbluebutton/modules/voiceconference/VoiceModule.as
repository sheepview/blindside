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
package org.bigbluebutton.modules.voiceconference
{
	import mx.modules.ModuleBase;
	
	import org.bigbluebutton.common.IRouterAware;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	
	/**
	 * This is the main class of the Voice Module application. It extends the ModuleBase class of the
	 * Flex Framework
	 * @author Denis Zgonjanin
	 * 
	 */	
	public class VoiceModule extends ModuleBase implements IRouterAware
	{
		public static const NAME:String = "VoiceModule";
		public static const DEFAULT_URI:String = "rtmp://present.carleton.ca/astmeetme/85115"; 
		
		private var facade:VoiceConferenceFacade;
		private var _router:Router;
		private var mshell:MainApplicationShell;
		
		/**
		 * Creates a new VoiceModule 
		 * 
		 */		
		public function VoiceModule()
		{
			super();
			facade = VoiceConferenceFacade.getInstance();
		}
		
		/**
		 * Accept a Router object through which messages can be sent and received 
		 * @param router
		 * @param shell
		 * 
		 */		
		public function acceptRouter(router:Router, shell:MainApplicationShell):void{
			mshell = shell;
			_router = router;
			facade.startup(this, DEFAULT_URI);
			facade.connectToMeetMe();
		}
		
		public function get router():Router{
			return _router;
		}

	}
}
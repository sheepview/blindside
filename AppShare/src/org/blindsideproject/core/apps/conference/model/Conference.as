package org.blindsideproject.core.apps.conference.model
{
	import org.blindsideproject.core.IApplication;
	import mx.collections.ArrayCollection;
	import org.blindsideproject.core.apps.conference.vo.User;
	import org.blindsideproject.core.apps.conference.vo.Properties;
	import org.blindsideproject.core.apps.conference.business.ConferenceDelegate;
	import mx.rpc.IResponder;

	public class Conference
	{
		public var me : User = new User();
		
		[Bindable]
		public var users : ArrayCollection = null;		
		
		[Bindable]
		public var properties : Properties;
		
		private var _connected : Boolean = false;
		
		private var _host : String;
		
		public function Conference(host : String) : void
		{
			_host = host;
			users = new ArrayCollection(new Array());
		}
				
		public function get connected() : Boolean
		{
			return this._connected;
		}
								
		public function get host() : String
		{
			return _host;
		}		
	}
}
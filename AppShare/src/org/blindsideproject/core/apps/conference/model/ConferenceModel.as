package org.blindsideproject.core.apps.conference.model
{
	import org.blindsideproject.core.IApplication;
	import mx.collections.ArrayCollection;
	import org.blindsideproject.core.apps.conference.vo.User;
	import org.blindsideproject.core.apps.conference.vo.Properties;

	import mx.rpc.IResponder;

	public class ConferenceModel implements IApplication
	{
		[Bindable]
		public var me : User = null;
		
		[Bindable]
		public var users : ArrayCollection = null;		
		
		public var properties : Properties;
		
		private var _connected : Boolean = false;
				
		private var _host : String;
		
		public var room : String;
		
		public function ConferenceModel() : void
		{
			me = new User();
			users = new ArrayCollection(new Array());
		}
		
		public function set connected(isConnected : Boolean) : void
		{
			_connected = isConnected;
		}
		
		public function get connected() : Boolean
		{
			return _connected;
		}
					
		public function set host(value : String) : void
		{
			_host = value;
		}
		
		public function get host() : String
		{
			return _host;
		}
		
		public function addUser(newuser : User) : void
		{
			var aUser : User;
			var usersArr : Array = users.source;
			
			// Only add new users to our array
			var isNew : Boolean = true;
			for (var i:int = 0; i < usersArr.length; i++)
			{
				aUser = User(usersArr[i]);
				
				if (aUser.userid == newuser.userid) {
					isNew = false;
				}
			}
				
			if (isNew) {						
				users.addItem(newuser);
			}				
			users.source.sortOn("username", Array.CASEINSENSITIVE);		
			users.refresh();	
		}

		public function removeUser(userid : Number) : void
		{
			var aUser : User;
			var usersArr : Array = users.source;
			
			for (var i:int = 0; i < usersArr.length; i++)
			{
				aUser = User(usersArr[i]);
				
				if (aUser.userid == userid) {
//					usersArr.splice(i,1);
					users.removeItemAt(i);
				}
			}		
			
			users.source.sortOn("username", Array.CASEINSENSITIVE);	
			users.refresh();		
		}

		public function removeAllParticipants() : void
		{
			users.removeAll();
		}
				
		public function newUserStatus(userid : Number, status : String) : void
		{
			var aUser : User;
			var usersArr : Array = users.source;
			
			for (var i:int = 0; i < usersArr.length; i++)
			{
				aUser = User(usersArr[i]);
				
				if (aUser.userid == userid) {
					aUser.status = status;
				}
			}		
			
			users.source.sortOn("username", Array.CASEINSENSITIVE);	
			users.refresh();		
		}
		
		public function open(userId:Number):void
		{
		}
		
		public function getApplicationId():String
		{
			return null;
		}
		
		public function close():void
		{
			users.source.splice(0);
		}
		
	}
}
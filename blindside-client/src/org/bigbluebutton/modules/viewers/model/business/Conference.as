package org.bigbluebutton.modules.viewers.model.business
{
	import mx.collections.ArrayCollection;
	
	import org.bigbluebutton.modules.viewers.model.vo.User;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class Conference extends Mediator implements IMediator
	{
		public static const NAME:String = "Conference";
		
		private var _myUserid : Number;
		
		[Bindable] public var me:User = null;		
		[Bindable] public var users : ArrayCollection = null;				
		[Bindable] public var connected : Boolean = false;
		
		public var connectFailReason : String;		
		public var host : String;
		public var room : String;
		
		public function Conference() : void
		{
			super(NAME);
			me = new User();
			users = new ArrayCollection();
		}

		public function addUser(newuser : User) : void
		{				
			if (! hasParticipant(newuser.userid)) {						
				users.addItem(newuser);
				sort();
			}					
		}

		public function hasParticipant(id : Number) : Boolean
		{
			var index : int = getParticipantIndex(id);
			
			if (index > -1) {
				return true;
			}
						
			return false;		
		}
		
		public function getParticipant(id : Number) : User
		{
			var index : int = getParticipantIndex(id);
			
			if (index > -1) {
				return users.getItemAt(index) as User;
			}
						
			return null;				
		}

		public function removeParticipant(userid : Number) : void
		{
			var index : int = getParticipantIndex(userid);
			
			//log.debug( "removing user[" + userid + " at index=" + index + "]")
			
			if (index > -1) {
				//log.debug( "remove user[" + userid + " at index=" + index + "]");
				
				users.removeItemAt(index);
				sort();
			}							
		}
		
		private function getParticipantIndex(userid : Number) : int
		{
			var aUser : User;
			
			for (var i:int = 0; i < users.length; i++)
			{
				aUser = users.getItemAt(i) as User;
				
				if (aUser.userid == userid) {
					return i;
				}
			}				
			
			// Participant not found.
			return -1;
		}

		public function removeAllParticipants() : void
		{
			users.removeAll();
		}		

		public function newUserStatus(id : Number, newStatus : String) : void
		{
			var aUser : User = getParticipant(id);
			
			if (aUser != null) {
				aUser.status = newStatus;
			}	
			
			sort();		
		}
		
		private function sort() : void
		{
			users.source.sortOn("name", Array.CASEINSENSITIVE);	
			users.refresh();				
		}				
	}
}
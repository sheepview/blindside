package org.blindsideproject.core.apps.appshare.business
{
	public class AppshareDelegate
	{
		private var appSO : SharedObject;
		
		
		private function connect() : void
		{
			appSO = SharedObject.getRemote("chatSO", connDelegate.connUri, true);
			appSO.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			appSO.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			appSO.addEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
			
			appSO.client = this;

			appSO.connect(connDelegate.getConnection());
			
			// Query who are the participants within this conference
			//chatSO.send("getParticipants");
		}
	}
}
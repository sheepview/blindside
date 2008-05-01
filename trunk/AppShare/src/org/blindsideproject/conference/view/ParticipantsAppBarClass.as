package org.blindsideproject.conference.view
{
	import mx.containers.ApplicationControlBar;

   	import org.blindsideproject.conference.view.general.Images;		
	public class ParticipantsAppBarClass extends ApplicationControlBar
	{
   		private var images : Images = new Images();
   		   		
   		[Bindable]
   		protected var appBarIcon : Object = images.participants_img;	
	}
}
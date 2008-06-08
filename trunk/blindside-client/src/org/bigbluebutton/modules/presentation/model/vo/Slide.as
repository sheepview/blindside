package org.bigbluebutton.modules.presentation.model.vo
{
	        
	/**
	 * This class represents a slide 
	 * @author dzgonjan
	 * 
	 */	        
	[Bindable]
	public class Slide
	{	    
		public var name : String;
		public var title : String;
		public var source : String;
		 
		public function Slide(slide : Object = null)
		{
			if (slide != null)
			{
				this.name = slide.name;
//				this.title = slide.description;
				this.source = slide.source;
				//log.debug("Slide [" + name + "][" + source + "]");				
			}
		}
	}
}
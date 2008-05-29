package org.bigbluebutton.modules.presentation.model.vo
{
	import org.blindsideproject.core.util.log.*;
	        
	[Bindable]
	public class Slide
	{
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		    
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
				log.debug("Slide [" + name + "][" + source + "]");				
			}
		}
	}
}
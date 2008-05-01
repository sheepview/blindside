
package org.blindsideproject.presentation.vo
{
	import org.blindsideproject.util.components.logger.model.*;
	import org.blindsideproject.presentation.model.*;
	        
	[Bindable]
	public class Slide
	{
		private var model : PresentationModelLocator = PresentationModelLocator.getInstance();  
		private var log : Logger = model.getLogger();
		    
		public var name : String;
		public var title : String;
		public var source : String;
		 
		public function Slide(slide : Object = null)
		{
			if (slide != null)
			{
				this.name = slide.name;
				this.title = slide.title;
				this.source = slide.source;
			}
		}
	}
}
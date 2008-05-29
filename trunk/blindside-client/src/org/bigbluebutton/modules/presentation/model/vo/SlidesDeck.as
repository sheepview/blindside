package org.bigbluebutton.modules.presentation.model.vo
{
	import org.blindsideproject.core.util.log.*;
	
	import mx.collections.ICollectionView;
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	
	/**
	 * This class represents a SlidesDeck, a collection of Slide object 
	 * @author dzgonjan
	 * 
	 */	
	[Bindable]
	public class SlidesDeck
	{
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		public var name : String;
		public var title : String;
		public var slides : ArrayCollection;
		public var selected : int;

		private var slide : Slide;
		
		private var defaultSlide : DefaultSlide = new DefaultSlide();
		
		public function SlidesDeck(presentation : Object = null)
		{
			slides = new ArrayCollection();
			if (presentation != null)
			{
				fill(presentation);
			}
		}
		
		public function fill(presentation : Object):void
		{
			this.name = presentation.id;
			this.title = presentation.description;
			this.selected = 0;
			
			log.debug("Presentation: name=[" + name + "] title=[" + title + "]");
			
			if (presentation.slide == null) {
				log.debug("Presentation: slide = null");
				return;
			}

			if (presentation.slide.length == null) {
 				log.debug("Presentation: slidesName = [" + presentation.slide.name + "]");
				log.debug("Presentation: slidesName = [" + presentation.slide.source + "]");				
				
				slide = new Slide(presentation.slide);
				slides.addItem(slide);
			} else {
				log.debug("Presentation: slides = [" + presentation.slide.length + "]");
			
				for (var i:int=0; i < presentation.slide.length; i++)
				{
					log.debug("Creating slide[" + i + "]");
			
					slide = new Slide(presentation.slide[i]);
					slides.addItem(slide);
				}				
			}			
		}
		
		public function displayDefaultSlide() : void
		{
			slides.removeAll();
			slides.addItem(defaultSlide);
		}
	}
}
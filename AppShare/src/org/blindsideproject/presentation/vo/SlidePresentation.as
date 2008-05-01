
package org.blindsideproject.presentation.vo
{
	import mx.collections.ICollectionView;
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	
	[Bindable]
	public class SlidePresentation
	{
		public var name : String;
		public var title : String;
		public var slides : ArrayCollection;
		public var selected : int;

		private var slide : Slide;
		
		public function SlidePresentation(presentation : Object = null)
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
			this.title = title.description;
			this.selected = 0;
			
			if (presentation.slide == null) return;
			
			for (var i:int=0; i < presentation.slide.length; i++)
			{
				slide = new Slide(presentation.slide[i]);
				slides.addItem(slide);
			}
		}
	}
}
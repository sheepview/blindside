package model
{
	import business.DrawDelegate;
	
	import com.adobe.cairngorm.CairngormError;
	import com.adobe.cairngorm.CairngormMessageCodes;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.model.IModelLocator;
	
	import control.DrawController;
	
	public class DrawModelLocator implements IModelLocator
	{
		private var dispatcher:CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
		
		private static var modelLocator:DrawModelLocator;
		private var controller:DrawController = null;
		private var drawDelegate:DrawDelegate;
		
		[Bindable]
		public var draw:DrawModel = new DrawModel();
		
		public function DrawModelLocator()
		{
			if ( modelLocator != null )
					throw new CairngormError(
					   CairngormMessageCodes.SINGLETON_EXCEPTION, "DrawModelLocator" );
					   
		    initialize();	
		}
		
		public static function getInstance() : DrawModelLocator
		{
			if ( modelLocator == null )
				modelLocator = new DrawModelLocator();
				
			return modelLocator;
	   	}
		
		public function initialize():void{
			this.controller = new DrawController();
		}
		
		public function getDispatcher() : CairngormEventDispatcher
	    {
	   		return dispatcher;
	   	}
	   	
	   	public function getDrawDelegate():DrawDelegate
	   	{
	   		if (drawDelegate == null) {
	   			drawDelegate = new DrawDelegate();
	   		}
	   		
	   		return drawDelegate;
	   	}	

	}
}
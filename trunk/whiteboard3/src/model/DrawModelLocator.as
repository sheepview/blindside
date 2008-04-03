package model
{
	import business.DrawDelegate;
	
	import com.adobe.cairngorm.CairngormError;
	import com.adobe.cairngorm.CairngormMessageCodes;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.model.IModelLocator;
	
	import control.DrawController;
	
	/**
	 * A signleton class that holds references to all components of the Whiteboard application 
	 * @author Denis
	 * 
	 */	
	public class DrawModelLocator implements IModelLocator
	{
		private var dispatcher:CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
		
		private static var modelLocator:DrawModelLocator;
		private var controller:DrawController = null;
		private var drawDelegate:DrawDelegate;
		
		[Bindable]
		public var draw:DrawModel = new DrawModel();
		
		/**
		 * The default constructor. Should not be called from the outside, however ActionScript does not support
		 * constructors being declared private. If you wish to get a DrawModelLocator object, you should instead
		 * call the getInstance() static method.
		 * 
		 */		
		public function DrawModelLocator()
		{
			if ( modelLocator != null )
					throw new CairngormError(
					   CairngormMessageCodes.SINGLETON_EXCEPTION, "DrawModelLocator" );
					   
		    initialize();	
		}
		
		/**
		 * A signleton pattern method to get the object of this class 
		 * @return the unique instance of DrawModelLocator
		 * 
		 */		
		public static function getInstance() : DrawModelLocator
		{
			if ( modelLocator == null )
				modelLocator = new DrawModelLocator();
				
			return modelLocator;
	   	}
		
		/**
		 * Instantiates the DrawController. Method is called from the constructor 
		 * 
		 */		
		private function initialize():void{
			this.controller = new DrawController();
		}
		
		/**
		 *  A convinience method to return the CairngormEventDispatcher
		 * <p>
		 * NOTE: Returns the same object as CairngormEventDispatcher.getInstance()
		 * @return the event dispatcher of this application 
		 * 
		 */		
		public function getDispatcher() : CairngormEventDispatcher
	    {
	   		return dispatcher;
	   	}
	   	
	   	/**
	   	 * A method to get the DrawDelegate
	   	 * @return The Red5 Service Delegate of this application
	   	 * 
	   	 */	   	
	   	public function getDrawDelegate():DrawDelegate
	   	{
	   		if (drawDelegate == null) {
	   			drawDelegate = new DrawDelegate();
	   		}
	   		
	   		return drawDelegate;
	   	}	

	}
}
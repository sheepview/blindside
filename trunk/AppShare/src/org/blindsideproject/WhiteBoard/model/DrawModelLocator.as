package org.blindsideproject.WhiteBoard.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import com.adobe.cairngorm.CairngormError;
	import org.blindsideproject.WhiteBoard.vo.DrawVO;
	import com.adobe.cairngorm.*;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	public class DrawModelLocator implements IModelLocator
	{
		private static var modelLocator:DrawModelLocator;
		
		private var dispatcher:CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
		
		public var drawVO:DrawVO;
		public var draw:Draw;
		
		public function DrawModelLocator(){
			if (modelLocator != null){
				throw new CairngormError( CairngormMessageCodes.SINGLETON_EXCEPTION, "DrawModelLocator");
			}
		}
		
		public static function getInstance():DrawModelLocator{
			if (modelLocator == null){
				modelLocator = new DrawModelLocator();
			}
			
			return modelLocator;
		}
		
		public function setupDrawRoom():void{
			drawVO = new DrawVO();
			draw = new Draw();
		}
		
		public function getDispatcher():CairngormEventDispatcher{
			return dispatcher;
		}
	}
}
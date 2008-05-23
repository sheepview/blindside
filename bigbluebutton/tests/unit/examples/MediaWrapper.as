package examples
{
	import mx.binding.utils.BindingUtils;
// 	import org.blindsideproject.core.util.log.ILogger;
//	import org.blindsideproject.core.util.log.LoggerModelLocator;
				
	public class MediaWrapper
	{
//		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		private var _x : String = "orig";
		
		[Bindable] public function get x() : String
		{
//			log.debug("Return x as [" + _x + "]");
			return _x;
		}
		
		private function handlex(value : String) : void
		{
			x = value;
		}
		
		private function set x(value : String) : void
		{
			_x = value;
//			log.debug("Set x to [" + value + "]");

		}
		private var _m : Media;
		
		public function MediaWrapper(m : Media)
		{
			_m = m;
			BindingUtils.bindSetter(handlex, _m, "y");
		}
	}
}
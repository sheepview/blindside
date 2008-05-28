package org.bigbluebutton.modules.chat.model
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	import org.bigbluebutton.modules.chat.model.vo.MessageVO;
	
	public class MessageVOTest extends TestCase
	{
		
		public var messageVO:MessageVO = new MessageVO();
		messageVO.message = "Hello";
		messageVO.color = 0x000;
		public function MessageVOTest(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite 
		{
               var ts:TestSuite = new TestSuite();
               ts.addTest(new MessageVOTest("testGetMessage"));
               ts.addTest(new MessageVOTest("testGetColor"));
               return ts;
        }
        public function testGetMessage():void {
			
			assertTrue("Expecting a string type", messageVO.message == "Hello");
		}
		public function testGetColor():void {
			assertTrue("Expecting a uint type", messageVO.color , 0x000);
		}
		   

	}
}
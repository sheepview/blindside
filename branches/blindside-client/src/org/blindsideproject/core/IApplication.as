package org.blindsideproject.core
{
	public interface IApplication
	{
		function open(userId : Number) : void;
		
		function close() : void;	
		
		function getApplicationId() : String;
			
	}
}
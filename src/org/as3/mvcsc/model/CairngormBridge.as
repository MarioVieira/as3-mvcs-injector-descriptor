package org.as3.mvcsc.model
{
	import org.as3.mvcsc.descriptors.DescriptorCairngormEventMap;
	import org.as3.mvcsc.descriptors.DescriptorCairngormModelLocator;

	public class CairngormBridge
	{
		public function CairngormBridge()
		{
			descriptorCollection   = new Vector.<DescriptorCairngormEventMap>();	
			cairngornModelLocators = new Vector.<DescriptorCairngormModelLocator>();
		}
		
		[Serialize] public var descriptorCollection   : Vector.<DescriptorCairngormEventMap>;
		[Serialize] public var cairngornModelLocators : Vector.<DescriptorCairngormModelLocator>; 
		
		[Serialize] public var test:int = 0;
	}
}
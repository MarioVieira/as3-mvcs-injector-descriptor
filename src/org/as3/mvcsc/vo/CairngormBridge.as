package org.as3.mvcsc.vo
{
	import org.as3.mvcsc.descriptors.DescriptorCairngormEventMap;
	import org.as3.mvcsc.descriptors.DescriptorCairngormModelLocator;

	/**
	 * 
	 * 
	 * The value object for intercepting a Cairngorm event to a Command into a VO / Signal broadcast
	 * 
	 * @author Mario Vieira
	 */
	public class CairngormBridge
	{
		/** @private **/
		public function CairngormBridge()
		{
			descriptorCollection   = new Vector.<DescriptorCairngormEventMap>();	
			cairngornModelLocators = new Vector.<DescriptorCairngormModelLocator>();
		}
		
		/**
		 * 
		 */
		public var descriptorCollection   : Vector.<DescriptorCairngormEventMap>;
		/**
		 * 
		 */
		public var cairngornModelLocators : Vector.<DescriptorCairngormModelLocator>; 
	}
}
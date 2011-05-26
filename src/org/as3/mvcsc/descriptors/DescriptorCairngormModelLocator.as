package org.as3.mvcsc.descriptors
{

	/**
	 * 
	 * 
	 * The Cairngorm ModelLocators for making them available for the Bridge
	 * @see org.as3.bridge.core.Bridge
	 * 
	 * @author Mario Vieira
	 */
	public class DescriptorCairngormModelLocator
	{
		/**
		 * 
		 */
		[Serialize] public var nick						:String;
		/**
		 * 
		 */
		[Serialize] public var uid						:uint;
		/**
		 * 
		 */
		[Serialize] public var modelLocatorQName		:String;
	}
}
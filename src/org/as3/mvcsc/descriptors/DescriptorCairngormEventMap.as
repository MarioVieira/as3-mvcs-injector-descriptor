package org.as3.mvcsc.descriptors
{
	/**
	 * 
	 * CairngormEvent for injection mapping
	 * @author Mario Vieira  
	 * 
	 */
	public class DescriptorCairngormEventMap
	{
		/**
		 * 
		 */
		[Serialize] public var valueObjectQNameToReceiveEventProperties	:String;
		/**
		 * 
		 */
		[Serialize] public var cairngormEventQName						:String;
		/**
		 * 
		 */
		[Serialize] public var cairngormEventType						:String;
		/**
		 * 
		 */
		[Serialize] public var signalClassQName							:String;
	}	
}
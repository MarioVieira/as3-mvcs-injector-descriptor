package org.as3.mvcsc.descriptors
{
	/**
	 * 
	 * Background Processes descriptor for injection mapping
	 * 
	 * @author Mario Vieira 
	 * 
	 */
	public class DescriptorBackgroundProcess
	{
		
		/**
		 * 
		 */
		[Serialize] public var backgroundServiceInterfaceQName	:String;
		/**
		 * 
		 */
		[Serialize] public var executeInjection					:Boolean = true;
		/**
		 * 
		 */
		[Serialize] public var executeSignalCommandMapping		:Boolean = true;
	}
}
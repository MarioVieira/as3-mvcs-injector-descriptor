package org.as3.mvcsc.vo
{
	import org.as3.mvcsc.descriptors.DescriptorSignalCommand;

	/**
	 * 
	 * 
	 * Value object for the XML based SignalCommands mapping
	 * 
	 * @author Mario Vieira
	 */
	public class Commands
	{
		/** @private **/
		public function Commands()
		{	
			descriptorCollection = new Vector.<DescriptorSignalCommand>();
		}
		
		/**
		 * 
		 */
		[Serialize] public var descriptorCollection:Vector.<DescriptorSignalCommand>;
	}
}
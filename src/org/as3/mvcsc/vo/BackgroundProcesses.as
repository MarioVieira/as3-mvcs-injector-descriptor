package org.as3.mvcsc.vo
{
	import org.as3.mvcsc.descriptors.DescriptorBackgroundProcess;

	/**
	 * 
	 * 
	 * Value object for the XML based BackgroundProcesses mapping
	 *  
	 * @author Mario Vieira 
	 */
	public class BackgroundProcesses
	{
		/** @private **/
		public function BackgroundProcesses()
		{	
			descriptorCollection = new Vector.<DescriptorBackgroundProcess>();
		}
		
		/**
		 * 
		 */
		[Serialize] public var descriptorCollection:Vector.<DescriptorBackgroundProcess>;
	}
}
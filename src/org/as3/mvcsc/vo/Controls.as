package org.as3.mvcsc.vo
{
	import org.as3.mvcsc.descriptors.DescriptorInjector;

	/**
	 * 
	 * 
	 * Value object for the XML based Controls mapping
	 * 
	 * @author Mario Vieira
	 */
	public class Controls
	{
		/** @private **/
		public function Controls()
		{	
			descriptorCollection = new Vector.<DescriptorInjector>();
		}
		
		/**
		 * 
		 */
		[Serialize] public var descriptorCollection:Vector.<DescriptorInjector>;
	}
}
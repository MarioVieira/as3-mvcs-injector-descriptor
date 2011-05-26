package org.as3.mvcsc.vo
{
	import org.as3.mvcsc.descriptors.DescriptorInjector;

	/**
	 * 
	 * 
	 * Value object for the XML based Services mapping
	 * 
	 * @author Mario Vieira
	 */
	public class Services
	{
		/**
		 * @private
		 */
		public function Services()
		{
			descriptorCollection = new Vector.<DescriptorInjector>();
		}
		
		/**
		 * 
		 */
		[Serialize] public var descriptorCollection:Vector.<DescriptorInjector>;
	}
}
package org.as3.mvcsc.vo
{
	import org.as3.mvcsc.descriptors.DescriptorInjector;

	/**
	 * 
	 * 
	 * Value object for the XML based Models mapping
	 * 
	 * @author Mario Vieira
	 */
	public class Models
	{
		/** private **/
		public function Models()
		{
			descriptorCollection = new Vector.<DescriptorInjector>();
		}
		
		[Serialize] public var descriptorCollection:Vector.<DescriptorInjector>;
	}
}
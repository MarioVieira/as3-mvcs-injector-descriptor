package org.as3.mvcsc.model
{
	import org.as3.mvcsc.descriptors.DescriptorInjector;

	public class Services
	{
		public function Services()
		{
			descriptorCollection = new Vector.<DescriptorInjector>();
		}
		
		[Serialize] public var descriptorCollection:Vector.<DescriptorInjector>;
	}
}
package org.as3.mvcsc.model
{
	import org.as3.mvcsc.descriptors.DescriptorInjector;

	public class Controls
	{
		public function Controls()
		{	
			descriptorCollection = new Vector.<DescriptorInjector>();
		}
		
		[Serialize] public var descriptorCollection:Vector.<DescriptorInjector>;
	}
}
package org.as3.mvcsc.descriptors
{
	public class DescriptorControlsMapping
	{
		[Serialize] public var descriptorCollection:Vector.<DescriptorInjector>;
		
		public function DescriptorControlsMapping()
		{
			descriptorCollection = new Vector.<DescriptorInjector>();
		}
	}
}
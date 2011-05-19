package org.as3.mvcsc.model
{
	import org.as3.mvcsc.descriptors.DescriptorMediator;

	public class Views
	{
		public function Views()
		{
			descriptorCollection = new Vector.<DescriptorMediator>();
		}
		
		[Serialize] public var descriptorCollection:Vector.<DescriptorMediator>;
	}
}
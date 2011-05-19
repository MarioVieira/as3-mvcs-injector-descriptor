package org.as3.mvcsc.model
{
	import org.as3.mvcsc.descriptors.DescriptorBackgroundProcess;

	public class BackgroundProcesses
	{
		public function BackgroundProcesses()
		{	
			descriptorCollection = new Vector.<DescriptorBackgroundProcess>();
		}
		
		[Serialize] public var descriptorCollection:Vector.<DescriptorBackgroundProcess>;
	}
}